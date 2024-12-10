import 'package:asset_tracker_app/services/firebase/firebase_auth_service.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:flutter/material.dart';

mixin LoginScreenMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuthService authService = FirebaseAuthService();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void updateLoadingState(bool loading) {
    if (mounted) {
      setState(() => isLoading = loading);
    }
  }

  void navigateToHome() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, ToScreen.homePage);
    }
  }

  void showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> handleLogin() async {
    if (!validateForm()) return;

    updateLoadingState(true);

    try {
      final success = await authService.signIn(
        emailController.text,
        passwordController.text,
      );

      if (success) {
        navigateToHome();
      }
    } catch (e) {
      showErrorMessage(e.toString());
    } finally {
      updateLoadingState(false);
    }
  }
}

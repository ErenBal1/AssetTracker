import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/auth/auth_event.dart';
import 'package:asset_tracker_app/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin LoginScreenMixin<LoginScreenState extends StatefulWidget>
    on State<LoginScreenState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _errorMessageDuration = 3;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validateForm() => formKey.currentState?.validate() ?? false;

  void showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: _errorMessageDuration),
        ),
      );
    }
  }

  void handleLoginButtonPress(BuildContext context, AuthState state) {
    if (validateForm()) {
      context.read<AuthBloc>().add(
            SignInRequested(
              emailController.text,
              passwordController.text,
            ),
          );
    }
  }

  bool isButtonEnabled(AuthState state) {
    return state is AuthLoading ? false : true;
  }
}

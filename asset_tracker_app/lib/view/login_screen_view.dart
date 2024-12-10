import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/services/firebase/auth_service.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/constants/sizedBox_constants.dart';
import 'package:asset_tracker_app/widgets/login_screen/email_input_field.dart';
import 'package:asset_tracker_app/widgets/login_screen/password_input_field.dart';
import 'package:flutter/material.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AuthService _authService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = AuthService();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _updateLoadingState(bool isLoading) {
    if (mounted) {
      setState(() => _isLoading = isLoading);
    }
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, ToScreen.homePage);
    }
  }

  void _showErrorMessage(String message) {
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

  Future<void> _handleLogin() async {
    if (!_validateForm()) return;

    _updateLoadingState(true);

    try {
      final success = await _authService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      if (success) {
        _navigateToHome();
      }
    } catch (e) {
      _showErrorMessage(e.toString());
    } finally {
      _updateLoadingState(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedboxConstants.sizedBoxBig,
                Icon(
                  Icons.inventory,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                SizedboxConstants.sizedBoxMedium,
                const Text(
                  LocalStrings.welcome,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedboxConstants.sizedBoxBig,
                EmailInputField(controller: _emailController),
                SizedboxConstants.sizedBoxSmall,
                PasswordInputField(controller: _passwordController),
                SizedboxConstants.sizedBoxMedium,
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(LocalStrings.signIn),
                ),
                SizedboxConstants.sizedBoxSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

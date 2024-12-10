import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/empty_size.dart';
import 'package:asset_tracker_app/utils/mixins/login_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/login_screen/email_input_field.dart';
import 'package:asset_tracker_app/widgets/login_screen/login_button.dart';
import 'package:asset_tracker_app/widgets/login_screen/password_input_field.dart';
import 'package:flutter/material.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView>
    with LoginScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const EmptySize.big(),
                Icon(
                  Icons.inventory,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const EmptySize.medium(),
                const Text(
                  LocalStrings.welcome,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const EmptySize.big(),
                EmailInputField(controller: emailController),
                const EmptySize.small(),
                PasswordInputField(controller: passwordController),
                const EmptySize.medium(),
                LoginButton(
                  onPressed: isLoading ? null : handleLogin,
                  isLoading: isLoading,
                  text: LocalStrings.signIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

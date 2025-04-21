import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/auth/auth_event.dart';
import 'package:asset_tracker_app/bloc/auth/auth_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/validators/form_validator.dart';
import 'package:asset_tracker_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SignupViewMixin<SignupViewMixinState extends StatefulWidget>
    on State<SignupViewMixinState> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() {
    if (!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          SignUpRequested(
            emailController.text.trim(),
            passwordController.text,
            firstNameController.text.trim(),
            lastNameController.text.trim(),
          ),
        );
  }

  void authListener(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ToScreen.mainWrapper,
        (_) => false,
      );
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  List<Widget> buildFormFields() {
    return [
      CustomTextField(
        controller: firstNameController,
        label: LocalStrings.firstName,
        validator: FormValidator.validateName,
      ),
      const GapSize.small(),
      CustomTextField(
        controller: lastNameController,
        label: LocalStrings.lastName,
        validator: FormValidator.validateName,
      ),
      const GapSize.small(),
      CustomTextField(
        controller: emailController,
        label: LocalStrings.emailLabel,
        keyboardType: TextInputType.emailAddress,
        validator: FormValidator.validateEmail,
      ),
      const GapSize.small(),
      CustomTextField(
        controller: passwordController,
        label: LocalStrings.passwordLabel,
        obscureText: true,
        validator: FormValidator.validatePassword,
      ),
    ];
  }

  Widget buildSignUpButton(AuthState state) {
    final isLoading = state is AuthLoading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : signUp,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text(LocalStrings.signUp),
      ),
    );
  }

  Widget buildSignInTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, ToScreen.loginPage);
      },
      child: const Text(LocalStrings.alreadyHaveAcc),
    );
  }
}

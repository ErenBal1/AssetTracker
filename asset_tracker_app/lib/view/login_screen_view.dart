import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/utils/mixins/login_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/custom_icon_widget.dart';
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
          padding: ConstantPaddings.allXL,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const GapSize.big(),
                const CustomIcon(icon: Icons.inventory),
                const GapSize.medium(),
                const Text(
                  LocalStrings.welcome,
                  style: ConstantTextStyles.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const GapSize.big(),
                EmailInputField(controller: emailController),
                const GapSize.small(),
                PasswordInputField(controller: passwordController),
                const GapSize.medium(),
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

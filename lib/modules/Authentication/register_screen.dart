
import 'package:event_app/modules/Authentication/widgets/text_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/routes/app_routes_name.dart';
import '../../core/config/services/settings_config.dart';
import '../../core/config/theme/app_colors.dart';
import '../../main.dart';
import '../layout/widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {


    TextEditingController nameController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    ThemeData theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlylogo.image(width: 140, height: 30),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 48),
            Text(
              "Create your account",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            TextFieldButton(
              icon: Assets.icons.user.svg(),
              text: "Enter your user name",
              controller: nameController,
            ),

            SizedBox(height: 24),
            TextFieldButton(
              icon: Assets.icons.email.svg(),
              text: "Enter your email",
              controller: emailController,
            ),

            SizedBox(height: 24),

            TextFieldButton(
              icon: Assets.icons.lock.svg(),
              text: "Enter your password",
              controller: passwordController,
              suficon: GestureDetector(
                onTap: () {
                  isPassword = !isPassword;
                  setState(() {});
                },
                child: isPassword
                    ? Assets.icons.eyeslash.svg(width: 24, height: 24)
                    : Icon(Icons.remove_red_eye),
              ),
              isPassword: isPassword,
            ),
            SizedBox(height: 16),
            TextFieldButton(
              icon: Assets.icons.lock.svg(),
              text: "Confirm your password",
              controller: passwordController,
              suficon: GestureDetector(
                onTap: () {
                  isPassword = !isPassword;
                  setState(() {});
                },
                child: isPassword
                    ? Assets.icons.eyeslash.svg(width: 24, height: 24)
                    : Icon(Icons.remove_red_eye),
              ),
              isPassword: isPassword,
            ),
            SizedBox(height: 58),
            Button(
              text: "Sign up",
              onPressed: () {},
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 48),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "Already have an account?",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: settingsConfig.currentTheme == ThemeMode.light
                      ? LightThemeColors.secondaryText
                      : DarkThemeColors.secondaryText,
                ),
                children: [
                  WidgetSpan(
                    child: Bounce(
                      onPressed: () {
                        navigatorKey.currentState!.pushReplacementNamed(
                          AppRoutesName.login,
                        );
                      },
                      duration: Duration(milliseconds: 210),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text.rich(
                          TextSpan(
                            text: "Login",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Or",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Bounce(
              duration: Duration(milliseconds: 110),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    color: settingsConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.stroke
                        : DarkThemeColors.stroke,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: settingsConfig.currentTheme == ThemeMode.light
                      ? LightThemeColors.inputs
                      : DarkThemeColors.inputs,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Assets.icons.googlePng.image(width: 24,height: 24),
                    Center(
                      child: Text(
                        "Sign up with Google",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

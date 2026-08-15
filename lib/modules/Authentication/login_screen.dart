import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/main.dart';
import 'package:event_app/modules/Authentication/widgets/text_field_button.dart';
import 'package:event_app/modules/Home/homescreen/home_screen_view.dart';
import 'package:event_app/modules/Home/widgets/loading_indicator.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/services/settings_config.dart';
import '../layout/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlylogo.image(width: 140, height: 30),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 48),
              Text(
                "Login to your account",
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldButton(
                      icon: Assets.icons.email.svg(),
                      text: "Enter your email",
                      controller: loginController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email";
                        }
        
                        final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
        
                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Please enter a valid email";
                        }
        
                        return null;
                      },
                    ),
        
                    const SizedBox(height: 16),
        
                    TextFieldButton(
                      icon: Assets.icons.lock.svg(),
                      text: "Enter your password",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
        
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
        
                        return null;
                      },
                      suficon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        child: isPassword
                            ? Assets.icons.eyeslash.svg(width: 24, height: 24)
                            : const Icon(Icons.remove_red_eye),
                      ),
                      isPassword: isPassword,
                    ),
        
                    TextButton(
                      onPressed: () {
                        navigatorKey.currentState!.pushNamed(
                          AppRoutesName.forgetPassword,
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?",
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 58),
        
                    Button(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          LoadingOverlay.show(message: "Logging....", context);
                          FireBaseServices().loginWithEmailAndPassword(
                            loginController.text.trim(),
                            passwordController.text.trim(),
                          );
                          navigatorKey.currentState!.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreenView(),
                            ),
                            (route) => false,
                          );
                          LoadingOverlay.hide();
                        }
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
        
                    const SizedBox(height: 48),
                  ],
                ),
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "Don't have an account? ",
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
                            AppRoutesName.register,
                          );
                        },
                        duration: Duration(milliseconds: 210),
                        child: Text.rich(
                          TextSpan(
                            text: "Sign up",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 16,
                      endIndent: 16,
                      color: settingsConfig.currentTheme == ThemeMode.light
                          ? LightThemeColors.stroke
                          : DarkThemeColors.stroke,
                    ),
                  ),
                  Text(
                    "Or",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Divider(
                      indent: 16,
                      endIndent: 16,
                      color: settingsConfig.currentTheme == ThemeMode.light
                          ? LightThemeColors.stroke
                          : DarkThemeColors.stroke,
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 24),
              Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () async{
                  final result = await FireBaseServices().signInWithGoogle();
        
                  if (result != null) {
                    navigatorKey.currentState!.pushReplacementNamed(
                      AppRoutesName.home,
                    );
                  }
                },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Assets.icons.googlePng.image(width: 24, height: 24),
                      Center(
                        child: Text(
                          "Login with Google",
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
      ),
    );
  }
}

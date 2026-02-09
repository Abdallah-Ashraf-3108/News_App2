import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/auth/register_screen.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  String? errorMessage;

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString('user_email');
    final savedPassword = PreferencesManager().getString('user_password');
    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No Account Found, Please Register First";
        isLoading = false;
      });
      return;
    }
    if (savedEmail != emailController.text.trim() ||
        savedPassword != passwordController.text.trim()) {
      setState(() {
        errorMessage = "Incorrect Email or Password";
        isLoading = false;
      });
      return;
    } else {
      await PreferencesManager().setBool('is_logged_in', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.r16),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: AppSizes.h45,
                      ),
                    ),
                    SizedBox(height: AppSizes.ph24),
                    Text(
                      'Welcome To Newst',
                      style: TextStyle(
                        fontSize: AppSizes.sp20,
                        fontWeight: FontWeight.w700,
                        color: LightColors.unselectedItemColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.ph16),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'abdoo@gmail.com',
                      title: 'Email',
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.ph16),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '*************',
                      title: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        return null;
                      },
                    ),
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    SizedBox(height: AppSizes.ph20),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomElevatedButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                    SizedBox(height: AppSizes.ph24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account ?",
                          style: TextStyle(
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w400,
                            color: LightColors.textPrimaryColor,
                          ),
                        ),
                        SizedBox(width: AppSizes.pw8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegisterScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: LightColors.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizes.sp14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

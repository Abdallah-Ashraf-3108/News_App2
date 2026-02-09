import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_colors.dart';
import '../../core/datasource/local_data/preference_manager.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  String? errorMessage;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferencesManager().getString('user_email');
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = 'Email already exists';
        isLoading = false;
      });
    } else {
      await PreferencesManager().setString(
        'username',
        usernameController.text.trim(),
      );
      await PreferencesManager().setString(
        'user_email',
        emailController.text.trim(),
      );
      await PreferencesManager().setString(
        'user_password',
        passwordController.text.trim(),
      );
      await PreferencesManager().setBool('is_logged_in', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
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
                      controller: usernameController,
                      hintText: 'Abdallah El_Hadad',
                      title: 'User Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    // SizedBox(height: AppSizes.ph16),
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
                    // SizedBox(height: AppSizes.ph16),
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
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      hintText: '*************',
                      title: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != passwordController.text.trim()) {
                          return 'Please confirm password must be equal to password ';
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
                          text: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              register();
                            }
                          },
                        ),
                    SizedBox(height: AppSizes.ph24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ?',
                          style: TextStyle(
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w400,
                            color: LightColors.textPrimaryColor,
                          ),
                        ),
                        SizedBox(width: AppSizes.pw8),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
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

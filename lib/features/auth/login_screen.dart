import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';
import 'package:news_app/features/auth/register_screen.dart';

import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 45),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome To Newst',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: LightColors.unselectedItemColor,
                  ),
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'abdoo@gmail.com',
                  title: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: '*************',
                  title: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final RegExp passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
                    );

                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must be at least 8 characters,\n'
                          'include upper, lower case letters and a number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, perform login
                    }
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account ?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: LightColors.textPrimaryColor,
                      ),
                    ),
                    SizedBox(width: 8),
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
                          fontSize: 14,
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
    );
  }
}

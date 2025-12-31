import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_colors.dart';

import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 45)),
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
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: passwordController,
                hintText: '*************',
                title: 'Password',
                obscureText: true,
              ),
              CustomTextFormField(
                controller: confirmPasswordController,
                hintText: '*************',
                title: 'Confirm Password',
                obscureText: true,
              ),
              SizedBox(height: 20),
              CustomElevatedButton(text: 'Sign Up', onPressed: () {}),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account ?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: LightColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
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
    );
  }
}

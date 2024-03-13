import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/validators/auth_validators.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_pallete.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (ctx) => const SignInPage());
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Height: ${MediaQuery.of(context).size.height}");
    print("Width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(15.0.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style:
                      TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                AuthField(
                  hintText: "Email",
                  validator: AuthValidators.emailValidator,
                  controller: emailController,
                ),
                SizedBox(
                  height: 15.h,
                ),
                AuthField(
                  validator: AuthValidators.passwordValidator,
                  hintText: "Password",
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AuthGradientButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //todo: execute the press function
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, SignUpPage.route());
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                          style: Theme.of(context).textTheme.titleMedium)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

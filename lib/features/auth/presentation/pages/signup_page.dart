import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/validators/auth_validators.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_pallete.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (ctx) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height - 200).h,
          padding: EdgeInsets.all(15.0.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style:
                      TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                AuthField(
                  hintText: "Name",
                  controller: nameController,
                  validator: AuthValidators.nameValidator,
                ),
                SizedBox(
                  height: 15.h,
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
                  buttonText: "Sign Up",
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
                    Navigator.pop(context);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign In",
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

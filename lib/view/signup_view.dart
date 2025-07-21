import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/res/app_colors.dart';
import 'package:quiz_app/res/components/custom_button.dart';
import 'package:quiz_app/res/components/custom_text_form_field.dart';
import 'package:quiz_app/utils/routes/route_name.dart';
import 'package:quiz_app/view_model/password_view_model.dart';

import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final passwordViewModel = Provider.of<PasswordViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Center(
                child: Image(
                  height: 100.h,
                  width: 100.w,
                  image: AssetImage('images/logo.png'),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              CustomTextFormField(
                hintText: 'Enter your Name',
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              CustomTextFormField(
                controller: passwordController,
                hintText: 'Enter your Password',
                prefixIcon: Icon(Icons.lock_open),
                isPassword: true,
                obscureText: passwordViewModel.obscureText,
                onToggleVisibility: passwordViewModel.toggleVisibility,
              ),
              SizedBox(height: 80.h),
              Consumer<AuthViewModel>(
                builder: (context, provider, _) {
                  return CustomButton(
                    title: 'Sign Up',
                    isLoading: provider.isLoading,
                    onPressed: () {
                      provider.signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an Account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp
                    ),
                  ),
                  SizedBox(width: 2.h,),
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.loginView);
                      },
                      child: Text('Log In',style: TextStyle(color: AppColors.mainThemeColor,fontSize: 16.sp,fontWeight: FontWeight.bold)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

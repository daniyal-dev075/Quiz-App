import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/res/app_colors.dart';
import 'package:quiz_app/res/components/custom_button.dart';
import 'package:quiz_app/utils/routes/route_name.dart';

import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  Widget _instructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('✓ ', style: TextStyle(fontSize: 18.sp, color: Colors.green, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: AppColors.mainThemeColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){
              SystemNavigator.pop();
            }, icon: Icon(Icons.exit_to_app_outlined,color: Colors.white,))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Image(
                  height: 100.h,
                  width: 100.w,
                  image: AssetImage('images/logo.png'),
                ),
              ),
              Center(
                child: Text(
                  'Instructions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0), // light orange background
                    border: Border.all(color: Colors.deepOrange,width: 2), // dark border
                    borderRadius: BorderRadius.circular(12), // rounded corners (optional)
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // align text to the left
                    children: [
                      widget._instructionItem('This quiz contains 10 questions.'),
                      widget._instructionItem('Each question carries 1 mark.'),
                      widget._instructionItem('You will get 15 seconds to answer each question.'),
                      widget._instructionItem('Only one option is correct for each question.'),
                      widget._instructionItem('After 15 seconds, the question will be skipped automatically.'),
                      widget._instructionItem('Try to score as much as you can!'),
                    ],
                  ),
                ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: SwipeButton.expand(
                  thumb: Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 24),
                  activeThumbColor: AppColors.mainThemeColor,
                  activeTrackColor: Colors.grey.shade300,
                  child: Text(
                    'Swipe to Start Quiz',
                    style: TextStyle(color: AppColors.mainThemeColor, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                  onSwipe: () => Navigator.pushNamed(context, RouteName.quizView),
                ),
              ),
              SizedBox(height: 20.h,),
              Consumer<AuthViewModel>(
                builder: (context, provider, _) {
                  return CustomButton(
                    title: 'Log Out',
                    isLoading: provider.isLoading,
                    onPressed: () {
                      provider.logout(context);
                    },
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utils/routes/route_name.dart';
import 'package:quiz_app/utils/routes/routes.dart';
import 'package:quiz_app/view_model/auth_view_model.dart';
import 'package:quiz_app/view_model/password_view_model.dart';
import 'package:quiz_app/view_model/question_view_model.dart';

import 'data/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // use only if using FlutterFire CLI
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordViewModel()),
        ChangeNotifierProvider(create: (_) => QuestionViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteName.splashView,
            onGenerateRoute: Routes.generateRoute,
          );
        }
    );
  }
}


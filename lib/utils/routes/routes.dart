import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_app/utils/routes/route_name.dart';
import 'package:quiz_app/view/login_view.dart';
import 'package:quiz_app/view/quiz_view.dart';
import 'package:quiz_app/view/score_view.dart';
import 'package:quiz_app/view/signup_view.dart';
import 'package:quiz_app/view/start_view.dart';

import '../../view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashView:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashView(),
        );
      case RouteName.loginView:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        );
      case RouteName.startView:
        return MaterialPageRoute(
          builder: (BuildContext context) => StartView(),
        );
      case RouteName.signupView:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignupView(),
        );
    case RouteName.quizView:
    return MaterialPageRoute(
    builder: (BuildContext context) => QuizView(),
    );
      case RouteName.scoreView:
        return MaterialPageRoute(
          builder: (BuildContext context) => ScoreView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: Text('No Route Found'))],
              ),
            );
          },
        );
    }
  }
}

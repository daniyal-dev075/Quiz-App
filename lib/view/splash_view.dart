import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashServices.isLogin(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spin(
                duration: Duration(milliseconds: 3000),
                child: Center(child: Image(
                    height: 400,
                    width: 400,
                    image: AssetImage('images/logo.png'))),
              )
            ],
          ),
          ]
        ),
      ),
    );
  }
}
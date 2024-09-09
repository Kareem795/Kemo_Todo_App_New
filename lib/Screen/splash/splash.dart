import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Screen/Home/home.dart';

class Splash extends StatefulWidget 
{
  static const String routeNamed = "Splash";

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
  void initState() 
  {
    super.initState();
    Future.delayed
    (
      const Duration(seconds: 2),
      () 
      {
        Navigator.pushReplacementNamed(context, Home.routeNamed);
      },
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      decoration: const BoxDecoration
      (
        image: DecorationImage
        (
          image: AssetImage("assets/images/splash_background.png"),
          fit: BoxFit.cover
        )
      ),
      child: const Scaffold
      (
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/UI/Screen/Home/home.dart';
import 'package:kemo_todo_app_2/UI/Utils/app_theme.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      theme: App_Theme.light,
      darkTheme: App_Theme.Dark,
      routes: {
        Home.route_named: (_) => const Home(),
      },
      initialRoute: Home.route_named,
    );
  }
}

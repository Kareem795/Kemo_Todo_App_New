import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Screen/Home/home.dart';
import 'package:kemo_todo_app_2/Screen/Edit/edit_screen.dart';
import 'package:kemo_todo_app_2/Screen/splash/splash.dart';

import 'Firebase/firebase_options.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp
  (
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      routes: 
      {
        Splash.routeNamed: (_) => Splash(),
        Home.routeNamed: (_) => Home(),
        EditScreen.routeNamed: (_) => EditScreen()
      },
      initialRoute: Splash.routeNamed,
    );
  }
}

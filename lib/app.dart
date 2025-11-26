import 'package:flutter/material.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';
import 'package:todoapp/screens/todo_screen.dart';
import 'package:todoapp/screens/welcom_screen.dart';

import 'getx/todo_getx_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Donut Delights',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/' : (context) => const WelcomeScreen(),
          '/login' : (context)=> LoginForm(),
          '/signup' : (context)=>  SignupScreen(),
          '/todo':(context)=>  TodoScreen(),
        },
      );

    }
  }

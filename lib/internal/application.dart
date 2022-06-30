import 'package:flutter/material.dart';
import '../presentation/first_route.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Navigation Basics',
      home: FirstRoute(),
    );
  }
}
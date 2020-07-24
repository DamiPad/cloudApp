
import 'package:cloud_app/src/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: HomeScreen(),
    );
  }
}
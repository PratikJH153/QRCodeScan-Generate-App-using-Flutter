import 'package:flutter/material.dart';
import 'package:qrcodeapp/views/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QRScan",
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF30cf8c),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF1f1f1f),
      ),
      home: HomePage(),
    );
  }
}

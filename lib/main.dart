
import 'package:flutter/material.dart';

void main() {
  runApp(const ZeroChatApp());
}

class ZeroChatApp extends StatelessWidget {
  const ZeroChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'زيرو دردشة',
      theme: ThemeData.dark(),
      home: const Scaffold(
        backgroundColor: Color(0xFF171329),
        body: Center(
          child: Text(
            'زيرو دردشة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

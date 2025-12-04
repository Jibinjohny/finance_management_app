import 'package:flutter/material.dart';
import '../screens/intro_screen.dart';

class IntroPageWidget extends StatelessWidget {
  final IntroPageData data;

  const IntroPageWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.color.withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(data.icon, size: 70, color: data.color),
          ),

          SizedBox(height: 50),

          // Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),

          // Description
          Text(
            data.description,
            style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

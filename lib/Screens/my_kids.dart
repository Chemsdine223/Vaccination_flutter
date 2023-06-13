import 'package:flutter/material.dart';

class MyChildrenScreen extends StatefulWidget {
  const MyChildrenScreen({super.key});

  @override
  State<MyChildrenScreen> createState() => _MyChildrenScreenState();
}

class _MyChildrenScreenState extends State<MyChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Center(
            child: Image.asset(
              'Img/check.png',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Text('Traitement fini avec success !')
        ],
      ),
    );
  }
}

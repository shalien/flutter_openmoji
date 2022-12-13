import 'package:flutter/material.dart';

import 'package:flutter_openmoji/flutter_openmoji.dart';

void main() {
  runApp(const OpenmojiDemoApp());
}

class OpenmojiDemoApp extends StatelessWidget {
  const OpenmojiDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Center(
            child: IconButton(
              icon: const Icon(
                OpenmojiIcons.airplane,
                color: Colors.blue,
              ),
              onPressed: () => print('OpenMoji icons !'),
            ),
          )
        ]),
      ),
    );
  }
}

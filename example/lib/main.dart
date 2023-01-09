import 'package:flutter/material.dart';
import 'package:flutter_openmoji/flutter_openmoji.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              OpenmojiIconsBLACKGLYF.person_raising_hand,
              color: Colors.blue,
              size: 30,
            ),
            Icon(
              OpenmojiIconsCOLORGLYFCOLR0.person_raising_hand,
              size: 30,
              color: Colors.blue,
            ),
            Icon(OpenmojiIconsCOLORGLYFCOLR1.person_raising_hand,
                size: 30, color: Colors.blue),
            Icon(OpenmojiIconsCOLORPICOSVGZ.person_raising_hand,
                size: 30, color: Colors.blue),
            Icon(OpenmojiIconsCOLORSBIX.person_raising_hand,
                size: 30, color: Colors.blue),
            Icon(OpenmojiIconsCOLORUNTOUCHEDSVGZ.person_raising_hand,
                size: 30, color: Colors.blue),
            Icon(Icons.person_add_outlined, color: Colors.blue, size: 60)
          ],
        ),
      ),
    );
  }
}

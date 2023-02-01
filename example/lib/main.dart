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
          children: <Widget>[
            Row(
              children: const [
                Text('OpenMoji Icons COLR 0 SVG :'),
                Icon(
                  OpenmojiIconsCOLR0SVG.person_raising_hand,
                  size: 30,
                  color: Colors.blue,
                )
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons COLR 1 SVG :'),
                Icon(
                  OpenmojiIconsCOLR1SVG.person_raising_hand,
                  size: 30,
                  color: Colors.blue,
                )
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons GLYF COLR 0 :'),
                Icon(
                  OpenmojiIconsGLYFCOLR0.person_raising_hand,
                  size: 30,
                  color: Colors.blue,
                )
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons GLYF COLR 1 :'),
                Icon(OpenmojiIconsGLYFCOLR1.person_raising_hand,
                    size: 30, color: Colors.blue),
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons PICO SVGZ :'),
                Icon(OpenmojiIconsPICOSVGZ.person_raising_hand,
                    size: 30, color: Colors.blue),
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons SBIX :'),
                Icon(OpenmojiIconsSBIX.person_raising_hand,
                    size: 30, color: Colors.blue),
              ],
            ),
            Row(
              children: const [
                Text('OpenMoji Icons Untouched SVGZ :'),
                Icon(OpenmojiIconsUNTOUCHEDSVGZ.person_raising_hand,
                    size: 30, color: Colors.blue),
              ],
            )
          ],
        ),
      ),
    );
  }
}

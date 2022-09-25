import 'package:flutter/material.dart';
import 'package:startup_names/pages/randomWords.dart';
import 'package:startup_names/pages/editWord.dart';

enum ViewType { grid, list }

void main() {
  runApp(const MyApp());
}

class Arguments {
  final String word;
  final String editedWord;
  Arguments(this.word, this.editedWord);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override //método de construção
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 244, 177, 54),
          foregroundColor: Colors.white,
        ),
      ),
      home: const RandomWords(),
      routes: <String, WidgetBuilder>{
        '/edit': (BuildContext context) => const EditWordPage(),
      },
    );
  }
}

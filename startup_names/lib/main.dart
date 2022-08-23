import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

enum ViewType { grid, list }

void main() {
  runApp(const MyApp());
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
    );
  }
}

//Cria widget com estado
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  ViewType _viewType = ViewType.list;
  int _colum = 1;

  //salva os favoritos na outra aba
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Favoritados'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Favoritados',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 244, 177, 54),
          child:
              Icon(_viewType == ViewType.grid ? Icons.grid_view : Icons.list),
          onPressed: () {
            if (_viewType == ViewType.grid) {
              _viewType = ViewType.list;
              _colum = 1;
            } else {
              _viewType = ViewType.grid;
              _colum = 2;
            }
            setState(() {});
          }),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _colum,
        childAspectRatio: _viewType == ViewType.grid ? 1 : 10,
      ),
      itemBuilder: (context, i) {
        if (i.isOdd && _viewType == ViewType.list) {
          return const Divider();
        }

        final index = i ~/ 1;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        //função favoritar
        final alreadySaved =
              _saved.contains(_suggestions[index]); //análogo a um state
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              //direita
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color:
                  alreadySaved ? const Color.fromARGB(255, 255, 115, 0) : null,
              semanticLabel:
                  alreadySaved ? 'Remove from saved' : 'Save', //análogo ao alt
            ),
            onTap: () {
              //onClick
              setState(() {
                //lógica da troca de estado
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    if (_viewType == ViewType.grid) {
      return Card(
        margin: const EdgeInsets.all(12),
        child: Center(
            child: Text(
          pair.asPascalCase,
          style: _biggerFont,
        )),
      );
    } else {
      return ListTile(
        title: Text(
          pair.asPascalCase,
        ),
      );
    }
  }
}
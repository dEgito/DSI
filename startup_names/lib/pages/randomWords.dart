import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ViewType { grid, list }

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
      padding: const EdgeInsets.all(2),
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
        final alreadySaved = _saved.contains(_suggestions[index]); //análogo a um state
        return ListTile(
            title: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/edit'),
              style: TextButton.styleFrom(
                
              ),
              child: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
            ),
            
            trailing: Wrap(
              // spacing: -10, não funciona
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved
                        ? const Color.fromARGB(255, 255, 115, 0)
                        : null,
                    semanticLabel: alreadySaved
                        ? 'Desfavoritar'
                        : 'Salvo', //análogo ao alt
                  ),
                  onPressed: () {
                    setState(() {
                      //lógica da troca de estado
                      if (alreadySaved) {
                        _saved.remove(_suggestions[index]);
                      } else {
                        _saved.add(_suggestions[index]);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.delete,
                    semanticLabel: 'Deletado',
                  ),
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        _saved.remove(_suggestions[index]);
                      }
                      _suggestions
                          .remove(_suggestions[index]); //remove do array
                    });
                  },
                ),
              ],
            ));
      },
    );
  }
}
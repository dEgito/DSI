import 'package:flutter/material.dart';
import 'package:startup_names/pages/randomWords.dart';

class EditWordPage extends StatefulWidget {
  final String? title;
  const EditWordPage({Key? key, this.title}) : super(key: key);
  @override
  State<EditWordPage> createState() => _EditWordPageState();
}

class _EditWordPageState extends State<EditWordPage> {
  final formkey = GlobalKey<FormState>();
  String editedWord = '';

  @override
  Widget build(BuildContext context) {
    // final argumentos = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final words = argumentos['words'];
    // final int index = argumentos['index'];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: const [
            //inverter a ordem seta + nome
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: null,
              tooltip: 'Voltar',
            ),
          ],
          title: const Text('Edição'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 24,
            children: [
              TextFormField(
                  onChanged: (value) => setState(() {
                    editedWord = value;
                    print(editedWord);
                  }),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    hintText: "TEXTO ANTERIOR",
                    hintStyle:
                        const TextStyle(color: Color(0xFF695876), fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(126, 244, 177, 54),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(126, 244, 177, 54),
                        width: 2,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 91, 56, 0),
                      ),
                    ),
                  )),
              const SizedBox(height: 250),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 194, 103),
                    fixedSize: const Size(246, 48)),
                child: const Text(
                  "SALVAR",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RandomWords(),
                      ));
                },
              ),
            ],
          ),
        ));
  }
}

import 'package:canine_shield/services/dog_api_service.dart';
import 'package:canine_shield/vaccineCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/database/dog_database.dart';

import 'dogEditScreenState.dart';

class DogDetailScreen extends StatefulWidget {
  Dog dog;

  DogDetailScreen({Key? key, required this.dog}) : super(key: key);

  @override
  _DogDetailScreenState createState() => _DogDetailScreenState();
}

class _DogDetailScreenState extends State<DogDetailScreen> {
  late DogDatabase _dogDatabase;

  @override
  void initState() {
    super.initState();
    _dogDatabase = DogDatabase();
  }

  Future<void> deleteDog(BuildContext context, int dogId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir este cachorro?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != null && confirmed) {
      await _dogDatabase.deleteDog(dogId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cachorro excluído com sucesso!'),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text(widget.dog.name,
        style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
    ),
        ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogEditScreen(
                      dog: widget.dog,
                    ),
                  ),
                ).then((value) => setState(() {}));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteDog(context, widget.dog.id as int),
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: FutureBuilder<String>(
                future: returnImageFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Hero(
                      tag: widget.dog.id,
                      child: Image.network(
                        snapshot.data!,
                        height: 250,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nome:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              widget.dog.name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Genero:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            Text(
              widget.dog.gender,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Raça:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            Text(
              widget.dog.breed!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sexo:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.dog.gender,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Data de Nascimento:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'aniversario',// widget.dog.birthdate,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Carteira de Vacinação:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              child: const Text(
                'Ver Carteira de Vacinação',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VaccineCardScreen(
                      dog: widget.dog,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> returnImageFromAPI() async {
      return await DogApiService.getDogImageByBreed(widget.dog.breed!);
  }
}

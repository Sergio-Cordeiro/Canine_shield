import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/database/dog_database.dart';

class DogDetailScreen extends StatefulWidget {
  final Dog dog;

  const DogDetailScreen({Key? key, required this.dog}) : super(key: key);

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.dog.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breed: ${widget.dog.breed}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Age: ${widget.dog.age}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await deleteDog(context, int.parse(widget.dog.id));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

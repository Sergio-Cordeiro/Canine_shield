import 'package:flutter/material.dart';
import 'package:canine_shield/database/dog_database.dart';
import 'package:canine_shield/models/dog.dart';

class DogListScreen extends StatefulWidget {
  const DogListScreen({Key? key}) : super(key: key);

  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  final _dogDatabase = DogDatabase();
  List<Dog> _dogs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  Future<void> _loadDogs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dogs = await _dogDatabase.dogs();
      setState(() {
        _dogs = dogs;
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Cães'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          final dog = _dogs[index];
          return ListTile(
            title: Text(dog.name),
            subtitle: Text('${dog.breed} - ${dog.age} anos'),
          );
        },
      ),
    );
  }
}

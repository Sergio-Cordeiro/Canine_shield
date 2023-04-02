import 'package:flutter/material.dart';
import 'package:canine_shield/database/dog_database.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/dogDetailScreen.dart';
import 'newDog.dart';

class DogListScreen extends StatefulWidget {
  const DogListScreen({Key? key}) : super(key: key);

  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  final DogDatabase _dogDatabase = DogDatabase();
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Dog List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(_dogs[index].name),
              subtitle: Text(_dogs[index].breed!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DogDetailScreen(dog: _dogs[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DogRegistrationScreen()),
          );
          if (result != null && result == true) {
            await _loadDogs();
          }
        },
      ),
    );
  }
}

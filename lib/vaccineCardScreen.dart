import 'package:canine_shield/newVaccineScreen.dart';
import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';

class VaccineCardScreen extends StatelessWidget {
  final Dog dog;

  const VaccineCardScreen({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Carteira de vacinação do ${dog.name}',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Teste de tela exibindo as vacinas',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Adicione aqui a lista de vacinas do cachorro
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewVaccineScreen(dog: dog),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


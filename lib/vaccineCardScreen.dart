import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';

class VaccineCardScreen extends StatelessWidget {
  final Dog dog;

  const VaccineCardScreen({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira de vacinação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nome do cachorro: ${dog.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            // Adicione aqui a lista de vacinas do cachorro
          ],
        ),
      ),
    );
  }
}

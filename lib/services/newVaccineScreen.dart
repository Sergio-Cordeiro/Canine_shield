import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';

class NewVaccineScreen extends StatelessWidget {
  const NewVaccineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova vacina'),
      ),
      body: const Center(
        child: Text('Preencha os dados da nova vacina aqui'),
      ),
    );
  }
}
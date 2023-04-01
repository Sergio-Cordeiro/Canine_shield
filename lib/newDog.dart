import 'package:flutter/material.dart';
import 'package:canine_shield/database/dog_database.dart';
import 'package:canine_shield/services/dog_api_service.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/dogListScreen.dart';

class DogRegistrationScreen extends StatefulWidget {
  const DogRegistrationScreen({Key? key});

  @override
  _DogRegistrationScreenState createState() => _DogRegistrationScreenState();
}

class _DogRegistrationScreenState extends State<DogRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _dogName;
  String? _breed;
  late int _age;
  List<String> _breeds = [];
  final _dogDatabase = DogDatabase();

  @override
  void initState() {
    super.initState();
    _loadBreeds();
  }

  Future<void> _loadBreeds() async {
    final breeds = await DogApiService.fetchDogBreeds();
    setState(() {
      _breeds = breeds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cachorro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, informe o nome do cachorro';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dogName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButton(
                hint: const Text('Raça'),
                value: _breed,
                items: _breeds.map((breed) {
                  return DropdownMenuItem(
                    value: breed,
                    child: Text(breed),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _breed = value as String?;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Idade',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, informe a idade do cachorro';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, informe uma idade válida';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Criar uma instância da classe Dog com os dados coletados no formulário
                    final dog = Dog(
                      name: _dogName,
                      breed: _breed!,
                      age: _age,
                      id: '',
                    );
                    // Salvar os dados do cachorro no banco de dados

                    await _dogDatabase.insertDog(dog);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DogListScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

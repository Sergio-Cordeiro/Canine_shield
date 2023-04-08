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

enum Gender { male, female } // enum para representar os gêneros

class _DogRegistrationScreenState extends State<DogRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _dogName;
  String? _breed;
  late int _age;
  List<String> _breeds = [];
  final _dogDatabase = DogDatabase();
  Gender _gender = Gender.male;
  bool _castrated = false;

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Cadastro de Cachorro',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Raça',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                hint: const Text('Selecione uma raça'),
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
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione uma raça';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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

              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Macho'),
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value as Gender;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Fêmea'),
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value as Gender;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SwitchListTile(
                title: const Text('Castrado'),
                value: _castrated,
                onChanged: (value) {
                  setState(() {
                    _castrated = value!;
                  });
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
                      gender: _gender == Gender.male ? 'Macho' : 'Fêmea', // atribui o valor selecionado
                      id: '',
                      castrated:_castrated,
                    );
                    // Salvar os dados do cachorro no banco de dados
                    await _dogDatabase.insertDog(dog);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DogListScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

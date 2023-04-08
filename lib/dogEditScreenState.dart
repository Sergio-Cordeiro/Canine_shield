import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/database/dog_database.dart';

class DogEditScreen extends StatefulWidget {
  final Dog dog;

  const DogEditScreen({Key? key, required this.dog}) : super(key: key);

  @override
  _DogEditScreenState createState() => _DogEditScreenState();
}

class _DogEditScreenState extends State<DogEditScreen> {

  final _formKey = GlobalKey<FormState>();
  late DogDatabase _dogDatabase;
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late bool _isCastrated = false;
  late String _gender = 'Male';

  @override
  void initState() {
    super.initState();
    _dogDatabase = DogDatabase();
    _nameController = TextEditingController(text: widget.dog.name);
    _breedController = TextEditingController(text: widget.dog.breed);
    _ageController = TextEditingController(text: widget.dog.age.toString());
    _isCastrated = widget.dog.castrated;
    _gender = widget.dog.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> updateDog(BuildContext context) async {
    final updatedDog = Dog(
      id: widget.dog.id,
      name: _nameController.text.trim(),
      breed: _breedController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? widget.dog.age,
      gender: _gender,
      castrated: _isCastrated,
    );

    await _dogDatabase.updateDog(updatedDog);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cachorro atualizado com sucesso!')),
    );
    Navigator.of(context).pop(updatedDog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Editar Cachorro',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Informe o nome do cachorro',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: 'Raça',
                  hintText: 'Informe a raça do cachorro',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  hintText: 'Informe a idade do cachorro',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value.trim()) == null) {
                    return 'Idade inválida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Castrado'),
                  Switch(
                    value: _isCastrated,
                    onChanged: (value) {
                      setState(() {
                        _isCastrated = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Gênero'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text('Macho'),
                  const SizedBox(width: 16),
                  Radio(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  const Text('Fêmea'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateDog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(150, 50), // definindo um tamanho mínimo para os botões
                  ),
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

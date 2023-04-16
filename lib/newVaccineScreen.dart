import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/services/dog_openWorm_service.dart';
import 'package:intl/intl.dart';

import 'database/vaccine_database.dart';
import 'models/vaccine.dart';

class NewVaccineScreen extends StatefulWidget {
  final Dog dog;
  const NewVaccineScreen({Key? key, required this.dog}) : super(key: key);

  @override
  State<NewVaccineScreen> createState() => _NewVaccineScreenState();
}

class _NewVaccineScreenState extends State<NewVaccineScreen> {

  late Future<List<String>> _vaccinesFuture;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String? _selectedVaccine;
  String? _selectedDateString;
  String? _selectedDateNextString;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _vaccinesFuture = DogOpenWormService.getDogVaccines(widget.dog.breed!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova vacina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FutureBuilder<List<String>>(
              future: _vaccinesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Nome da vacina',
                        border: OutlineInputBorder(),
                      ),
                      items: snapshot.data!.map((vaccine) {
                        return DropdownMenuItem<String>(
                          value: vaccine,
                          child: Text(vaccine),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedVaccine = value;
                        });
                      },
                      value: _selectedVaccine,
                    );
                  } else {
                    return const Text('Nenhuma vacina encontrada');
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Data da aplicação',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _selectedDateString = dateFormat.format(_selectedDate!);
                  });
                }
              },
              readOnly: true,
              controller: TextEditingController(text: _selectedDateString),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Data do próximo reforço',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    _selectedDateNextString = dateFormat.format(_selectedDate!);
                  });
                }
              },
              readOnly: true,
              controller: TextEditingController(text: _selectedDateNextString),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {


                  final vaccine = Vaccine(
                    name: _selectedVaccine!,
                    dateActually: DateTime.parse(_selectedDateString!),
                    dateNextVaccine: DateTime.parse(_selectedDateNextString!),
                    dogId: int.parse(widget.dog.id),
                  );
                  await VaccineDatabase.instance.createVaccine(vaccine);
                  Navigator.pop(context);





                // Adicione aqui o código para salvar a vacina no banco de dados
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

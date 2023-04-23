import 'package:canine_shield/newVaccineScreen.dart';
import 'package:canine_shield/vaccineDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/models/vaccine.dart';
import 'package:canine_shield/database/vaccine_database.dart';
import 'database/vaccine_database.dart';

class VaccineCardScreen extends StatelessWidget {
  final Dog dog;

  const VaccineCardScreen({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Carteira de vacinação do ${dog.name}',
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
        child: FutureBuilder<List<Vaccine>>(
          future: VaccineDatabase.instance.getVaccinesByDogId(int.parse(dog.id)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final vaccines = snapshot.data!;
            return ListView.builder(
              itemCount: vaccines.length,
              itemBuilder: (context, index) {
                final vaccine = vaccines[index];
                return ListTile(
                  title: Text(vaccine.name),
                  subtitle: Text('Data da próxima vacina: ${vaccine.dateNextVaccine}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VaccineDetailScreen(vaccine: vaccine),
                      ),
                    );
                  },
                );
              },
            );
          },
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








// import 'package:canine_shield/newVaccineScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:canine_shield/models/dog.dart';
// import 'package:canine_shield/models/vaccine.dart';
// import 'package:canine_shield/database/vaccine_database.dart';
// import 'database/vaccine_database.dart';
//
// class VaccineCardScreen extends StatelessWidget {
//   final Dog dog;
//
//   const VaccineCardScreen({Key? key, required this.dog}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(
//           'Carteira de vacinação do ${dog.name}',
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Vaccine>>(
//           future: VaccineDatabase.instance.getVaccinesByDogId(int.parse(dog.id)),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }
//             final vaccines = snapshot.data!;
//             return ListView.builder(
//               itemCount: vaccines.length,
//               itemBuilder: (context, index) {
//                 final vaccine = vaccines[index];
//                 return ListTile(
//                   title: Text(vaccine.name),
//                   subtitle: Text('Data da próxima vacina: ${vaccine.dateNextVaccine}'),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => NewVaccineScreen(dog: dog),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:canine_shield/services/dog_api_service.dart';
import 'package:canine_shield/vaccineCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:canine_shield/models/dog.dart';
import 'package:canine_shield/database/dog_database.dart';

import 'dogEditScreenState.dart';

class DogDetailScreen extends StatefulWidget {
  Dog dog;

  DogDetailScreen({Key? key, required this.dog}) : super(key: key);

  @override
  _DogDetailScreenState createState() => _DogDetailScreenState();
}

class _DogDetailScreenState extends State<DogDetailScreen> {
  late DogDatabase _dogDatabase;

  @override
  void initState() {
    super.initState();
    _dogDatabase = DogDatabase();
  }

  Future<void> deleteDog(BuildContext context, int dogId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir este cachorro?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != null && confirmed) {
      await _dogDatabase.deleteDog(dogId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cachorro excluído com sucesso!'),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text(widget.dog.name,
        style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
    ),
        ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogEditScreen(
                      dog: widget.dog,
                    ),
                  ),
                ).then((value) => setState(() {}));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteDog(context, widget.dog.id as int),
            ),
          ],
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: FutureBuilder<String>(
                future: returnImageFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Hero(
                      tag: widget.dog.id,
                      child: Image.network(
                        snapshot.data!,
                        height: 250,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nome:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              widget.dog.name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Genero: ${widget.dog.gender}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              widget.dog.breed!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sexo:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.dog.gender,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Data de Nascimento:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'aniversario',// widget.dog.birthdate,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Carteira de Vacinação:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              child: const Text(
                'Ver Carteira de Vacinação',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VaccineCardScreen(
                      dog: widget.dog,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> returnImageFromAPI() async {
      return await DogApiService.getDogImageByBreed(widget.dog.breed!);
  }
}




// import 'package:canine_shield/vaccineCardScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:canine_shield/models/dog.dart';
// import 'package:canine_shield/database/dog_database.dart';
//
// import 'dogEditScreenState.dart';
//
// class DogDetailScreen extends StatefulWidget {
//    Dog dog;
//
//    DogDetailScreen({Key? key, required this.dog}) : super(key: key);
//
//   @override
//   _DogDetailScreenState createState() => _DogDetailScreenState();
// }
//
// class _DogDetailScreenState extends State<DogDetailScreen> {
//   late DogDatabase _dogDatabase;
//
//   @override
//   void initState() {
//     super.initState();
//     _dogDatabase = DogDatabase();
//   }
//
//   Future<void> deleteDog(BuildContext context, int dogId) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirmar exclusão'),
//         content: const Text('Tem certeza que deseja excluir este cachorro?'),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Cancelar'),
//             onPressed: () => Navigator.of(context).pop(false),
//           ),
//           TextButton(
//             child: const Text('Excluir'),
//             onPressed: () => Navigator.of(context).pop(true),
//           ),
//         ],
//       ),
//     );
//
//     if (confirmed != null && confirmed) {
//       await _dogDatabase.deleteDog(dogId);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Cachorro excluído com sucesso!'),
//       ));
//       Navigator.of(context).pop();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(widget.dog.name,
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
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Raça: ${widget.dog.breed}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Idade: ${widget.dog.age} anos',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Genero: ${widget.dog.gender}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Castrado?: ${widget.dog.castrated ? 'Sim' : 'Não'}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       await deleteDog(context, int.parse(widget.dog.id));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: Size(150, 50), // definindo um tamanho mínimo para os botões
//                     ),
//                     child: const Text(
//                       'Delete',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: () => editDog(context, widget.dog),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: Size(150, 50), // definindo um tamanho mínimo para os botões
//                     ),
//                     child: const Text(
//                       'Edit',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Novo botão centralizado
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VaccineCardScreen(dog: widget.dog),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   minimumSize: Size(150, 50),
//                 ),
//                 child: const Text(
//                   'Carteira de vacinação',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> editDog(BuildContext context, Dog dog) async {
//     final editedDog = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DogEditScreen(dog: dog)),
//     );
//
//     if (editedDog != null) {
//       await _dogDatabase.updateDog(editedDog);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Cachorro atualizado com sucesso!'),
//       ));
//       setState(() {
//         widget.dog = editedDog;
//       });
//     }
//   }
// }

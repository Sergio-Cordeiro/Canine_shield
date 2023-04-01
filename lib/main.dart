import 'package:flutter/material.dart';
import 'package:canine_shield/newDog.dart';
// import 'package:canine_shield/screens/newVaccine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanineShield',
      home: HomePage(),
      routes: {
        '/addDog': (context) => const DogRegistrationScreen(),
        // '/addVaccine': (context) => const VaccineRegistrationScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Carteira de Vacinação Canina'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/cachorroClaro.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.pets,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'CanineShield sua carteira de vacinação canina!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addDog');
                },
                child: const Text('Adicionar novo cachorro'),
              ),
              const SizedBox(height: 0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addVaccine');
                },
                child: const Text('Meus cachorros'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

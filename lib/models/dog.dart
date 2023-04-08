import 'package:uuid/uuid.dart';

class Dog {
  final String id;
  final String name;
  final String? breed;
  final int age;
  final String gender;
  final bool castrated;

  Dog({
    required this.id,
    required this.name,
    this.breed,
    required this.age,
    required this.gender,
    required this.castrated,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      breed: json['breed'],
      age: json['age'],
      gender: json['gender'],
      castrated: json['castrated'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'breed': breed,
    'age': age,
    'gender': gender,
    'castrated': castrated,
  };

  factory Dog.createNewDog(String name, String? breed, int age, String gender, bool castrated) {
    return Dog(
      id: Uuid().v4(),
      name: name,
      breed: breed,
      age: age,
      gender: gender,
      castrated: castrated,
    );
  }

  factory Dog.toDog(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String?;
    final breed = map['breed'] as String?;
    final age = map['age'] as int?;
    final gender = map['gender'] as String?;
    final castrated = map['castrated'] as bool?;

    if (id == null || name == null || breed == null || age == null || gender == null || castrated == null) {
      throw Exception('Dados do banco de dados inválidos para criar um objeto Dog');
    }

    return Dog(id: id.toString(), name: name, breed: breed, age: age, gender: gender, castrated: castrated);
  }
}
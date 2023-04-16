import 'package:uuid/uuid.dart';

class Vaccine {
  final String id;
  final String name;
  final String dateActually;
  final String dateNextVaccine;
  final int dogId;

  Vaccine({
    required this.id,
    required this.name,
    required this.dateActually,
    required this.dateNextVaccine,
    required this.dogId,
  });

  factory Vaccine.createNewVaccine(String name, String dateActually, String dateNextVaccine, int dogId) {
    return Vaccine(
        id: Uuid().v4(),
        name: name,
        dateActually: dateActually,
        dateNextVaccine: dateNextVaccine,
        dogId: dogId
    );
  }

  Vaccine copy({
    String? id,
    String? name,
    DateTime? dateActually,
    DateTime? dateNextVaccine,
    int? dogId,
  }) {
    return Vaccine(
      id: id ?? this.id,
      name: name ?? this.name,
      dateActually: this.dateActually,
      dateNextVaccine: this.dateNextVaccine,
      dogId: dogId ?? this.dogId,
    );
  }

  Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'dateActually': dateActually,
      'dateNextVaccine': dateNextVaccine,
      'dog_id': dogId,
  };
}

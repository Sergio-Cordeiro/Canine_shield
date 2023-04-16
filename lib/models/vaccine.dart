import 'package:uuid/uuid.dart';

class Vaccine {
  final String id;
  final String name;
  final DateTime dateActually;
  final DateTime dateNextVaccine;
  final int dogId;

  Vaccine({
    String? id,
    required this.name,
    required this.dateActually,
    required this.dateNextVaccine,
    required this.dogId,
  }) : id = id ?? const Uuid().v4();

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
      dateActually: dateActually ?? this.dateActually,
      dateNextVaccine: dateNextVaccine ?? this.dateNextVaccine,
      dogId: dogId ?? this.dogId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateActually': dateActually.toIso8601String(),
      'dateNextVaccine': dateNextVaccine.toIso8601String(),
      'dog_id': dogId,
    };
  }
}

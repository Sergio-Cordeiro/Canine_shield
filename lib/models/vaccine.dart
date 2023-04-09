class Vaccine {
  final int id;
  final String name;
  final DateTime date;
  final int dogId;

  Vaccine({
    required this.id,
    required this.name,
    required this.date,
    required this.dogId,
  });

  Vaccine copy({
    int? id,
    String? name,
    DateTime? date,
    int? dogId,
  }) {
    return Vaccine(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      dogId: dogId ?? this.dogId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'dogId': dogId,
    };
  }
}

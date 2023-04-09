import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canine_shield/data/vaccines_data.dart';

class DogOpenWormService {
  static const String _baseUrl = 'https://dog-api.kinduff.com/api/v1/vaccines';

  static Future<List<String>> getDogVaccines(String breed) async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['vaccines']);
    } else {
      return dogVaccines;
    }
  }
}
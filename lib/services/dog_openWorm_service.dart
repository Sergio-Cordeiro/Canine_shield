import 'dart:convert';
import 'package:http/http.dart' as http;

class DogOpenWormService {
  static const String _baseUrl = 'https://dog-api.kinduff.com/api/v1/vaccines';

  static Future<List<String>> getDogVaccines(String breed) async {
    final response = await http.get(Uri.parse('$_baseUrl/$breed'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['vaccines']);
    } else {
      throw Exception('Failed to load dog vaccines');
    }
  }
}
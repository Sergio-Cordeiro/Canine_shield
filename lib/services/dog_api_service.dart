import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class DogApiService {
  static const String _baseUrl = 'https://dog.ceo/api';

  static Future<List<String>> fetchDogBreeds() async {
    final response = await http.get(Uri.parse('$_baseUrl/breeds/list/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final breedsMap = data['message'] as Map<String, dynamic>;
      final breedsList = breedsMap.keys.toList();
      return breedsList;
    } else {
      throw Exception('Failed to load dog breeds');
    }
  }

  static Future<String> getDogImageByBreed(String breed) async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
    final data = json.decode(response.body);
    final imageUrl = data['message'];
    return imageUrl;
  }

}

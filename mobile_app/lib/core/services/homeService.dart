import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/constants.dart';

class ApiService {
  static Future<String> ping() async {
    try {
      final url = Uri.parse('$baseUrl/api/ping/');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        return 'Erreur : ${response.statusCode}';
      }
    } catch (e) {
      return 'Erreur de connexion';
    }
  }
}

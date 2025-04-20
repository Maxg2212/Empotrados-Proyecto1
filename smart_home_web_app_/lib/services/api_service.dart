import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  // Login
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If the backend returns 200 on success, we assume login is OK
      return true;
    } else {
      return false;
    }
  }

  // Update a single light (e.g., Bedroom 1)
  static Future<bool> updateLight(String area, bool turnOn) async {
    final url = Uri.parse('$baseUrl/light/update');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'area': area,
        'status': turnOn ? 1 : 0,
      }),
    );

    return response.statusCode == 200;
  }

  // Update all lights
  static Future<bool> updateAllLights(bool turnOn) async {
    final url = Uri.parse('$baseUrl/light/all/change');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': turnOn ? 1 : 0}),
    );

    return response.statusCode == 200;
  }

  // Get status of all lights
  static Future<Map<String, bool>> getLightStatuses() async {
    final url = Uri.parse('$baseUrl/light/status');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Example response: { "living_room": 1, "kitchen": 0 }
      return data.map((key, value) => MapEntry(key, value == 1));
    } else {
      throw Exception('Failed to get light status');
    }
  }
}

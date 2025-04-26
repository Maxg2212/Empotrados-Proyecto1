import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  // login
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    return response.statusCode == 200;
  }

  // update a single light
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

  // update all lights
  static Future<bool> updateAllLights(bool turnOn) async {
    final url = Uri.parse('$baseUrl/light/all/change');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': turnOn ? 1 : 0}),
    );

    return response.statusCode == 200;
  }

  // get status of all lights
  static Future<Map<String, bool>> getLightStatuses() async {
    final url = Uri.parse('$baseUrl/light/status');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data.map((key, value) => MapEntry(key, value == 1));
    } else {
      throw Exception('Failed to get light status');
    }
  }

  //get status of all doors
  static Future<Map<String, bool>?> getDoorsStatus() async {
    final url = Uri.parse('$baseUrl/doors/status');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['ok'] == true && body['error'] == false) {
          final doorsData = body['data'] as Map<String, dynamic>;
          final doorsStatus = <String, bool>{};

          for (final entry in doorsData.entries) {
            doorsStatus[entry.key] = entry.value == 1;
          }

          return doorsStatus;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching doors status: $e');
      return null;
    }
  }

  // get individual door status
  static Future<bool?> getDoorStatus(String doorName) async {
  final url = Uri.parse('$baseUrl/door/status?door=$doorName');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['ok'] == true && body['error'] == false && body['data'] != null) {
        return body['data'] == 1;
      }
    }
    return null;
  } catch (e) {
    print('Error fetching $doorName status: $e');
    return null;
  }
}




}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "newsapi.org/v2";
  static const String apiKey = "de35f65cabd4404ebecca7036132be1e";

  Future<List<Map<String, dynamic>>> getHeadLines() async {
    final response = await http
        .get(Uri.parse("$baseUrl/top-headlines?country=id&apiKey=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}

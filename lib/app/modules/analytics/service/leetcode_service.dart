import 'dart:convert';
import 'package:http/http.dart' as http;

class LeetCodeService {
  final String username;
  static const String baseUrl = 'https://portfolio-b7szoixjm-tanmays-projects-e3371619.vercel.app';

  LeetCodeService({required this.username});

  Future<Map<String, dynamic>> fetchStats() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/api/leetcode/$username'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw Exception('LeetCode API Error: ${errorData['error']}');
      }
    } catch (e) {
      throw Exception('Failed to fetch LeetCode stats: $e');
    }
  }
}

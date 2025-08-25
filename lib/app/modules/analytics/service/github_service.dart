import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String username;
  static const String baseUrl = 'https://portfolio-b7szoixjm-tanmays-projects-e3371619.vercel.app';

  GitHubService({required this.username});

  Future<Map<String, dynamic>> fetchStats() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/github/stats'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'username': username}),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('GitHub API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch GitHub stats: $e');
    }
  }
}

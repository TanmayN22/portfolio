import 'dart:convert';
import 'package:http/http.dart' as http;

class LeetCodeService {
  final String username;

  LeetCodeService({required this.username});

  Future<Map<String, dynamic>> fetchStats() async {
    final url = "https://leetcode-stats-api.herokuapp.com/$username";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("LeetCode Stats API Error: ${res.statusCode}");
    }
  }
}

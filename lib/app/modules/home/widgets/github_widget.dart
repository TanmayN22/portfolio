import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GitHubContributionsWidget extends StatefulWidget {
  final String username;
  final String token; // Embedded token

  const GitHubContributionsWidget({
    super.key,
    required this.username,
    required this.token,
  });

  @override
  State<GitHubContributionsWidget> createState() =>
      _GitHubContributionsWidgetState();
}

class _GitHubContributionsWidgetState extends State<GitHubContributionsWidget> {
  Map<DateTime, int> contributions = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchContributions();
  }

  Future<void> fetchContributions() async {
    const String query = r'''
      query($login: String!) {
        user(login: $login) {
          contributionsCollection {
            contributionCalendar {
              weeks {
                contributionDays {
                  date
                  contributionCount
                }
              }
            }
          }
        }
      }
    ''';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    };

    final body = jsonEncode({
      'query': query,
      'variables': {'login': widget.username},
    });

    final res = await http.post(
      Uri.parse('https://api.github.com/graphql'),
      headers: headers,
      body: body,
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      final weeks =
          data['data']['user']['contributionsCollection']['contributionCalendar']['weeks']
              as List;

      Map<DateTime, int> map = {};
      for (var week in weeks) {
        for (var day in week['contributionDays']) {
          final date = DateTime.parse(day['date']);
          final count = day['contributionCount'];
          map[date] = count;
        }
      }

      setState(() {
        contributions = map;
        loading = false;
      });
    } else {
      debugPrint('Error: ${res.statusCode} ${res.body}');
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (contributions.isEmpty) {
      return const Text("No contributions found.");
    }
    int weeksToShow = 20; // Adjust so it fits in your container

    // Get the latest contributions
    final latestEntries = contributions.entries.toList().reversed.toList();

    // Limit to weeksToShow * 7 days
    final limitedEntries =
        latestEntries.take(weeksToShow * 7).toList().reversed.toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E1E1E) // Dark background
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(weeksToShow, (weekIndex) {
          return Column(
            children: List.generate(7, (dayIndex) {
              int index = weekIndex * 7 + dayIndex;
              if (index >= limitedEntries.length) {
                return const SizedBox(width: 12, height: 12);
              }
              final count = limitedEntries[index].value;

              return Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: _getColor(count),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Color _getColor(int count) {
    if (count == 0) {
      return Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 71, 70, 70) // Dark background
          : const Color(0xFFEBEDF0);
    }
    if (count <= 3) return const Color(0xFF9BE9A8);
    if (count <= 8) return const Color(0xFF40C463);
    if (count <= 15) return const Color(0xFF30A14E);
    return const Color(0xFF216E39);
  }
}

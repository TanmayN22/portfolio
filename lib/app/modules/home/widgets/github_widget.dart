// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:porfolio/app/modules/analytics/service/api_cache_repository.dart'; // ADDED

class GitHubContributionsWidget extends StatefulWidget {
  final String username;

  const GitHubContributionsWidget({super.key, required this.username});

  @override
  State<GitHubContributionsWidget> createState() =>
      _GitHubContributionsWidgetState();
}

class _GitHubContributionsWidgetState extends State<GitHubContributionsWidget> {
  Map<DateTime, int> contributions = {};
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchContributions();
  }

  // UPDATED fetchContributions() method with caching
  Future<void> fetchContributions() async {
    try {
      final data = await ApiCacheRepository.getContributions(widget.username);
      
      if (data != null) {
        final weeks = data['weeks'] as List;

        Map<DateTime, int> map = {};
        for (var week in weeks) {
          final contributionDays = week['contributionDays'] as List;
          for (var day in contributionDays) {
            final date = DateTime.parse(day['date']);
            final count = day['contributionCount'] as int;
            map[date] = count;
          }
        }

        setState(() {
          contributions = map;
          loading = false;
          errorMessage = null;
        });
      }
    } catch (e) {
      debugPrint('GitHub Contributions Error: $e');
      setState(() {
        loading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1E1E1E)
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
        child: Column(
          children: [
            Icon(Icons.cloud_off_outlined, color: Colors.orange, size: 32),
            SizedBox(height: 8),
            Text(
              'GitHub Contributions Unavailable',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            // UPDATED retry button with cache refresh
            ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  loading = true;
                  errorMessage = null;
                });
                
                try {
                  await ApiCacheRepository.refreshContributionsData(widget.username);
                  await fetchContributions();
                } catch (e) {
                  setState(() {
                    loading = false;
                    errorMessage = e.toString();
                  });
                }
              },
              icon: Icon(Icons.refresh, size: 14),
              label: Text('Retry', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
            ),
          ],
        ),
      );
    }

    if (contributions.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Text("No contributions found."),
      );
    }

    int weeksToShow = 20;
    final latestEntries = contributions.entries.toList().reversed.toList();
    final limitedEntries =
        latestEntries.take(weeksToShow * 7).toList().reversed.toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
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
          ? const Color.fromARGB(255, 71, 70, 70)
          : const Color(0xFFEBEDF0);
    }
    if (count <= 3) return const Color(0xFF9BE9A8);
    if (count <= 8) return const Color(0xFF40C463);
    if (count <= 15) return const Color(0xFF30A14E);
    return const Color(0xFF216E39);
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'github_service.dart';
import 'leetcode_service.dart';

class ApiCacheRepository {
  static const String _githubCacheKey = 'github_stats_cache';
  static const String _leetcodeCacheKey = 'leetcode_stats_cache';
  static const String _contributionsCacheKey = 'github_contributions_cache';
  static const String _githubTimestampKey = 'github_timestamp';
  static const String _leetcodeTimestampKey = 'leetcode_timestamp';
  static const String _contributionsTimestampKey = 'contributions_timestamp';

  static const int _cacheValidityHours = 24;
  static const String baseUrl =
      'https://portfolio-b7szoixjm-tanmays-projects-e3371619.vercel.app';

  static Future<Map<String, dynamic>?> getGitHubStats(String username) async {
    return await _getCachedData(
      _githubCacheKey,
      _githubTimestampKey,
      () => GitHubService(username: username).fetchStats(),
    );
  }

  static Future<Map<String, dynamic>?> getLeetCodeStats(String username) async {
    return await _getCachedData(
      _leetcodeCacheKey,
      _leetcodeTimestampKey,
      () => LeetCodeService(username: username).fetchStats(),
    );
  }

  static Future<Map<String, dynamic>?> getContributions(String username) async {
    return await _getCachedData(
      _contributionsCacheKey,
      _contributionsTimestampKey,
      () => _fetchContributions(username),
    );
  }

  static Future<Map<String, dynamic>?> _getCachedData(
    String cacheKey,
    String timestampKey,
    Future<Map<String, dynamic>> Function() fetchFunction,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if we have cached data and if it's still valid
    final cachedData = prefs.getString(cacheKey);
    final timestamp = prefs.getInt(timestampKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final cacheAge = Duration(milliseconds: now - timestamp);

    if (cachedData != null && cacheAge.inHours < _cacheValidityHours) {
      // Return cached data if it's still valid
      debugPrint(
        '🟢 Using cached data for $cacheKey (${cacheAge.inHours}h old)',
      );
      return json.decode(cachedData);
    }

    try {
      // Fetch fresh data
      debugPrint('🔄 Fetching fresh data for $cacheKey');
      final freshData = await fetchFunction();

      // Cache the fresh data
      await prefs.setString(cacheKey, json.encode(freshData));
      await prefs.setInt(timestampKey, now);

      return freshData;
    } catch (e) {
      // If network fails but we have cached data, return it even if stale
      if (cachedData != null) {
        debugPrint('⚠️ Using stale cached data for $cacheKey due to error: $e');
        return json.decode(cachedData);
      }
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> _fetchContributions(
    String username,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/github/contribution'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'username': username}),
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorData = json.decode(response.body);
      throw Exception('Contributions API Error: ${errorData['error']}');
    }
  }

  // Force refresh functions for manual refresh
  static Future<void> refreshGitHubData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_githubCacheKey);
    await prefs.remove(_githubTimestampKey);
    await getGitHubStats(username);
  }

  static Future<void> refreshLeetCodeData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_leetcodeCacheKey);
    await prefs.remove(_leetcodeTimestampKey);
    await getLeetCodeStats(username);
  }

  static Future<void> refreshContributionsData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_contributionsCacheKey);
    await prefs.remove(_contributionsTimestampKey);
    await getContributions(username);
  }

  static Future<void> refreshAllData(String username) async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all cache keys
    await Future.wait([
      prefs.remove(_githubCacheKey),
      prefs.remove(_leetcodeCacheKey),
      prefs.remove(_contributionsCacheKey),
      prefs.remove(_githubTimestampKey),
      prefs.remove(_leetcodeTimestampKey),
      prefs.remove(_contributionsTimestampKey),
    ]);

    // Fetch fresh data
    await Future.wait([
      getGitHubStats(username),
      getLeetCodeStats(username),
      getContributions(username),
    ]);
  }

  // Utility method to check cache status
  static Future<Map<String, String>> getCacheStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;

    return {
      'github': _getCacheStatusForKey(_githubTimestampKey, now, prefs),
      'leetcode': _getCacheStatusForKey(_leetcodeTimestampKey, now, prefs),
      'contributions': _getCacheStatusForKey(
        _contributionsTimestampKey,
        now,
        prefs,
      ),
    };
  }

  static String _getCacheStatusForKey(
    String timestampKey,
    int now,
    SharedPreferences prefs,
  ) {
    final timestamp = prefs.getInt(timestampKey) ?? 0;
    if (timestamp == 0) return 'No cache';

    final cacheAge = Duration(milliseconds: now - timestamp);
    if (cacheAge.inHours < _cacheValidityHours) {
      return 'Valid (${cacheAge.inHours}h old)';
    } else {
      return 'Expired (${cacheAge.inHours}h old)';
    }
  }
}

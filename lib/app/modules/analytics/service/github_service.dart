import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String username;
  final String token;

  GitHubService({required this.username, required this.token});

  Future<Map<String, dynamic>> fetchStats() async {
    final String query = '''
query(\$username: String!) {
  user(login: \$username) {
    name
    login
    bio
    location
    followers {
      totalCount
    }
    following {
      totalCount
    }
    repositories(first: 100, ownerAffiliations: OWNER, orderBy: {field: CREATED_AT, direction: DESC}) {
      totalCount
      nodes {
        name
        stargazerCount
        forkCount
        primaryLanguage {
          name
        }
      }
    }
    pullRequests {
      totalCount
    }
    issues {
      totalCount
    }
    contributionsCollection {
      totalCommitContributions
      totalPullRequestContributions
      totalIssueContributions
      totalPullRequestReviewContributions
      totalRepositoriesWithContributedCommits
      contributionCalendar {
        weeks {
          contributionDays {
            contributionCount
            date
          }
        }
      }
    }
    repositoriesContributedTo(contributionTypes: [COMMIT, ISSUE, PULL_REQUEST]) {
      totalCount
    }
  }
}
''';

    try {
      final response = await http.post(
        Uri.parse('https://api.github.com/graphql'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'query': query,
          'variables': {'username': username},
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['errors'] != null) {
          throw Exception('GraphQL Error: ${data['errors']}');
        }
        return data['data']['user'];
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch GitHub stats: $e');
    }
  }
}

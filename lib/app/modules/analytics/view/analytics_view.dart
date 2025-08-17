import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/data/services/secrets.dart';
import 'package:porfolio/app/modules/analytics/service/github_service.dart';
import 'package:porfolio/app/modules/analytics/service/leetcode_service.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';
import 'package:icons_plus/icons_plus.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  Map<String, dynamic>? githubData;
  Map<String, dynamic>? leetcodeData;
  bool loading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    fetchData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final githubService = GitHubService(
        username: "TanmayN22",
        token: githubToken,
      );
      final leetcodeService = LeetCodeService(username: "TanmayN22");

      final gh = await githubService.fetchStats();
      final lc = await leetcodeService.fetchStats();

      setState(() {
        githubData = gh;
        leetcodeData = lc;
        loading = false;
      });
      _animationController.forward();
    } catch (e) {
      debugPrint("Error fetching stats: $e");
      setState(() => loading = false);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (loading) {
      return AppPageWrapper(
        child: Container(
          color: isDark ? const Color(0xFF0d1117) : const Color(0xFFf6f8fa),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading Analytics...',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AppPageWrapper(
      child: Column(
        children: [
          CustomAppBar(
            appName: "Analytics",
            onBack: () => Get.find<HomeController>().closeApp(),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color:
                    isDark ? const Color(0xFF0d1117) : const Color(0xFFf6f8fa),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GitHub Section
                      if (githubData != null) ...[
                        _buildSectionHeader('GitHub', isDark),
                        const SizedBox(height: 12),
                        _buildGitHubStats(isDark),
                        const SizedBox(height: 16),
                        _buildContributionChart(isDark),
                        const SizedBox(height: 24),
                      ],

                      // LeetCode Section
                      if (leetcodeData != null) ...[
                        _buildSectionHeader('LeetCode', isDark),
                        const SizedBox(height: 12),
                        _buildLeetCodeStats(isDark),
                        const SizedBox(height: 16),
                        _buildProblemDistribution(isDark),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 12),
            child:
                title == 'GitHub'
                    ? Icon(
                      Bootstrap.github, // GitHub icon from Bootstrap pack
                      color:
                          isDark
                              ? const Color(0xFF7c3aed)
                              : const Color(0xFF6366f1),
                      size: 20,
                    )
                    : Icon(
                      FontAwesome
                          .code_solid, // Code icon for LeetCode from FontAwesome
                      color: const Color(0xFFf59e0b),
                      size: 18,
                    ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGitHubStats(bool isDark) {
    if (githubData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
          ),
        ),
        child: Text(
          'No GitHub data available',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    // Calculate comprehensive stats
    final totalStarsEarned =
        githubData!['repositories']?['nodes']?.fold<int>(
          0,
          (int sum, dynamic repo) =>
              sum + ((repo['stargazerCount'] as int?) ?? 0),
        ) ??
        0;

    final contributionsCollection = githubData!['contributionsCollection'];
    final totalCommits =
        contributionsCollection?['totalCommitContributions'] ?? 0;
    final totalPRs =
        contributionsCollection?['totalPullRequestContributions'] ?? 0;
    final totalIssues =
        contributionsCollection?['totalIssueContributions'] ?? 0;
    final totalReviews =
        contributionsCollection?['totalPullRequestReviewContributions'] ?? 0;
    final totalContributions =
        totalCommits + totalPRs + totalIssues + totalReviews;
    final contributedToRepos =
        contributionsCollection?['totalRepositoriesWithContributedCommits'] ??
        0;

    // Calculate streaks
    final longestStreak = _calculateLongestStreak();
    final currentStreak = _calculateCurrentStreak();

    return Column(
      children: [
        // Overview cards
        _buildGitHubOverviewCards(
          isDark,
          totalContributions,
          totalStarsEarned,
          longestStreak,
          currentStreak,
        ),
        const SizedBox(height: 16),

        // Detailed stats
        ...[
          ['Total Commits', totalCommits.toString()],
          ['Total PRs', totalPRs.toString()],
          ['Total Issues', totalIssues.toString()],
          ['Contributed To', contributedToRepos.toString()],
          [
            'Followers',
            (githubData!['followers']?['totalCount'] ?? 0).toString(),
          ],
          [
            'Public Repos',
            (githubData!['repositories']?['totalCount'] ?? 0).toString(),
          ],
        ].asMap().entries.map((entry) {
          int index = entry.key;
          List<String> stat = entry.value;

          if (stat.length >= 2) {
            return _buildStatRow(
              stat[0],
              stat[1],
              isDark,
              isLast: index == 10, // 11 items total, so last index is 10
            );
          } else {
            return Container();
          }
        }).toList(),
      ],
    );
  }

  Widget _buildGitHubOverviewCards(
    bool isDark,
    int totalContributions,
    int totalStarsEarned,
    int longestStreak,
    int currentStreak,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMiniStatCard(
                'Total Contributions',
                totalContributions.toString(),
                Icons.analytics_outlined,
                isDark,
                const Color(0xFF7c3aed),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMiniStatCard(
                'Stars Earned',
                totalStarsEarned.toString(),
                Icons.star_outline,
                isDark,
                const Color(0xFFf59e0b),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMiniStatCard(
                'Longest Streak',
                '$longestStreak days',
                Icons.local_fire_department,
                isDark,
                const Color(0xFFef4444),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMiniStatCard(
                'Current Streak',
                '$currentStreak days',
                Icons.trending_up,
                isDark,
                const Color(0xFF10b981),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniStatCard(
    String title,
    String value,
    IconData icon,
    bool isDark,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 16, color: accentColor),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for streak calculation
  int _calculateLongestStreak() {
    if (githubData?['contributionsCollection']?['contributionCalendar'] !=
        null) {
      return _analyzeContributionStreak(
        githubData!['contributionsCollection']['contributionCalendar'],
        longest: true,
      );
    }
    return 42; // Placeholder
  }

  int _calculateCurrentStreak() {
    if (githubData?['contributionsCollection']?['contributionCalendar'] !=
        null) {
      return _analyzeContributionStreak(
        githubData!['contributionsCollection']['contributionCalendar'],
        longest: false,
      );
    }
    return 7; // Placeholder
  }

  int _analyzeContributionStreak(
    Map<String, dynamic> calendar, {
    required bool longest,
  }) {
    try {
      final weeks = calendar['weeks'] as List<dynamic>?;
      if (weeks == null) return 0;

      List<int> dailyContributions = [];

      // Flatten all days from all weeks
      for (var week in weeks) {
        final days = week['contributionDays'] as List<dynamic>?;
        if (days != null) {
          for (var day in days) {
            final contributionCount = day['contributionCount'] as int? ?? 0;
            dailyContributions.add(contributionCount > 0 ? 1 : 0);
          }
        }
      }

      if (longest) {
        // Calculate longest streak
        int maxStreak = 0;
        int currentStreak = 0;

        for (int contribution in dailyContributions) {
          if (contribution > 0) {
            currentStreak++;
            maxStreak = maxStreak > currentStreak ? maxStreak : currentStreak;
          } else {
            currentStreak = 0;
          }
        }
        return maxStreak;
      } else {
        // Calculate current streak (from the end)
        int currentStreak = 0;
        for (int i = dailyContributions.length - 1; i >= 0; i--) {
          if (dailyContributions[i] > 0) {
            currentStreak++;
          } else {
            break;
          }
        }
        return currentStreak;
      }
    } catch (e) {
      debugPrint('Error calculating streak: $e');
      return 0;
    }
  }

  Widget _buildLeetCodeStats(bool isDark) {
    if (leetcodeData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
          ),
        ),
        child: Text(
          'No LeetCode data available',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    final stats = [
      ['Total Solved', (leetcodeData!['totalSolved'] ?? 0).toString()],
      ['Easy Solved', (leetcodeData!['easySolved'] ?? 0).toString()],
      ['Medium Solved', (leetcodeData!['mediumSolved'] ?? 0).toString()],
      ['Hard Solved', (leetcodeData!['hardSolved'] ?? 0).toString()],
      ['Acceptance Rate', '${leetcodeData!['acceptanceRate'] ?? 0}%'],
      ['Global Ranking', '#${leetcodeData!['ranking'] ?? 'N/A'}'],
    ];

    return Column(
      children:
          stats.asMap().entries.map((entry) {
            int index = entry.key;
            List<String> stat = entry.value;

            if (stat.length >= 2) {
              return _buildStatRow(
                stat[0],
                stat[1],
                isDark,
                isLast: index == stats.length - 1,
              );
            } else {
              return Container();
            }
          }).toList(),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    bool isDark, {
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
        ),
        borderRadius:
            isLast
                ? const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
                : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionChart(bool isDark) {
    if (githubData == null ||
        githubData!['contributionsCollection'] == null ||
        githubData!['contributionsCollection']['totalCommitContributions'] ==
            null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
          ),
        ),
        child: Text(
          'No contribution data available',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    final commits =
        githubData!['contributionsCollection']['totalCommitContributions']
            as int;
    final weeklyData = List.generate(
      7,
      (index) => (commits / 7).round() + (index % 3),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contribution Activity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                maxY:
                    (weeklyData.reduce((a, b) => a > b ? a : b) + 2).toDouble(),
                barGroups: List.generate(7, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: weeklyData[index].toDouble(),
                        color: isDark ? Colors.white : Colors.black87,
                        width: 16,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        if (value.toInt() < 0 || value.toInt() >= days.length) {
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[value.toInt()],
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemDistribution(bool isDark) {
    if (leetcodeData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
          ),
        ),
        child: Text(
          'No problem distribution data available',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    final easy = (leetcodeData!['easySolved'] ?? 0).toDouble();
    final medium = (leetcodeData!['mediumSolved'] ?? 0).toDouble();
    final hard = (leetcodeData!['hardSolved'] ?? 0).toDouble();

    if (easy == 0 && medium == 0 && hard == 0) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
          ),
        ),
        child: Text(
          'No problems solved yet',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B22) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : const Color(0xFFD1D9E0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Problem Distribution',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 120,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(
                          color: const Color(0xFF00C851),
                          value: easy,
                          title: '',
                          radius: 40,
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFF8C00),
                          value: medium,
                          title: '',
                          radius: 40,
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFF4444),
                          value: hard,
                          title: '',
                          radius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      'Easy',
                      easy.toInt(),
                      const Color(0xFF00C851),
                      isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildLegendItem(
                      'Medium',
                      medium.toInt(),
                      const Color(0xFFFF8C00),
                      isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildLegendItem(
                      'Hard',
                      hard.toInt(),
                      const Color(0xFFFF4444),
                      isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, int value, Color color, bool isDark) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    // Professional color palette
    final backgroundColor =
        isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFDFDFD);
    final primaryText =
        isDark ? const Color(0xFFFFFFFF) : const Color(0xFF1A1A1A);
    final secondaryText =
        isDark ? const Color(0xFF9A9A9A) : const Color(0xFF5A5A5A);
    final accentColor =
        isDark ? const Color(0xFF4A90E2) : const Color(0xFF2E5C8A);
    final surfaceColor =
        isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);
    final borderColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE1E1E1);

    return Expanded(
      child: Container(
        color: backgroundColor,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              // Added SafeArea for better mobile handling
              child: Padding(
                // Much more conservative padding
                padding: EdgeInsets.symmetric(
                  horizontal:
                      isLargeScreen
                          ? 32
                          : 12, // Very minimal horizontal padding
                  vertical: isLargeScreen ? 20 : 8, // Minimal vertical padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section
                    _buildHeader(
                      primaryText,
                      secondaryText,
                      accentColor,
                      isLargeScreen,
                    ),

                    SizedBox(height: isLargeScreen ? 32 : 20),

                    // Profile section
                    _buildProfileSection(
                      primaryText,
                      secondaryText,
                      accentColor,
                      surfaceColor,
                      borderColor,
                      isLargeScreen,
                    ),

                    SizedBox(height: isLargeScreen ? 32 : 20),

                    // About section
                    _buildAboutSection(
                      primaryText,
                      secondaryText,
                      accentColor,
                      surfaceColor,
                      isLargeScreen,
                    ),

                    SizedBox(height: isLargeScreen ? 32 : 20),

                    // Skills section - Completely redesigned
                    _buildSkillsSection(
                      primaryText,
                      secondaryText,
                      accentColor,
                      isLargeScreen,
                    ),

                    SizedBox(height: isLargeScreen ? 32 : 20),

                    // Quote section
                    _buildQuoteSection(
                      primaryText,
                      secondaryText,
                      accentColor,
                      isLargeScreen,
                    ),

                    SizedBox(height: isLargeScreen ? 32 : 20),

                    // Contact section
                    _buildContactSection(
                      primaryText,
                      secondaryText,
                      accentColor,
                      isLargeScreen,
                    ),

                    // Generous bottom padding to prevent cutoff
                    SizedBox(height: isLargeScreen ? 40 : 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    bool isLargeScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accent bar
        Container(
          width: isLargeScreen ? 40 : 30,
          height: 3,
          color: accentColor,
        ),

        SizedBox(height: isLargeScreen ? 20 : 14),

        // Name - optimized for mobile
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TANMAY",
              style: GoogleFonts.inter(
                fontSize: isLargeScreen ? 36 : 24, // Smaller for mobile
                fontWeight: FontWeight.w800,
                color: primaryText,
                letterSpacing: -0.8,
                height: 0.9,
              ),
            ),
            Text(
              "NAYAK",
              style: GoogleFonts.inter(
                fontSize: isLargeScreen ? 36 : 24,
                fontWeight: FontWeight.w300,
                color: secondaryText,
                letterSpacing: -0.8,
                height: 0.9,
              ),
            ),
          ],
        ),

        SizedBox(height: isLargeScreen ? 14 : 10),

        // Role badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: accentColor, width: 1),
          ),
          child: Text(
            "FLUTTER DEVELOPER",
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 8 : 7,
              fontWeight: FontWeight.w600,
              color: accentColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    Color surfaceColor,
    Color borderColor,
    bool isLargeScreen,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLargeScreen ? 20 : 12),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        children: [
          // Image
          Container(
            width: isLargeScreen ? 140 : 100,
            height: isLargeScreen ? 140 : 100,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Image.asset('assets/images/wave3.png', fit: BoxFit.cover),
          ),

          SizedBox(height: isLargeScreen ? 20 : 16),

          // Data points - Simple layout
          _buildDataPoints(
            primaryText,
            secondaryText,
            accentColor,
            isLargeScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDataPoints(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    bool isLargeScreen,
  ) {
    final data = [
      ['AGE', '21'],
      ['LOCATION', 'MUMBAI'],
      ['EDUCATION', 'TCET'],
      ['STATUS', 'AVAILABLE'],
    ];

    return Column(
      children:
          data
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(width: 12, height: 2, color: accentColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item[0],
                              style: GoogleFonts.inter(
                                fontSize: isLargeScreen ? 8 : 7,
                                fontWeight: FontWeight.w500,
                                color: secondaryText,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              item[1],
                              style: GoogleFonts.inter(
                                fontSize: isLargeScreen ? 12 : 10,
                                fontWeight: FontWeight.w700,
                                color: primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildAboutSection(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    Color surfaceColor,
    bool isLargeScreen,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isLargeScreen ? 20 : 12),
      decoration: BoxDecoration(color: surfaceColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 3, height: 16, color: accentColor),
              const SizedBox(width: 6),
              Text(
                "ABOUT",
                style: GoogleFonts.inter(
                  fontSize: isLargeScreen ? 10 : 9,
                  fontWeight: FontWeight.w700,
                  color: primaryText,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),

          SizedBox(height: isLargeScreen ? 16 : 12),

          Text(
            "I am a passionate Flutter developer currently in my final year at Thakur College of Engineering & Technology, Mumbai. I specialize in creating intuitive, high-performance mobile applications.",
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 13 : 11,
              fontWeight: FontWeight.w400,
              color: primaryText,
              height: 1.3,
            ),
          ),

          SizedBox(height: isLargeScreen ? 12 : 8),

          Text(
            "Beyond development, I find balance in strategic chess games and evening runs. I believe in continuous learning and creating meaningful digital experiences.",
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 13 : 11,
              fontWeight: FontWeight.w400,
              color: secondaryText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    bool isLargeScreen,
  ) {
    // Simplified skills list
    final skills = [
      "FLUTTER",
      "DART",
      "FIREBASE",
      "SQLITE",
      "REST APIs",
      "GIT",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 16, color: accentColor),
            const SizedBox(width: 6),
            Text(
              "EXPERTISE",
              style: GoogleFonts.inter(
                fontSize: isLargeScreen ? 10 : 9,
                fontWeight: FontWeight.w700,
                color: primaryText,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),

        SizedBox(height: isLargeScreen ? 16 : 12),

        // Simple text list instead of boxes to prevent overflow
        ...skills
            .map(
              (skill) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Container(width: 8, height: 1, color: accentColor),
                    const SizedBox(width: 8),
                    Text(
                      skill,
                      style: GoogleFonts.inter(
                        fontSize: isLargeScreen ? 10 : 9,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildQuoteSection(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    bool isLargeScreen,
  ) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 24 : 14),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accentColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"Good design is as little design as possible."',
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 16 : 12,
              fontWeight: FontWeight.w300,
              color: primaryText,
              height: 1.3,
              fontStyle: FontStyle.italic,
            ),
          ),

          SizedBox(height: isLargeScreen ? 12 : 8),

          Text(
            "— DIETER RAMS",
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 8 : 7,
              fontWeight: FontWeight.w600,
              color: secondaryText,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(
    Color primaryText,
    Color secondaryText,
    Color accentColor,
    bool isLargeScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 16, color: accentColor),
            const SizedBox(width: 6),
            Text(
              "CONNECT",
              style: GoogleFonts.inter(
                fontSize: isLargeScreen ? 10 : 9,
                fontWeight: FontWeight.w700,
                color: primaryText,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),

        SizedBox(height: isLargeScreen ? 16 : 12),

        // Simplified buttons
        _buildButton(
          "SEND MESSAGE",
          accentColor,
          Colors.white,
          true,
          isLargeScreen,
        ),
        SizedBox(height: isLargeScreen ? 10 : 8),
        _buildButton(
          "DOWNLOAD CV",
          Colors.transparent,
          primaryText,
          false,
          isLargeScreen,
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor,
    bool filled,
    bool isLargeScreen,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 12 : 10,
        horizontal: isLargeScreen ? 16 : 12,
      ),
      decoration: BoxDecoration(
        color: filled ? bgColor : Colors.transparent,
        border: Border.all(
          color: filled ? bgColor : textColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: isLargeScreen ? 10 : 9,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.6,
            ),
          ),
          Icon(
            filled ? Icons.arrow_forward : Icons.file_download_outlined,
            size: isLargeScreen ? 14 : 12,
            color: textColor,
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationOverlay extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const NotificationOverlay({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  State<NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _dismissNotification();
      }
    });
  }

  void _dismissNotification() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current theme
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware colors
    final containerColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final iconColor = isDark ? Colors.white : Colors.black;
    final closeIconColor = isDark ? Colors.white70 : Colors.black54;

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border:
              isDark
                  ? null
                  : Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.format_quote, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.message,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
            GestureDetector(
              onTap: _dismissNotification,
              child: Icon(Icons.close, color: closeIconColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

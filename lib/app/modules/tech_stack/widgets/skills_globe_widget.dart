import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math.dart' as vector;

class IconItem {
  final String name;
  final String lightAssetPath;
  final String darkAssetPath;
  vector.Vector3 position;
  double scale;

  IconItem({
    required this.name,
    required this.lightAssetPath,
    required this.darkAssetPath,
    required this.position,
    this.scale = 1.0,
  });
}

class SkillsGlobeWidget extends StatefulWidget {
  const SkillsGlobeWidget({Key? key}) : super(key: key);

  @override
  State<SkillsGlobeWidget> createState() => _SkillsGlobeWidgetState();
}

class _SkillsGlobeWidgetState extends State<SkillsGlobeWidget>
    with TickerProviderStateMixin {
  List<IconItem> iconItems = [];
  late AnimationController _rotationController;
  late AnimationController _floatController;

  // Your skills data with both light and dark paths
  final List<Map<String, dynamic>> _skillsData = [
    {
      'name': 'Python',
      'lightPath': 'assets/icons/light/python.svg',
      'darkPath': 'assets/icons/dark/python.svg',
    },
    {
      'name': 'Atlassian',
      'lightPath': 'assets/icons/light/atlassian.svg',
      'darkPath': 'assets/icons/dark/atlassian.svg',
    },
    {
      'name': 'Dart',
      'lightPath': 'assets/icons/light/dart.svg',
      'darkPath': 'assets/icons/dark/dart.svg',
    },
    {
      'name': 'Flutter',
      'lightPath': 'assets/icons/light/flutter.svg',
      'darkPath': 'assets/icons/dark/flutter.svg',
    },
    {
      'name': 'Firebase',
      'lightPath': 'assets/icons/light/firebase.svg',
      'darkPath': 'assets/icons/dark/firebase.svg',
    },
    {
      'name': 'SQLite',
      'lightPath': 'assets/icons/light/sqlite.svg',
      'darkPath': 'assets/icons/dark/sqlite.svg',
    },
    {
      'name': 'MongoDB',
      'lightPath': 'assets/icons/light/mongodb.svg',
      'darkPath': 'assets/icons/dark/mongodb.svg',
    },
    {
      'name': 'Fast APIs',
      'lightPath': 'assets/icons/light/fastapi.svg',
      'darkPath': 'assets/icons/dark/fastapi.svg',
    },
    {
      'name': 'Node.js',
      'lightPath': 'assets/icons/light/nodejs.svg',
      'darkPath': 'assets/icons/dark/nodejs.svg',
    },
    {
      'name': 'VS Code',
      'lightPath': 'assets/icons/light/vscode.svg',
      'darkPath': 'assets/icons/dark/vscode.svg',
    },
    {
      'name': 'Git',
      'lightPath': 'assets/icons/light/git.svg',
      'darkPath': 'assets/icons/dark/git.svg',
    },
    {
      'name': 'Android Studio',
      'lightPath': 'assets/icons/light/androidstudio.svg',
      'darkPath': 'assets/icons/dark/androidstudio.svg',
    },
    {
      'name': 'Figma',
      'lightPath': 'assets/icons/light/figma.svg',
      'darkPath': 'assets/icons/dark/figma.svg',
    },
    {
      'name': 'Jira',
      'lightPath': 'assets/icons/light/jira.svg',
      'darkPath': 'assets/icons/dark/jira.svg',
    },
    {
      'name': 'Slack',
      'lightPath': 'assets/icons/light/slack.svg',
      'darkPath': 'assets/icons/dark/slack.svg',
    },
    {
      'name': 'Android',
      'lightPath': 'assets/icons/light/android.svg',
      'darkPath': 'assets/icons/dark/android.svg',
    },
    {
      'name': 'Apple',
      'lightPath': 'assets/icons/light/apple.svg',
      'darkPath': 'assets/icons/dark/apple.svg',
    },
    {
      'name': 'MySql',
      'lightPath': 'assets/icons/light/mysql.svg',
      'darkPath': 'assets/icons/dark/mysql.svg',
    },
  ];

  Offset _lastPanPosition = Offset.zero;
  bool _isInteracting = false;
  DateTime? _lastInteractionTime;

  final double radius = 100.0;

  @override
  void initState() {
    super.initState();
    _initializeIcons();
    _setupAnimations();
  }

  void _initializeIcons() {
    iconItems = List.generate(_skillsData.length, (index) {
      final skill = _skillsData[index];

      final phi = math.acos(-1.0 + (2.0 * index) / _skillsData.length);
      final theta = math.sqrt(_skillsData.length * math.pi) * phi;

      final x = radius * math.cos(theta) * math.sin(phi);
      final y = radius * math.sin(theta) * math.sin(phi);
      final z = radius * math.cos(phi);

      return IconItem(
        name: skill['name'],
        lightAssetPath: skill['lightPath'],
        darkAssetPath: skill['darkPath'],
        position: vector.Vector3(x, y, z),
        scale: 1.0,
      );
    });
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _rotationController.addListener(_performAutoRotation);
    _rotationController.repeat();
    _floatController.repeat();
  }

  void _performAutoRotation() {
    if (!mounted || iconItems.isEmpty || _isInteracting) return;

    if (_lastInteractionTime != null) {
      final timeSinceInteraction = DateTime.now().difference(
        _lastInteractionTime!,
      );
      if (timeSinceInteraction.inMilliseconds < 2000) return;
    }

    setState(() {
      const rotationSpeed = 0.008;
      final deltaRotationMatrix = vector.Matrix4.rotationY(rotationSpeed);

      for (var item in iconItems) {
        final transformed = deltaRotationMatrix.transform3(item.position);
        item.position
          ..x = transformed.x
          ..y = transformed.y
          ..z = transformed.z;
      }
    });
  }

  void _handlePanStart(DragStartDetails details) {
    _isInteracting = true;
    _lastPanPosition = details.localPosition;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!mounted || iconItems.isEmpty) return;

    setState(() {
      final delta = details.localPosition - _lastPanPosition;
      final deltaX = -delta.dy * 0.003;
      final deltaY = delta.dx * 0.003;

      final deltaMatrixX = vector.Matrix4.rotationX(deltaX);
      final deltaMatrixY = vector.Matrix4.rotationY(deltaY);
      final combinedMatrix = deltaMatrixY..multiply(deltaMatrixX);

      for (var item in iconItems) {
        final transformed = combinedMatrix.transform3(item.position);
        item.position
          ..x = transformed.x
          ..y = transformed.y
          ..z = transformed.z;
      }
    });

    _lastPanPosition = details.localPosition;
  }

  void _handlePanEnd(DragEndDetails details) {
    _isInteracting = false;
    _lastInteractionTime = DateTime.now();

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted && !_isInteracting) {
        _rotationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;

    if (iconItems.isEmpty) {
      return Container(
        color: backgroundColor,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: Center(
          child: SizedBox(
            width: 350,
            height: 350,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _rotationController,
                _floatController,
              ]),
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children:
                      iconItems.map((item) {
                        // Calculate position
                        final center = Offset(
                          175 + item.position.x, // Half of container width
                          175 + item.position.y, // Half of container height
                        );

                        // Calculate depth and opacity
                        final normalizedZ =
                            (item.position.z + radius) / (radius * 2);
                        final opacity = math.max(
                          0.4,
                          math.min(1.0, normalizedZ),
                        );
                        final depthScale = math.max(0.6, normalizedZ);

                        // Floating animation
                        final floatOffset =
                            1.5 *
                            math.sin(
                              _floatController.value * 2 * math.pi +
                                  item.position.x * 0.01,
                            );
                        final adjustedCenter = center.translate(0, floatOffset);

                        final iconSize = 28.0 * item.scale * depthScale;

                        return Positioned(
                          left: adjustedCenter.dx - iconSize / 2,
                          top: adjustedCenter.dy - iconSize / 2,
                          child: Opacity(
                            opacity: opacity,
                            child: SizedBox(
                              width: iconSize,
                              height: iconSize,
                              child: SvgPicture.asset(
                                isDark
                                    ? item.darkAssetPath
                                    : item.lightAssetPath,
                                width: iconSize,
                                height: iconSize,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _floatController.dispose();
    super.dispose();
  }
}

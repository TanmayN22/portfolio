import 'package:flutter/material.dart';

// NEW: An enum to define the possible project statuses
enum ProjectStatus { completed, inProgress, mvp, updating }

// NEW: An extension to get a user-friendly display name for the enum
extension ProjectStatusExtension on ProjectStatus {
  String get displayName {
    switch (this) {
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.mvp:
        return 'MVP';
      case ProjectStatus.updating:
        return 'Updating';
    }
  }
}

class Project {
  final String iconPath;
  final String name;
  final String githuburl;
  final List<String> imagePaths;
  final String description;
  final Color accentColor;
  final ProjectStatus status;
  final Map<String,String> techStack;

  const Project({
    required this.iconPath,
    required this.name,
    required this.githuburl,
    required this.imagePaths,
    required this.description,
    required this.accentColor,
    // --- NEW CONSTRUCTOR PARAMETERS ---
    required this.status,
    required this.techStack,
  });
}
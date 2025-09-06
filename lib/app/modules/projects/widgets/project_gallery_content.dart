// The code inside this file is the same as the last version,
// just rename the class from FullScreenGalleryContent to ProjectGalleryContent.

import 'package:flutter/material.dart';

class ProjectGalleryContent extends StatefulWidget { // Renamed class
  final List<String> imagePaths;
  final int initialIndex;
  final VoidCallback onClose;

  const ProjectGalleryContent({ // Renamed constructor
    super.key,
    required this.imagePaths,
    required this.initialIndex,
    required this.onClose,
  });

  @override
  State<ProjectGalleryContent> createState() => _ProjectGalleryContentState();
}

class _ProjectGalleryContentState extends State<ProjectGalleryContent> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: kToolbarHeight,
          color: Colors.black,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: widget.onClose,
              ),
              Expanded(
                child: Text(
                  '${_currentIndex + 1} / ${widget.imagePaths.length}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: kToolbarHeight),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imagePaths.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.asset(
                          widget.imagePaths[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
                if (_currentIndex > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildNavArrow(
                      Icons.arrow_back_ios_new,
                      () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                if (_currentIndex < widget.imagePaths.length - 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildNavArrow(
                      Icons.arrow_forward_ios,
                      () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavArrow(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.4),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 22),
        onPressed: onPressed,
      ),
    );
  }
}
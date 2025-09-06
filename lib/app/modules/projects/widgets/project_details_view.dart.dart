import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/modules/projects/model/project_model.dart';
import 'package:porfolio/app/modules/projects/widgets/project_gallery_content.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsView extends StatefulWidget {
  final Project project;

  const ProjectDetailsView({super.key, required this.project});

  @override
  State<ProjectDetailsView> createState() => _ProjectDetailsViewState();
}

class _ProjectDetailsViewState extends State<ProjectDetailsView> {
  // --- The rest of the state class is unchanged, only the build method needs updates ---
  int? _selectedImageIndex;
  late final PageController _galleryPageController;
  int _galleryPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _galleryPageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _galleryPageController.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPageWrapper(
      child:
          _selectedImageIndex == null
              ? _buildAppDetailsContent(context)
              : ProjectGalleryContent(
                imagePaths: widget.project.imagePaths,
                initialIndex: _selectedImageIndex!,
                onClose: () => setState(() => _selectedImageIndex = null),
              ),
    );
  }

  Widget _buildAppDetailsContent(BuildContext context) {
    final int pageCount = (widget.project.imagePaths.length / 3).ceil();

    return Column(
      children: [
        CustomAppBar(
          onBack: () => Get.find<HomeController>().closeApp(),
          appName: widget.project.name,
          backgroundColor: widget.project.accentColor,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HEADER SECTION (Unchanged) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          widget.project.iconPath,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.project.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.project.status.displayName,
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.project.accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- UPDATED: TECH STACK ROW USING YOUR ICONS ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        widget.project.techStack.entries.map((entry) {
                          final techName = entry.key;
                          final iconPath = entry.value;
                          return Expanded(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  iconPath,
                                  height: 24,
                                ), // Use Image.asset
                                const SizedBox(height: 8),
                                Text(
                                  techName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // --- GITHUB BUTTON & GALLERY (Unchanged) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchURL(widget.project.githuburl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.project.accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Github',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // The rest of the file (gallery, dots, about section) is unchanged...
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 280,
                      child: PageView.builder(
                        controller: _galleryPageController,
                        itemCount: pageCount,
                        onPageChanged:
                            (index) =>
                                setState(() => _galleryPageIndex = index),
                        itemBuilder: (context, pageIndex) {
                          final int startIndex = pageIndex * 3;
                          final int endIndex =
                              (startIndex + 3 >
                                      widget.project.imagePaths.length)
                                  ? widget.project.imagePaths.length
                                  : startIndex + 3;
                          final pageImages = widget.project.imagePaths.sublist(
                            startIndex,
                            endIndex,
                          );

                          return Row(
                            children: List.generate(3, (imageIndexInRow) {
                              if (imageIndexInRow < pageImages.length) {
                                final imagePath = pageImages[imageIndexInRow];
                                final absoluteImageIndex =
                                    startIndex + imageIndexInRow;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: GestureDetector(
                                      onTap:
                                          () => setState(
                                            () =>
                                                _selectedImageIndex =
                                                    absoluteImageIndex,
                                          ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          height: 280,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Expanded(child: SizedBox());
                            }),
                          );
                        },
                      ),
                    ),
                    if (_galleryPageIndex > 0)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildNavArrow(
                          Icons.arrow_back_ios_new,
                          () => _galleryPageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                    if (_galleryPageIndex < pageCount - 1)
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildNavArrow(
                          Icons.arrow_forward_ios,
                          () => _galleryPageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDotsIndicator(pageCount),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About this app',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator(int pageCount) {
    // ...
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        bool isSelected = _galleryPageIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8,
          width: isSelected ? 24 : 8,
          decoration: BoxDecoration(
            color:
                isSelected ? widget.project.accentColor : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildNavArrow(IconData icon, VoidCallback onPressed) {
    // ...
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}

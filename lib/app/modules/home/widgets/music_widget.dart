import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/music_controller.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicController controller = Get.put(MusicController());
    // container
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // the image of the song
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    controller.currentSong.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.3),
                          child: Icon(
                            Icons.music_note,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),

          // Add exactly 5 pixels of space here
          const SizedBox(width: 5),

          // Title, artist, and buttons section in a Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Song title
                  Obx(
                    () => Text(
                      controller.currentSong.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Artist name
                  Obx(
                    () => Text(
                      controller.currentSong.artist,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 12), // Space between text and buttons
                  // Control buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: controller.skipPrevious,
                        icon: Icon(
                          Icons.skip_previous,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.8),
                        ),
                        iconSize: 20,
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Obx(
                          () => IconButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : controller.playPause,
                            icon: Icon(
                              controller.isLoading.value
                                  ? Icons.hourglass_empty
                                  : (controller.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow),
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: controller.skipNext,
                        icon: Icon(
                          Icons.skip_next,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.8),
                        ),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

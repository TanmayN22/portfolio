import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  late AudioPlayer player;
  bool isPlaying = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      await player.setAsset('assets/audio/blue.mp3');
      player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            isPlaying = state.playing;
            isLoading = state.processingState == ProcessingState.loading;
          });
        }
      });
    } catch (e) {
      debugPrint('error loading $e');
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _playPause() async {
    try {
      if (isPlaying) {
        await player.pause();
      } else {
        await player.play();
      }
    } catch (e) {
      print('Error playing');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                image: const DecorationImage(
                  image: AssetImage("assets/images/blue.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Blue",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Yung Kai",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  iconSize: 24,
                ),
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: isLoading ? null : _playPause,
                    icon: Icon(
                      isLoading
                          ? Icons.hourglass_empty
                          : (isPlaying ? Icons.pause : Icons.play_arrow),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                  ),
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

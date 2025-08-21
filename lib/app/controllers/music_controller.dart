import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:porfolio/app/data/models/song_model.dart';

class MusicController extends GetxController {
  late AudioPlayer _player;

  final RxList<Song> _playlist = <Song>[].obs;
  final RxInt _currentIndex = 0.obs;

  final RxBool isPlaying = false.obs;
  final RxBool isLoading = true.obs;

  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex.value;
  Song get currentSong =>
      _playlist.isNotEmpty ? _playlist[_currentIndex.value] : _getDefaultSong();

  @override
  void onInit() {
    super.onInit();
    _player = AudioPlayer();
    _initializePlaylist();
    _setupPlayerListeners();
  }

  void _initializePlaylist() {
    _playlist.value = [
      Song(
        title: "Blue",
        artist: "Yung Kai",
        audioPath: "assets/audio/blue.mp3",
        imagePath: "assets/images/blue.jpeg",
      ),
      Song(
        title: "Self Love",
        artist: "Metro Boomin",
        audioPath: "assets/audio/self_love.mp3",
        imagePath: "assets/images/spider.jpg",
      ),
      Song(
        title: "Golden Brown",
        artist: "The Stranglers",
        audioPath: "assets/audio/golden_brown.mp3",
        imagePath: "assets/images/golden_brown.jpeg",
      ),
    ];
    if (_playlist.isNotEmpty) {
      _loadCurrentTrack();
    }
  }

  void _setupPlayerListeners() {
    _player.playerStateStream.listen((state) {
      print(
        '🎵 Player state: ${state.playing}, Processing: ${state.processingState}',
      );

      isPlaying.value = state.playing;
      isLoading.value = state.processingState == ProcessingState.loading;

      // Only handle completion if we're actually at the end and playing was true
      if (state.processingState == ProcessingState.completed &&
          !isLoading.value) {
        print('🎵 Track completed, moving to next...');
        // Use a delayed call to avoid race conditions
        Future.delayed(const Duration(milliseconds: 100), () {
          _handleTrackCompletion();
        });
      }
    });

    _currentIndex.listen((index) {
      print('🎵 Current index changed to: $index (${currentSong.title})');
    });
  }

  Future<void> _loadCurrentTrack() async {
    if (_playlist.isEmpty) return;

    try {
      isLoading.value = true;

      print('🎵 Loading track: ${currentSong.title}');
      print('🎵 Audio path: ${currentSong.audioPath}');

      await _player.setAsset(currentSong.audioPath);

      print('🎵 Track loaded successfully: ${currentSong.title}');

      isLoading.value = false;
    } catch (e) {
      print('❌ Error loading track: $e');
      isLoading.value = false;
    }
  }

  Future<void> playPause() async {
    try {
      if (isPlaying.value) {
        await _player.pause();
      } else {
        await _player.play();
      }
    } catch (e) {}
  }

  Future<void> skipNext() async {
    if (_playlist.isEmpty) return;

    bool wasPlaying = isPlaying.value;

    await _player.stop();

    _currentIndex.value = (_currentIndex.value + 1) % _playlist.length;

    await _loadCurrentTrack();

    if (wasPlaying) {
      await _player.play();
    }
  }

  Future<void> skipPrevious() async {
    if (_playlist.isEmpty) return;

    bool wasPlaying = isPlaying.value;

    await _player.stop();

    _currentIndex.value =
        _currentIndex.value > 0
            ? _currentIndex.value - 1
            : _playlist.length - 1;

    await _loadCurrentTrack();

    if (wasPlaying) {
      await _player.play();
    }
  }

  Future<void> _handleTrackCompletion() async {
    print('🎵 Track completion handler called');

    try {
      // Prevent multiple simultaneous calls
      if (isLoading.value) {
        print('🎵 Already loading, skipping track completion');
        return;
      }

      // Stop the current track completely and reset position
      await _player.stop();
      await _player.seek(Duration.zero);

      // Move to next track
      _currentIndex.value = (_currentIndex.value + 1) % _playlist.length;

      print('🎵 Moving to track ${_currentIndex.value}: ${currentSong.title}');

      // Add a small delay to ensure cleanup
      await Future.delayed(const Duration(milliseconds: 200));

      // Load the new track
      await _loadCurrentTrack();

      // Add another small delay before playing
      await Future.delayed(const Duration(milliseconds: 100));

      // Start playing the new track
      await _player.play();

      print('🎵 New track should be playing: ${currentSong.title}');
    } catch (e) {
      print('❌ Error in track completion: $e');
      // Fallback - just load the track without auto-play
      await _loadCurrentTrack();
    }
  }

  Song _getDefaultSong() {
    return Song(
      title: "Blue",
      artist: "Yung Kai",
      audioPath: "assets/audio/blue.mp3",
      imagePath: "assets/images/blue.jpeg",
    );
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}

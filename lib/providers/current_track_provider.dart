import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/models/track.dart';

class CurrentTrackProvider extends StateNotifier<Track?> {
  CurrentTrackProvider() : super(null);

  AudioPlayer? _audioPlayer;
  bool isPlaying = false;
  void updateTrack(Track track) async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer!.setAudioSource(
      AudioSource.uri(
        Uri.parse(track.trackData.url),
      ),
    );
    _audioPlayer!.play();
    isPlaying = true;
    state = track;
  }

  void playPause() {
    if (isPlaying) {
      _audioPlayer?.pause();
    } else {
      _audioPlayer?.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(title: state?.title);
  }
}

final currentTrackProvider =
    StateNotifierProvider<CurrentTrackProvider, Track?>(
  (ref) => CurrentTrackProvider(),
);

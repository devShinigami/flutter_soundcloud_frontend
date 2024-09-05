import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/models/track.dart';

class CurrentTrackProvider extends StateNotifier<Track?> {
  CurrentTrackProvider() : super(null);

  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  bool wasPlayingBeforeChange = true;
  void updateTrack(Track track) async {
    audioPlayer = AudioPlayer();

    await audioPlayer!.setAudioSource(
      AudioSource.uri(
        Uri.parse(track.trackData.url),
      ),
    );

    audioPlayer!.play();
    isPlaying = true;
    wasPlayingBeforeChange = isPlaying;
    state = track;
  }

  void playPause() {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    wasPlayingBeforeChange = isPlaying;
    isPlaying = !isPlaying;
    state = state?.copyWith(title: state?.title);
  }

  void seek(double val) {
    audioPlayer?.seek(
      Duration(
        milliseconds: (val * audioPlayer!.duration!.inMilliseconds).toInt(),
      ),
    );
  }
}

final currentTrackProvider =
    StateNotifierProvider<CurrentTrackProvider, Track?>(
  (ref) => CurrentTrackProvider(),
);

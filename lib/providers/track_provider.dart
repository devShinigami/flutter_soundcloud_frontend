import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/models/image.dart';
import 'package:sound_cloud_clone/models/track.dart';
import 'package:sound_cloud_clone/services/track_services.dart';

class TrackNotifier extends AsyncNotifier<Track> {
  @override
  FutureOr<Track> build() {
    return Track(
      trackImage: ImageDataClass(publicId: '', url: ''),
      title: '',
      user: TrackUser(
        id: '',
        name: '',
        city: '',
        country: '',
        profilePic: ImageDataClass(publicId: '', url: ''),
      ),
      timesOfPlayed: 0,
      trackData: TrackData(publicId: '', url: ''),
      duration: TrackDuration(inMinutes: 0, inSeconds: 0),
      genre: '',
      isPrivate: false,
      createdAt: DateTime.now(),
      id: '',
    );
  }

  final TrackServices _trackServices = TrackServices();
  Future<void> uploadTrack(Map<String, dynamic> data,
      {required String id, required File audioFile}) async {
    state = const AsyncValue.loading();
    final res =
        await _trackServices.uploadTrack(data, id: id, audioFile: audioFile);

    final val = res.match(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
    debugPrint(val.toString());
  }
}

final trackProvider = AsyncNotifierProvider<TrackNotifier, Track>(() {
  return TrackNotifier();
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/loading_provider.dart';
import 'package:sound_cloud_clone/services/auth_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.ref)
      : super(User(
          id: "",
          name: "",
          email: "",
          bio: "",
          profilePic: ProfilePic(publicId: "", url: ""),
          bannerPic: BannerPic(publicId: "", url: ""),
          followers: [],
          following: [],
          tracks: [],
          likes: [],
          playlists: [],
          createdAt: DateTime.now(),
          city: "",
          country: "",
          token: "",
        ));
  final Ref ref;
  final AuthService _authService = AuthService();

  void setUser(User? user) {
    state = user;
    if (state != null) {
      debugPrint(state!.name);
    }
  }

  Future login(String email, String password) async {
    final loading = ref.read(loadingProvider.notifier);
    loading.setLoading(true);
    final res = await _authService.logIn(email: email, password: password);
    if (res != null) {
      state = res;
      loading.setLoading(false);
    } else {
      loading.setLoading(false);
      print('error');
    }
  }
}

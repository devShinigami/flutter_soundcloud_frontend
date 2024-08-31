import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/models/image.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/loading_provider.dart';
import 'package:sound_cloud_clone/services/auth_local.dart';
import 'package:sound_cloud_clone/services/auth_service.dart';
import 'package:sound_cloud_clone/services/user_services.dart';
import 'package:sound_cloud_clone/utils/toast.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) {
    return UserNotifier(ref);
  },
);

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.ref) : super(User.empty());
  final Ref ref;
  final AuthService _authService = AuthService();
  final UserServices _userServices = UserServices();

  void setUser(User? user) {
    state = user;
    if (state != null) {
      debugPrint(state!.name);
    }
  }

  Future login(String email, String password) async {
    final loading = ref.read(authLoadingProvider.notifier);
    try {
      loading.setLoading(true);
      final res = await _authService.logIn(email: email, password: password);
      if (res != null) {
        state = res;
        UserPreferences.saveUser(res.toJson());
        UserPreferences.saveToken(res.token);
        loading.setLoading(false);
      }
    } catch (e) {
      loading.setLoading(false);
      print(e.toString());
      getToast(e.toString());
    }
  }

  Future<String?> signup(
      {required String email,
      required String password,
      required String name}) async {
    final loading = ref.read(authLoadingProvider.notifier);

    try {
      loading.setLoading(true);
      final res = await _authService.signup(
          email: email, password: password, name: name);
      loading.setLoading(false);
      return res['email'];
    } catch (e) {
      loading.setLoading(false);
      getToast(e.toString());
      return null;
    }
  }

  Future update(Map<String, dynamic> changes, {required String id}) async {
    try {
      final res = await _userServices.updateUser(changes, id: id);
      state = res;
      await UserPreferences.saveUser(res.toJson());
      getToast('Profile updated');
    } catch (e) {
      getToast(e.toString());
    }
  }
}

final userProfileFuture =
    FutureProvider.family.autoDispose<User?, String>((ref, id) async {
  final res = await ref.read(userServicesProvider).getUser(id);
  if (res != null) {
    // if (res.id == ref.read(userProvider)!.id) {
    //   await UserPreferences.saveUser(res.toJson());
    // }
  }
  return res;
});

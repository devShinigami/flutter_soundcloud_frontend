import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLoadingNotifier extends StateNotifier<bool> {
  AuthLoadingNotifier() : super(false);

  void setLoading(bool value) {
    state = value;
  }
}

final authLoadingProvider =
    StateNotifierProvider.autoDispose<AuthLoadingNotifier, bool>((ref) {
  return AuthLoadingNotifier();
});

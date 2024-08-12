import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/services/user_services.dart';

part 'user_viewmodel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  @override
  AsyncValue<User> build() {
    return AsyncValue.data(User(name: '', email: '', id: ''));
  }

  final UserServices _userApi = UserServices();

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    state = const AsyncValue.loading();
    final res = await _userApi.signUp(name, email, password);

    res.match(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

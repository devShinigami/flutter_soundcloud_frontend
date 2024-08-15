import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/providers/current_user_notifier.dart';
import 'package:sound_cloud_clone/services/user_local_services.dart';
import 'package:sound_cloud_clone/services/user_services.dart';

part 'user_viewmodel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  late UserServices _userApi;
  late UserLocalServices _userLocalServices;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<User> build() {
    _userApi = ref.watch(userServicesProvider);
    _userLocalServices = ref.watch(userLocalServicesProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return AsyncValue.data(User(name: '', email: '', id: '', token: ''));
  }

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

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final res = await _userApi.login(email, password);
    res.match(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = _loginSuccess(r),
    );
  }

  Future<void> initSharedPreferences() async {
    await _userLocalServices.init();
  }

  Future<User?> getUser() async {
    state = const AsyncValue.loading();
    final token = _userLocalServices.getToken();
    if (token != null) {
      final res = await _userApi.getUser(token);
      final val = res.match(
        (l) => state = AsyncValue.error(l.message, StackTrace.current),
        (r) => state = _getDataSuccess(r),
      );
      return val.value;
    }
    return null;
  }

  AsyncValue<User> _loginSuccess(User user) {
    _userLocalServices.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  AsyncValue<User> _getDataSuccess(User user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}

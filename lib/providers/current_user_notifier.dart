import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sound_cloud_clone/models/user_model.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  User? build() {
    return null;
  }

  void addUser(User user) {
    state = user;
  }
}

import 'package:flutter/material.dart';
import 'package:sound_cloud_clone/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
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
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}

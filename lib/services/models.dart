//// Embedded Maps
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String id;
  final String one;
  final String username;
  final Map followers;
  final Map following;
  final Timestamp lastactivity;

  const UserModel(
      {this.username,
      this.id,
      this.one,
      this.email,
      this.followers,
      this.following,
      this.lastactivity});

  factory UserModel.fromMap(Map data) {
    return UserModel(
        email: data['email'] ?? '',
        username: data['username'] ?? '',
        one: data['one'] ?? '',
        id: data['uid'] ?? '',
        followers: data['followers'] ?? '',
        following: data['following'] ?? '',
        lastactivity: data['lastActivity'] ?? '');
  }
}

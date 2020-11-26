//// Embedded Maps
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String id;
  final String one;
  final String username;
  final Map followers;
  final int likes;
  final Map following;
  final Timestamp lastactivity;

  const UserModel(
      {this.username,
      this.id,
      this.one,
      this.email,
      this.followers,
      this.following,
      this.likes,
      this.lastactivity});

  factory UserModel.fromMap(Map data) {
    return UserModel(
        email: data['email'] ?? '',
        username: data['username'] ?? '',
        one: data['one'] ?? '',
        id: data['uid'] ?? '',
        followers: data['followers'] ?? '',
        following: data['following'] ?? '',
        likes: data['likes'] ?? 0,
        lastactivity: data['lastActivity'] ?? '');
  }
}

class OneModel {
  final String id;
  final String uid;
  final String url;
  final String topics;
  final Map likes;
  final int nbLikes;
  final Timestamp datePosted;
  final bool isCurrent;

  const OneModel(
      {this.id,
      this.uid,
      this.url,
      this.topics,
      this.likes,
      this.nbLikes,
      this.datePosted,
      this.isCurrent});

  factory OneModel.fromMap(Map data) {
    return OneModel(
        id: data['id'] ?? '',
        uid: data['uid'] ?? '',
        url: data['one'] ?? '',
        topics: data['topics'] ?? '',
        likes: data['likes'] ?? '',
        nbLikes: data['nbLikes'] ?? 0,
        datePosted: data['datePosted'] ?? '',
        isCurrent: data['isCurrent'] ?? true);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String id;
  final String photoUrl;
  final String username;
  final Map followers;
  final Map following;

  const User(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.followers,
      this.following});

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
      email: document['email'],
      username: document['username'],
      photoUrl: document['photoUrl'],
      id: document.documentID,
      followers: document['followers'],
      following: document['following'],
    );
  }
}

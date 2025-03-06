import 'package:flutter/material.dart';
import '../entities/users_entity.dart';

abstract class FirebaseRepository {
  // Authentication methods
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<bool> isSignedIn();

  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get userStream;

  Future<void> updateUserProfile(UserEntity user);
  Future<void> updateUserScore(String uid, num newScore);
  Future<void> updateUserInterviews(String uid, List<String> interviews);
  Future<void> updateUserTechStack(String uid, List<String> techStack);
  Future<void> updateUserPreferences(String uid, List<String> preferences);
}

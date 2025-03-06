import 'package:mockcrack/domain/entities/users_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasources/remote_datasource.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity?> getCurrentUser() => remoteDataSource.getCurrentUser();

  @override
  Future<bool> isSignedIn() => remoteDataSource.isSignedIn();

  @override
  Future<void> signIn(UserEntity user) => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) => remoteDataSource.signUp(user);

  @override
  Future<void> updateUserInterviews(String uid, List<String> interviews) =>
      remoteDataSource.updateUserInterviews(uid, interviews);

  @override
  Future<void> updateUserPreferences(String uid, List<String> preferences) =>
      remoteDataSource.updateUserPreferences(uid, preferences);

  @override
  Future<void> updateUserProfile(UserEntity user) =>
      remoteDataSource.updateUserProfile(user);

  @override
  Future<void> updateUserScore(String uid, num newScore) =>
      remoteDataSource.updateUserScore(uid, newScore);

  @override
  Future<void> updateUserTechStack(String uid, List<String> techStack) =>
      remoteDataSource.updateUserTechStack(uid, techStack);

  @override
  Stream<UserEntity?> get userStream => remoteDataSource.userStream;
}

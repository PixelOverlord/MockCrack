import 'package:mockcrack/domain/entities/users_entity.dart';

import '../../domain/repositories/firebase_repository.dart';
import '../datasources/remote_datasource.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> getCurrentUid() => remoteDataSource.getCurrentUid();

  @override
  Future<bool> isSignedIn() => remoteDataSource.isSignedIn();

  @override
  Future<void> signIn(String email, String password) =>
      remoteDataSource.signIn(email, password);

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> signUp(String email, String password, UserEntity user) =>
      remoteDataSource.signUp(email, password, user);

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
  Stream<UserEntity?> getuserStream(String uid) =>
      remoteDataSource.getuserStream(uid);

  @override
  Future<void> createUser(UserEntity user) => remoteDataSource.createUser(user);
}

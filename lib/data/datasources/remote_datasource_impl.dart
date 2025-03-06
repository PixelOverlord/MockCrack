import 'package:mockcrack/data/datasources/remote_datasource.dart';
import 'package:mockcrack/domain/entities/users_entity.dart';

class RemoteDatasourceImpl implements RemoteDataSource {
  @override
  Future<UserEntity?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserEntity user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserInterviews(String uid, List<String> interviews) {
    // TODO: implement updateUserInterviews
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserPreferences(String uid, List<String> preferences) {
    // TODO: implement updateUserPreferences
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserProfile(UserEntity user) {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserScore(String uid, num newScore) {
    // TODO: implement updateUserScore
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserTechStack(String uid, List<String> techStack) {
    // TODO: implement updateUserTechStack
    throw UnimplementedError();
  }

  @override
  // TODO: implement userStream
  Stream<UserEntity?> get userStream => throw UnimplementedError();
}

import '../../repositories/firebase_repository.dart';

class UpdateUserScoreUseCase {
  final FirebaseRepository repository;

  UpdateUserScoreUseCase(this.repository);

  Future<void> call(String uid, num newScore) async {
    return await repository.updateUserScore(uid, newScore);
  }
}

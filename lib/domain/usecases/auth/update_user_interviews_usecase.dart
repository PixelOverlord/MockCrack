import '../../repositories/firebase_repository.dart';

class UpdateUserInterviewsUseCase {
  final FirebaseRepository repository;

  UpdateUserInterviewsUseCase(this.repository);

  Future<void> call(String uid, List<String> interviews) async {
    return await repository.updateUserInterviews(uid, interviews);
  }
}

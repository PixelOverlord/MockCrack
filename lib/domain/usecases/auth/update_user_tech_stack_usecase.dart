import '../../repositories/firebase_repository.dart';

class UpdateUserTechStackUseCase {
  final FirebaseRepository repository;

  UpdateUserTechStackUseCase(this.repository);

  Future<void> call(String uid, List<String> techStack) async {
    return await repository.updateUserTechStack(uid, techStack);
  }
}

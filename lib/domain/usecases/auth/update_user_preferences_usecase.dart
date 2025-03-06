import '../../repositories/firebase_repository.dart';

class UpdateUserPreferencesUseCase {
  final FirebaseRepository repository;

  UpdateUserPreferencesUseCase(this.repository);

  Future<void> call(String uid, List<String> preferences) async {
    return await repository.updateUserPreferences(uid, preferences);
  }
}

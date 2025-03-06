import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class UpdateUserProfileUseCase {
  final FirebaseRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return await repository.updateUserProfile(user);
  }
}

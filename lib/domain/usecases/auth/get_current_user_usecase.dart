import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class GetCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}

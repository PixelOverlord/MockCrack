import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return await repository.signUp(user);
  }
}

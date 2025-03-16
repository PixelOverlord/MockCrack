import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(String email, String password, UserEntity user) async {
    return await repository.signUp(email, password, user);
  }
}

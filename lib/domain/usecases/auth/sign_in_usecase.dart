import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}

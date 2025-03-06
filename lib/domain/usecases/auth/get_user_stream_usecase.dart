import '../../entities/users_entity.dart';
import '../../repositories/firebase_repository.dart';

class GetUserStreamUseCase {
  final FirebaseRepository repository;

  GetUserStreamUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.userStream;
  }
}

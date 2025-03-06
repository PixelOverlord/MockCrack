import '../../repositories/firebase_repository.dart';

class GetSignedInStatusUseCase {
  final FirebaseRepository repository;

  GetSignedInStatusUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isSignedIn();
  }
}

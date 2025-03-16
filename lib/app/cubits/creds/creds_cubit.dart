import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mockcrack/domain/entities/users_entity.dart';
import 'package:mockcrack/domain/usecases/auth/sign_in_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_out_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_up_usecase.dart';

part 'creds_state.dart';

class CredsCubit extends Cubit<CredsState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  CredsCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(CredsInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(CredsLoading());
    try {
      await signInUseCase.call(email, password);
      emit(CredsLoaded());
    } catch (e) {
      emit(CredsError(message: e.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required UserEntity user}) async {
    emit(CredsLoading());
    try {
      await signUpUseCase.call(email, password, user);
      emit(CredsLoaded());
    } catch (e) {
      emit(CredsError(message: e.toString()));
    }
  }
}

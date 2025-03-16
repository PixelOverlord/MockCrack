import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mockcrack/app/cubits/user/user_cubit.dart';
import 'package:mockcrack/data/datasources/remote_datasource_impl.dart';
import 'package:mockcrack/data/repositories/firebase_repository_impl.dart';
import 'package:mockcrack/domain/repositories/firebase_repository.dart';
import 'package:mockcrack/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/get_signed_in_status_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_in_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_out_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_up_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_interviews_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_preferences_usecase.dart';

import 'data/datasources/remote_datasource.dart';
import 'domain/usecases/auth/get_user_stream_usecase.dart';
import 'domain/usecases/auth/update_user_profile_usecase.dart';
import 'domain/usecases/auth/update_user_score_usecase.dart';
import 'domain/usecases/auth/update_user_tech_stack_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubits

  sl.registerFactory(
    () => UserCubit(
      getUserStreamUseCase: sl.call(),
      updateUserInterviewsUseCase: sl.call(),
      updateUserPreferencesUseCase: sl.call(),
      updateUserProfileUseCase: sl.call(),
      updateUserScoreUseCase: sl.call(),
      updateUserTechStackUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => GetCurrentUidUseCase(sl.call()));
  sl.registerLazySingleton(() => GetSignedInStatusUseCase(sl.call()));
  sl.registerLazySingleton(() => GetUserStreamUseCase(sl.call()));
  sl.registerLazySingleton(() => SignInUseCase(sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(sl.call()));
  sl.registerLazySingleton(() => UpdateUserInterviewsUseCase(sl.call()));
  sl.registerLazySingleton(() => UpdateUserPreferencesUseCase(sl.call()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl.call()));
  sl.registerLazySingleton(() => UpdateUserScoreUseCase(sl.call()));
  sl.registerLazySingleton(() => UpdateUserTechStackUseCase(sl.call()));

  // repositories
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(sl.call()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDatasourceImpl(auth: sl.call(), db: sl.call()));

  // externals
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

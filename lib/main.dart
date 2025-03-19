import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockcrack/app/cubits/auth/auth_cubit.dart';
import 'package:mockcrack/app/cubits/creds/creds_cubit.dart';
import 'package:mockcrack/app/cubits/user/user_cubit.dart';
import 'package:mockcrack/app/screens/app_screen.dart';
import 'package:mockcrack/app/screens/splash_screen.dart';
import 'package:mockcrack/firebase_options.dart';
import 'dependency_injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  // FirebaseFirestore.instance.collection("Users").doc("test").set({
  //   'uid': "test",
  //   'email': "test@gmail.com",
  //   'username': "test",
  //   'occupation': "test",
  //   'interviews': [],
  //   'score': 0,
  //   'techStack': [],
  //   'preferences': [],
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<CredsCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthError) {
              return Text(state.message);
            } else if (state is Authenticated) {
              print(state.uid);
              return AppScreen(
                uid: state.uid,
              );
            } else if (state is Unauthenticated) {
              return SplashScreen();
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}

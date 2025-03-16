import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockcrack/data/datasources/remote_datasource.dart';
import 'package:mockcrack/domain/entities/users_entity.dart';

import '../models/user_model.dart';

class RemoteDatasourceImpl implements RemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  const RemoteDatasourceImpl({required this.auth, required this.db});

  /// Returns the current user's uid if signed in, otherwise null.
  @override
  Future<String?> getCurrentUid() async => auth.currentUser?.uid;

  /// Returns true if signed in, false if not signed in.
  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  /// Signs in user with the given email and password.
  @override
  Future<void> signIn(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'The email address is not valid.';
      } else if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'The password is invalid for the given user.';
      } else {
        throw e.code;
      }
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async => await auth.signOut();

  /// Creates a new user with the given [UserEntity] and returns its uid.
  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = db.collection('Users');

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((newDoc) {
      final newUser = UserModel(
        uid: uid!,
        email: user.email,
        username: user.username,
        occupation: user.occupation,
        interviews: user.interviews,
        score: user.score,
        techStack: user.techStack,
        preferences: user.preferences,
      ).toMap();

      if (!newDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  /// Signs up user with the given email and password.
  @override
  Future<void> signUp(String email, String password) async {
    try {
      // signup user

      // create a new user and get uid
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      // return void
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'The email address is not valid.';
      } else if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'The password is invalid for the given user.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The email address is already in use by another account.';
      } else {
        throw e.code;
      }
    }
  }

  /// Updates the interviews of the user with the given uid.
  @override
  Future<void> updateUserInterviews(String uid, List<String> interviews) async {
    final userCollection = db.collection('Users').doc(uid);

    await userCollection.update({'interviews': interviews});
  }

  /// Updates the preferences of the user with the given uid.
  @override
  Future<void> updateUserPreferences(
      String uid, List<String> preferences) async {
    final userCollection = db.collection('Users').doc(uid);

    await userCollection.update({'preferences': preferences});
  }

  /// Updates the user with the given [UserEntity].
  @override
  Future<void> updateUserProfile(UserEntity user) async {
    final userCollection = db.collection('Users').doc(user.uid);

    await userCollection.update({
      'email': user.email,
      'username': user.username,
      'occupation': user.occupation,
      'interviews': user.interviews,
      'score': user.score,
      'techStack': user.techStack,
      'preferences': user.preferences,
    });
  }

  /// Updates the score of the user with the given uid.
  @override
  Future<void> updateUserScore(String uid, num newScore) async {
    final userCollection = db.collection('Users').doc(uid);

    await userCollection.update({'score': newScore});
  }

  /// Updates the tech stack of the user with the given uid.
  @override
  Future<void> updateUserTechStack(String uid, List<String> techStack) async {
    final userCollection = db.collection('Users').doc(uid);

    await userCollection.update({'techStack': techStack});
  }

  /// Returns a stream of user with the given uid.
  @override
  Stream<UserEntity?> getuserStream(String uid) {
    final userCollection =
        db.collection('Users').where('uid', isEqualTo: uid).limit(1);

    return userCollection.snapshots().map(
        (ss) => ss.docs.map((e) => UserModel.fromMap(e.data())).firstOrNull);
  }
}

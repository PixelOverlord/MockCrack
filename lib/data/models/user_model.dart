import 'package:mockcrack/domain/entities/users_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? email;
  final String? username;
  final String? occupation;
  final List? interviews;
  final num? score;
  final List? techStack;
  final List? preferences;

  const UserModel({
    this.uid,
    this.email,
    this.username,
    this.occupation,
    this.interviews,
    this.score,
    this.techStack,
    this.preferences,
  }) : super(
          uid: uid,
          email: email,
          username: username,
          occupation: occupation,
          interviews: interviews,
          score: score,
          techStack: techStack,
          preferences: preferences,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      occupation: map['occupation'],
      interviews: map['interviews'],
      score: map['score'],
      techStack: map['techStack'],
      preferences: map['preferences'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'occupation': occupation,
      'interviews': interviews,
      'score': score,
      'techStack': techStack,
      'preferences': preferences,
    };
  }
}

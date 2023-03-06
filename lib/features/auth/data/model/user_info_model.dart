import 'package:ronvest/features/auth/domain/entity/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    required String full_name,
    required String username,
    required String email,
    required String first_name,
    required String last_name,
    required dynamic avater,
  }) : super(
      full_name: full_name,
      username: username,
      email: email,
      first_name: first_name,
      last_name: last_name,
      avater: avater);

  factory UserInfoModel.fromMap(Map<String, dynamic> json) =>
      UserInfoModel(full_name: json['full_name'],
          username: json['username'],
          email: json['email'],
          first_name: json['first_name'],
          last_name: json['last_name'],
          avater: json['avater'] ?? null
      );

  Map<String, dynamic> toMap() => {
    'full_name' : full_name,
    'username' : username,
    'email' : email,
    'first_name' : first_name,
    'last_name' : last_name,
    'avater' : avater,
  };
}

import 'dart:convert';

import 'package:ronvest/features/auth/data/model/user_info_model.dart';
import 'package:ronvest/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required int user_id,
    required String access_token,
    required UserInfoModel user_info,
  }) : super(
            user_id: user_id, access_token: access_token, user_info: user_info);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      user_id: json['user_id'],
      access_token: json['access_token'],
      user_info: UserInfoModel.fromMap(json['user_info']));

  Map<String, dynamic> toMap() => {
        'user_id': user_id,
        'access_token': access_token,
        'user_info': user_info.toMap()
      };

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

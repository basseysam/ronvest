import 'package:equatable/equatable.dart';
import 'package:ronvest/features/auth/data/model/user_info_model.dart';

class UserEntity extends Equatable {
  final int user_id;
  final String access_token;
  final UserInfoModel user_info;

  const UserEntity({required this.user_id, required this.access_token, required this.user_info});

  @override
  List<Object?> get props => [
    user_id,
    access_token,
    user_info
  ];
}
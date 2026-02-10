import 'package:money_tracker_app/feature/auth/models/user_model.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;
  const ProfileSuccess({required this.userModel});
}

class ProfileError extends ProfileState {
  const ProfileError();
}

class ProfileLogoutLoading extends ProfileState {}

class ProfileLogoutSuccess extends ProfileState {}

class ProfileLogoutError extends ProfileState {
  const ProfileLogoutError();
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data_source/firebase_data_source.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource();

  Future<void> getUserModel() async {
    emit(ProfileLoading());
    try {
      final userModel = await _firebaseDataSource.getUserDetails();
      emit(ProfileSuccess(userModel: userModel));
    } catch (e) {
      emit(ProfileError());
    }
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    try {
      await _firebaseDataSource.logout();
      emit(ProfileLogoutSuccess());
    } catch (e) {
      emit(ProfileLogoutError());
    }
  }
}

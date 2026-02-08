import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/core/data_source/firebase_data_source.dart';
import 'profile_state.dart';

class ProfileSettingsCubit extends Cubit<ProfileState> {
  ProfileSettingsCubit()
    : super(
        const ProfileState(
          isDarkMode: false,
          currency: 'USD (\$)',
          language: 'EN',
          isLoggingOut: false,
        ),
      );

  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource();

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void toggleCurrency() {
    final newCurrency = state.currency == 'USD (\$)' ? 'EGP (E£)' : 'USD (\$)';
    emit(state.copyWith(currency: newCurrency));
  }

  void toggleLanguage() {
    final newLanguage = state.language == 'EN' ? 'AR' : 'EN';
    emit(state.copyWith(language: newLanguage));
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoggingOut: true));
    try {
      await _firebaseDataSource.logout();
      emit(state.copyWith(isLoggingOut: false, logoutSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoggingOut: false, logoutError: e.toString()));
    }
  }
}

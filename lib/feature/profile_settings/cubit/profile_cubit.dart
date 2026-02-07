import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileSettingsCubit extends Cubit<ProfileState> {
  ProfileSettingsCubit()
    : super(
        const ProfileState(
          isDarkMode: false,
          currency: 'USD (\$)',
          language: 'EN',
        ),
      );

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
}

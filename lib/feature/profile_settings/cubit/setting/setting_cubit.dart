import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/setting_model.dart';
import 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
    : super(
        SettingState(
          settingModel: SettingModel(
            isDarkMode: false,
            currency: 'USD',
            language: 'en',
          ),
        ),
      );

  void toggleTheme() {
    SettingModel newSetting = state.settingModel;
    newSetting = SettingModel(
      isDarkMode: !newSetting.isDarkMode,
      currency: newSetting.currency,
      language: newSetting.language,
    );
    emit(SettingState(settingModel: newSetting));
  }

  void toggleCurrency() {
    SettingModel newSetting = state.settingModel;
    newSetting = SettingModel(
      isDarkMode: newSetting.isDarkMode,
      currency: newSetting.currency == 'USD' ? 'EGP' : 'USD',
      language: newSetting.language,
    );
    emit(SettingState(settingModel: newSetting));
  }

  void toggleLanguage() {
    SettingModel newSetting = state.settingModel;
    newSetting = SettingModel(
      isDarkMode: newSetting.isDarkMode,
      currency: newSetting.currency,
      language: newSetting.language == 'en' ? 'ar' : 'en',
    );
    emit(SettingState(settingModel: newSetting));
  }
}

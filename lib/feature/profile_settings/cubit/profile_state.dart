class ProfileState {
  final bool isDarkMode;
  final String currency;
  final String language;
  final bool isLoggingOut;
  final bool logoutSuccess;
  final String? logoutError;

  const ProfileState({
    this.isDarkMode = false,
    this.currency = 'USD (\$)',
    this.language = 'EN',
    this.isLoggingOut = false,
    this.logoutSuccess = false,
    this.logoutError,
  });

  ProfileState copyWith({
    bool? isDarkMode,
    String? currency,
    String? language,
    bool? isLoggingOut,
    bool? logoutSuccess,
    String? logoutError,
  }) {
    return ProfileState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
      logoutError: logoutError ?? this.logoutError,
    );
  }
}

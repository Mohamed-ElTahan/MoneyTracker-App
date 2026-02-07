class ProfileState {
  final bool isDarkMode;
  final String currency;
  final String language;

  const ProfileState({
    this.isDarkMode = false,
    this.currency = 'USD (\$)',
    this.language = 'EN',
  });

  ProfileState copyWith({
    bool? isDarkMode,
    String? currency,
    String? language,
  }) {
    return ProfileState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}

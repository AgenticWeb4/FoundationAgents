class AppConstants {
  // App Information
  static const String appName = 'Foundation Agents';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Local Storage Keys
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Error Messages
  static const String networkError = '网络连接错误，请检查网络设置';
  static const String serverError = '服务器错误，请稍后重试';
  static const String unknownError = '未知错误，请稍后重试';
  
  // Success Messages
  static const String operationSuccess = '操作成功';
  static const String dataSaved = '数据已保存';
}

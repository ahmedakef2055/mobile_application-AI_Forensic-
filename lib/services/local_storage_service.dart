import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _settingsKey = 'app_settings';

  late final SharedPreferences _prefs;

  LocalStorageService._();

  static final LocalStorageService _instance = LocalStorageService._();

  factory LocalStorageService() {
    return _instance;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Auth tokens
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(_authTokenKey, token);
  }

  String? getAuthToken() {
    return _prefs.getString(_authTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  // User data
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _prefs.setString(_userKey, jsonEncode(userData));
  }

  Map<String, dynamic>? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  // Settings
  Future<void> saveSetting(String key, dynamic value) async {
    final settings = getSettings() ?? {};
    settings[key] = value;
    await _prefs.setString(_settingsKey, jsonEncode(settings));
  }

  dynamic getSetting(String key, [dynamic defaultValue]) {
    final settings = getSettings();
    return settings?[key] ?? defaultValue;
  }

  Map<String, dynamic>? getSettings() {
    final settingsJson = _prefs.getString(_settingsKey);
    if (settingsJson != null) {
      return jsonDecode(settingsJson) as Map<String, dynamic>;
    }
    return null;
  }

  // Notification settings
  Future<void> setNotificationsEnabled(bool enabled) async {
    await saveSetting('notifications_enabled', enabled);
  }

  bool getNotificationsEnabled() {
    return getSetting('notifications_enabled', true) as bool;
  }

  Future<void> setTimezone(String timezone) async {
    await saveSetting('timezone', timezone);
  }

  String getTimezone() {
    return getSetting('timezone', 'UTC') as String;
  }

  // Clear
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  Future<void> logout() async {
    await _prefs.remove(_authTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_userKey);
  }
}

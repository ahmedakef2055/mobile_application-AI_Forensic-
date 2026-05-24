import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

// API Service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final localStorage = ref.read(localStorageProvider);
  final token = localStorage.getAuthToken();
  return ApiService(initialToken: token);
});

// Local Storage provider
final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Authentication state
class AuthState {
  final bool isAuthenticated;
  final User? user;
  final String? error;
  final bool isLoading;

  AuthState({
    this.isAuthenticated = false,
    this.user,
    this.error,
    this.isLoading = false,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    User? user,
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final localStorage = ref.read(localStorageProvider);
    final token = localStorage.getAuthToken();
    final userData = localStorage.getUser();

    if (token != null && userData != null) {
      state = state.copyWith(
        isAuthenticated: true,
        user: User.fromJson(userData),
      );
    }
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = ref.read(apiServiceProvider);
      final localStorage = ref.read(localStorageProvider);

      final response = await apiService.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final userJson = data['user'] as Map<String, dynamic>;
      final user = _userFromApi(userJson);

      await localStorage.saveAuthToken(token);
      await localStorage.saveUser(user.toJson());
      apiService.setAuthToken(token);

      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تسجيل الدخول: ${e.toString()}',
        isLoading: false,
      );
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = ref.read(apiServiceProvider);
      final localStorage = ref.read(localStorageProvider);

      final response = await apiService.post<Map<String, dynamic>>(
        '/auth/register',
        data: {'username': name, 'email': email, 'password': password},
      );

      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final userJson = data['user'] as Map<String, dynamic>;
      final user = _userFromApi(userJson);

      await localStorage.saveAuthToken(token);
      await localStorage.saveUser(user.toJson());
      apiService.setAuthToken(token);

      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'فشل إنشاء الحساب: ${e.toString()}',
        isLoading: false,
      );
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final localStorage = ref.read(localStorageProvider);
      await apiService.post<Map<String, dynamic>>('/auth/logout');
      await localStorage.logout();
      apiService.setAuthToken(null);
      state = AuthState();
    } catch (_) {
      final localStorage = ref.read(localStorageProvider);
      await localStorage.logout();
      state = AuthState();
    }
  }

  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'فشل إرسال رابط إعادة تعيين كلمة المرور: ${e.toString()}',
        isLoading: false,
      );
      return false;
    }
  }

  User _userFromApi(Map<String, dynamic> json) {
    return User(
      id: json['user_id']?.toString() ?? '0',
      name: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profileImageUrl: null,
      notificationsEnabled: true,
      timezone: 'UTC',
      role: json['role'] as String? ?? 'user',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );
  }
}

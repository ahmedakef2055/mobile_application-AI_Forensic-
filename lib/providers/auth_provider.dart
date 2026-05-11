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

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final apiService = ref.read(apiServiceProvider);
      final localStorage = ref.read(localStorageProvider);

      // Mock authentication - replace with actual API call
      // final response = await apiService.post('/auth/login', data: {
      //   'email': email,
      //   'password': password,
      // });

      // For now, mock successful login
      final mockUser = User(
        id: '1',
        name: 'User',
        email: email,
        profileImageUrl: null,
        notificationsEnabled: true,
        timezone: 'UTC',
        role: 'admin',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      const mockToken = 'mock_jwt_token_123456';

      await localStorage.saveAuthToken(mockToken);
      await localStorage.saveUser(mockUser.toJson());
      apiService.setAuthToken(mockToken);

      state = state.copyWith(
        isAuthenticated: true,
        user: mockUser,
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

      // Mock signup - replace with actual API call
      // final response = await apiService.post('/auth/signup', data: {
      //   'name': name,
      //   'email': email,
      //   'password': password,
      // });

      final mockUser = User(
        id: '1',
        name: name,
        email: email,
        profileImageUrl: null,
        notificationsEnabled: true,
        timezone: 'UTC',
        role: 'user',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      const mockToken = 'mock_jwt_token_123456';

      await localStorage.saveAuthToken(mockToken);
      await localStorage.saveUser(mockUser.toJson());
      apiService.setAuthToken(mockToken);

      state = state.copyWith(
        isAuthenticated: true,
        user: mockUser,
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
      final localStorage = ref.read(localStorageProvider);
      await localStorage.logout();

      state = AuthState();
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تسجيل الخروج: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Mock password reset - replace with actual API call
      // final response = await apiService.post('/auth/forgot-password', data: {
      //   'email': email,
      // });

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
}

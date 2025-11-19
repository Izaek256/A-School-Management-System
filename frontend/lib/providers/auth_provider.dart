import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/api_service_provider.dart';
import 'package:dio/dio.dart';

class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? errorMessage;
  final User? user;

  AuthState({
    required this.isAuthenticated,
    this.token,
    this.errorMessage,
    this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    String? errorMessage,
    User? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState(isAuthenticated: false));

  Future<void> login(String username, String password) async {
    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.post(
        '/api/accounts/users/login/',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access'];
        final userData = response.data['user'];

        // Save token
        await apiService.saveToken(accessToken);

        // Create user object
        final user = User.fromJson(userData);

        state = state.copyWith(
          isAuthenticated: true,
          token: accessToken,
          user: user,
          errorMessage: null,
        );
      } else {
        state = state.copyWith(
          isAuthenticated: false,
          errorMessage: 'Login failed',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Login failed';
      if (e.response?.data != null) {
        if (e.response!.data is Map && e.response!.data['error'] != null) {
          errorMessage = e.response!.data['error'];
        } else if (e.response!.data is Map &&
            e.response!.data['detail'] != null) {
          errorMessage = e.response!.data['detail'];
        }
      }

      state = state.copyWith(
        isAuthenticated: false,
        errorMessage: errorMessage,
      );
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        errorMessage: 'An unexpected error occurred',
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isAuthenticated: false, token: null, user: null);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/user.dart';

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
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isAuthenticated: false));

  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any non-empty email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      // Create a demo user
      final demoUser = User(
        id: 1,
        username: email.split('@')[0],
        email: email,
        role: 'Administrator',
        firstName: 'John',
        lastName: 'Doe',
        createdAt: DateTime.now(),
      );
      
      state = state.copyWith(
        isAuthenticated: true,
        token: 'demo_token_12345',
        user: demoUser,
      );
    } else {
      state = state.copyWith(
        isAuthenticated: false,
        errorMessage: 'Invalid credentials',
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      isAuthenticated: false,
      token: null,
      user: null,
    );
  }
}
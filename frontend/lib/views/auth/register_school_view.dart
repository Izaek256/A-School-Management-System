import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class RegisterSchoolView extends ConsumerWidget {
  const RegisterSchoolView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register School'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              const Center(
                child: Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              
              // Title
              const Text(
                'Register Your School',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              const Text(
                'Create an account for your institution',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              // School Name Field
              AppInput(
                labelText: 'School Name',
                prefixIcon: Icons.school_outlined,
              ),
              const SizedBox(height: 16),
              
              // Admin Name Field
              AppInput(
                labelText: 'Admin Name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              
              // Email Field
              AppInput(
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              
              // Password Field
              AppInput(
                labelText: 'Password',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
              const SizedBox(height: 16),
              
              // Confirm Password Field
              AppInput(
                labelText: 'Confirm Password',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
              const SizedBox(height: 24),
              
              // Register Button
              PrimaryButton(
                text: 'Register School',
                onPressed: () {
                  // Handle registration
                  context.push('/dashboard');
                },
              ),
              const SizedBox(height: 24),
              
              // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class CreateExamView extends ConsumerWidget {
  const CreateExamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exam'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Exam Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AppInput(
                        labelText: 'Exam Name',
                        prefixIcon: Icons.title,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Class',
                        prefixIcon: Icons.class_,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Subject',
                        prefixIcon: Icons.book,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Date',
                        prefixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppInput(
                              labelText: 'Start Time',
                              prefixIcon: Icons.access_time,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppInput(
                              labelText: 'End Time',
                              prefixIcon: Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Exam Type',
                        prefixIcon: Icons.category,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Total Marks',
                        prefixIcon: Icons.score,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Exam',
                onPressed: () {
                  // Handle create exam
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Exam created successfully'),
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
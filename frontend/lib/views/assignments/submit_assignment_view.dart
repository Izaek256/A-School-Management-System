import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class SubmitAssignmentView extends ConsumerWidget {
  const SubmitAssignmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Assignment'),
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
                'Assignment Details',
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
                        labelText: 'Title',
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
                        labelText: 'Due Date',
                        prefixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Attachments'),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            // Handle add attachment
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.description),
                        title: const Text('assignment.pdf'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete attachment
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Submit Assignment',
                onPressed: () {
                  // Handle submit assignment
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Assignment submitted successfully'),
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
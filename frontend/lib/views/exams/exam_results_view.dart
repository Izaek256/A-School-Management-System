import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/providers/exam_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class ExamResultsView extends ConsumerWidget {
  final String examId;

  const ExamResultsView({super.key, required this.examId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examAsync = ref.watch(examProvider(examId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Results'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: examAsync.when(
        data: (exam) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${exam.className} - ${exam.subject}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Date: ${exam.date}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total Marks: ${exam.totalMarks}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTable(
                    headers: ['Student', 'Marks', 'Grade', 'Status'],
                    rows: [
                      ['John Doe', '85', 'A', 'Pass'],
                      ['Jane Smith', '92', 'A+', 'Pass'],
                      ['Robert Johnson', '78', 'B+', 'Pass'],
                      ['Emily Davis', '65', 'C', 'Pass'],
                      ['Michael Wilson', '45', 'F', 'Fail'],
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Enter Results',
                    onPressed: () {
                      // Handle enter results
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading exam: $error'),
        ),
      ),
    );
  }
}
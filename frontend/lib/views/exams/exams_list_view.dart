import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/models/exam.dart';
import 'package:frontend/providers/exam_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class ExamsListView extends ConsumerWidget {
  const ExamsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: AppInput(
                    labelText: 'Search exams...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Create Exam',
                  icon: Icons.add,
                  onPressed: () {
                    context.push('/exams/create');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: examsAsync.when(
              data: (exams) {
                if (exams.isEmpty) {
                  return Center(
                    child: Text(
                      'No exams found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }

                final headers = ['Name', 'Class', 'Subject', 'Date', 'Actions'];
                final rows = exams.map((exam) => [
                  exam.name,
                  exam.className,
                  exam.subject,
                  exam.date,
                  'View Results',
                ]).toList();

                return AppTable(
                  headers: headers,
                  rows: rows,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error loading exams: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
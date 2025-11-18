import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/providers/assignment_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class AssignmentsListView extends ConsumerWidget {
  const AssignmentsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(assignmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
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
                    labelText: 'Search assignments...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Create Assignment',
                  icon: Icons.add,
                  onPressed: () {
                    context.push('/assignments/submit');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: assignmentsAsync.when(
              data: (assignments) {
                if (assignments.isEmpty) {
                  return Center(
                    child: Text(
                      'No assignments found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }

                final headers = ['Title', 'Class', 'Subject', 'Due Date', 'Status', 'Actions'];
                final rows = assignments.map((assignment) => [
                  assignment.title,
                  assignment.className,
                  assignment.subject,
                  assignment.dueDate,
                  assignment.isOverdue ? 'Overdue' : 'Active',
                  'View',
                ]).toList();

                return AppTable(
                  headers: headers,
                  rows: rows,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error loading assignments: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
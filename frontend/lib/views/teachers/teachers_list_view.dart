import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/teacher_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class TeachersListView extends ConsumerWidget {
  const TeachersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsync = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
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
                    labelText: 'Search teachers...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Add Teacher',
                  icon: Icons.add,
                  onPressed: () {
                    // Handle add teacher
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: teachersAsync.when(
              data: (teachers) {
                if (teachers.isEmpty) {
                  return Center(
                    child: Text(
                      'No teachers found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }

                final headers = ['Name', 'Subject', 'Email', 'Phone', 'Actions'];
                final rows = teachers.map((teacher) => [
                  teacher.fullName,
                  teacher.subject,
                  teacher.email,
                  teacher.phone,
                  'View',
                ]).toList();

                return AppTable(
                  headers: headers,
                  rows: rows,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error loading teachers: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
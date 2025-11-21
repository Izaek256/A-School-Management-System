import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/class_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class ClassesListView extends ConsumerWidget {
  const ClassesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsync = ref.watch(classesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
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
                    labelText: 'Search classes...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Add Class',
                  icon: Icons.add,
                  onPressed: () {
                    // Handle add class
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: classesAsync.when(
              data: (classes) {
                if (classes.isEmpty) {
                  return Center(
                    child: Text(
                      'No classes found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }

                final headers = ['Name', 'Section', 'Teacher', 'Capacity', 'Actions'];
                final rows = classes.map((classModel) => [
                  classModel.name,
                  classModel.section,
                  classModel.classTeacherName ?? 'N/A',
                  classModel.capacity.toString(),
                  'View',
                ]).toList();

                return AppTable(
                  headers: headers,
                  rows: rows.map((row) => row.map((e) => e.toString()).toList()).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error loading classes: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
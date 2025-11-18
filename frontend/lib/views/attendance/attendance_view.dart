import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class AttendanceView extends ConsumerWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppInput(
                          labelText: 'Select Class',
                          prefixIcon: Icons.class_,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppInput(
                          labelText: 'Select Date',
                          prefixIcon: Icons.calendar_today,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Take Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildStudentRow('John Doe', 'STU001'),
                      const Divider(),
                      _buildStudentRow('Jane Smith', 'STU002'),
                      const Divider(),
                      _buildStudentRow('Robert Johnson', 'STU003'),
                      const Divider(),
                      _buildStudentRow('Emily Davis', 'STU004'),
                      const Divider(),
                      _buildStudentRow('Michael Wilson', 'STU005'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Save Attendance',
                onPressed: () {
                  // Handle save attendance
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Attendance saved successfully'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentRow(String name, String id) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(name.substring(0, 1)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                id,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            ChoiceChip(
              label: const Text('Present'),
              selected: true,
              onSelected: (selected) {
                // Handle present selection
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Absent'),
              selected: false,
              onSelected: (selected) {
                // Handle absent selection
              },
            ),
          ],
        ),
      ],
    );
  }
}
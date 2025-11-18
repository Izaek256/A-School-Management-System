import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class TimetableView extends ConsumerWidget {
  const TimetableView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
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
                          labelText: 'Select Week',
                          prefixIcon: Icons.calendar_today,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Weekly Timetable',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Timetable grid
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Header row
                    _buildHeaderRow(context),
                    // Time slots
                    _buildTimeSlot('08:00 - 09:00', ['Math', 'English', 'Science', 'History', 'Art']),
                    const Divider(height: 1),
                    _buildTimeSlot('09:00 - 10:00', ['English', 'Math', 'History', 'Science', 'PE']),
                    const Divider(height: 1),
                    _buildTimeSlot('10:00 - 11:00', ['Science', 'History', 'Math', 'Art', 'English']),
                    const Divider(height: 1),
                    _buildTimeSlot('11:00 - 12:00', ['History', 'Science', 'English', 'Math', 'Music']),
                    const Divider(height: 1),
                    _buildTimeSlot('12:00 - 13:00', ['Lunch Break', 'Lunch Break', 'Lunch Break', 'Lunch Break', 'Lunch Break']),
                    const Divider(height: 1),
                    _buildTimeSlot('13:00 - 14:00', ['Art', 'PE', 'Music', 'English', 'Science']),
                    const Divider(height: 1),
                    _buildTimeSlot('14:00 - 15:00', ['PE', 'Art', 'English', 'Math', 'History']),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Edit Timetable',
                onPressed: () {
                  // Handle edit timetable
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      child: const Row(
        children: [
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Monday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Tuesday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Wednesday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Thursday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Friday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, List<String> subjects) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Center(child: Text(time)),
        ),
        const VerticalDivider(width: 1),
        ...subjects.map((subject) => Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(child: Text(subject)),
          ),
        )),
      ],
    );
  }
}
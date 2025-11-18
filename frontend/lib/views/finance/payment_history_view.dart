import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class PaymentHistoryView extends ConsumerWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
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
                    labelText: 'Search payments...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Export',
                  icon: Icons.download,
                  onPressed: () {
                    // Handle export
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: AppTable(
              headers: ['Student', 'Class', 'Amount', 'Date', 'Method', 'Status'],
              rows: [
                ['John Doe', 'Grade 10', '\$150.00', '2023-10-15', 'Credit Card', 'Completed'],
                ['Jane Smith', 'Grade 9', '\$120.00', '2023-10-18', 'Bank Transfer', 'Completed'],
                ['Robert Johnson', 'Grade 11', '\$180.00', '2023-10-20', 'PayPal', 'Completed'],
                ['Emily Davis', 'Grade 8', '\$100.00', '2023-10-22', 'Credit Card', 'Completed'],
                ['Michael Wilson', 'Grade 12', '\$200.00', '2023-10-25', 'Bank Transfer', 'Completed'],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/providers/invoice_provider.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';
import 'package:frontend/widgets/tables/app_table.dart';

class InvoicesListView extends ConsumerWidget {
  const InvoicesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(invoicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
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
                    labelText: 'Search invoices...',
                    prefixIcon: Icons.search,
                  ),
                ),
                const SizedBox(width: 16),
                PrimaryButton(
                  text: 'Create Invoice',
                  icon: Icons.add,
                  onPressed: () {
                    context.push('/finance/invoices/create');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: invoicesAsync.when(
              data: (invoices) {
                if (invoices.isEmpty) {
                  return Center(
                    child: Text(
                      'No invoices found',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }

                final headers = ['Invoice #', 'Student', 'Amount', 'Date', 'Status', 'Actions'];
                final rows = invoices.map((invoice) => [
                  invoice.invoiceNumber,
                  invoice.studentName,
                  '\$${invoice.totalAmount.toStringAsFixed(2)}',
                  invoice.invoiceDate,
                  _getStatusText(invoice.status),
                  'View',
                ]).toList();

                return AppTable(
                  headers: headers,
                  rows: rows.map((row) => row.map((e) => e.toString()).toList()).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error loading invoices: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'paid':
        return 'Paid';
      case 'pending':
        return 'Pending';
      case 'overdue':
        return 'Overdue';
      default:
        return status;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/buttons/primary_button.dart';
import 'package:frontend/widgets/inputs/app_input.dart';

class CreateInvoiceView extends ConsumerWidget {
  const CreateInvoiceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
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
                'Invoice Details',
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
                        labelText: 'Student',
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Class',
                        prefixIcon: Icons.class_,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Description',
                        prefixIcon: Icons.description,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Amount',
                        prefixIcon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Due Date',
                        prefixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        labelText: 'Status',
                        prefixIcon: Icons.info,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Invoice',
                onPressed: () {
                  // Handle create invoice
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invoice created successfully'),
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
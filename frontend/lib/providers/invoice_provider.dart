import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/invoice.dart';
import 'package:frontend/repositories/invoice_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/providers/api_service_provider.dart';

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return InvoiceRepository(apiService);
});

final invoicesProvider = FutureProvider<List<Invoice>>((ref) async {
  final repository = ref.watch(invoiceRepositoryProvider);
  return await repository.getInvoices();
});

final invoiceProvider = FutureProvider.family<Invoice, String>((ref, id) async {
  final repository = ref.watch(invoiceRepositoryProvider);
  return await repository.getInvoiceById(id);
});

class InvoiceNotifier extends StateNotifier<AsyncValue<List<Invoice>>> {
  final InvoiceRepository _repository;

  InvoiceNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadInvoices() async {
    state = const AsyncValue.loading();
    try {
      final invoices = await _repository.getInvoices();
      state = AsyncValue.data(invoices);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<Invoice> createInvoice(Map<String, dynamic> data) async {
    try {
      final invoice = await _repository.createInvoice(data);
      // Reload the list
      await loadInvoices();
      return invoice;
    } catch (e) {
      rethrow;
    }
  }

  Future<Invoice> updateInvoice(String id, Map<String, dynamic> data) async {
    try {
      final invoice = await _repository.updateInvoice(id, data);
      // Reload the list
      await loadInvoices();
      return invoice;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      await loadInvoices();
    } catch (e) {
      rethrow;
    }
  }
}

final invoiceNotifierProvider = StateNotifierProvider<InvoiceNotifier, AsyncValue<List<Invoice>>>((ref) {
  final repository = ref.watch(invoiceRepositoryProvider);
  return InvoiceNotifier(repository);
});
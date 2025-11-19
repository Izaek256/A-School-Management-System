import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/invoice.dart';
import 'package:frontend/repositories/invoice_repository.dart';
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

class InvoiceNotifier extends AsyncNotifier<List<Invoice>> {
  late final InvoiceRepository _repository;

  @override
  Future<List<Invoice>> build() async {
    _repository = ref.read(invoiceRepositoryProvider);
    return await _loadInvoices();
  }

  Future<List<Invoice>> _loadInvoices() async {
    return await _repository.getInvoices();
  }

  Future<Invoice> createInvoice(Map<String, dynamic> data) async {
    try {
      final invoice = await _repository.createInvoice(data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadInvoices());
      return invoice;
    } catch (e) {
      rethrow;
    }
  }

  Future<Invoice> updateInvoice(String id, Map<String, dynamic> data) async {
    try {
      final invoice = await _repository.updateInvoice(id, data);
      // Reload the list
      state = await AsyncValue.guard(() => _loadInvoices());
      return invoice;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      await _repository.delete(id);
      // Reload the list
      state = await AsyncValue.guard(() => _loadInvoices());
    } catch (e) {
      rethrow;
    }
  }
}

final invoiceNotifierProvider = AsyncNotifierProvider<InvoiceNotifier, List<Invoice>>(InvoiceNotifier.new);
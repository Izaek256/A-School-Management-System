import 'package:frontend/repositories/base_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/invoice.dart';

class InvoiceRepository extends BaseRepository {
  InvoiceRepository(super.apiService);

  @override
  String get basePath => '/invoices';

  Future<List<Invoice>> getInvoices() async {
    return await getList(Invoice.fromJson);
  }

  Future<Invoice> getInvoiceById(String id) async {
    return await getById(id, Invoice.fromJson);
  }

  Future<Invoice> createInvoice(Map<String, dynamic> data) async {
    return await create(data, Invoice.fromJson);
  }

  Future<Invoice> updateInvoice(String id, Map<String, dynamic> data) async {
    return await update(id, data, Invoice.fromJson);
  }
}
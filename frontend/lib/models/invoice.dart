class Invoice {
  final int id;
  final int studentId;
  final String studentName;
  final String invoiceNumber;
  final String invoiceDate;
  final String dueDate;
  final double totalAmount;
  final double paidAmount;
  final String status;
  final String? remarks;

  Invoice({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    required this.totalAmount,
    required this.paidAmount,
    required this.status,
    this.remarks,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      studentId: json['student'] ?? 0,
      studentName: json['student_name'] ?? '',
      invoiceNumber: json['invoice_number'] ?? '',
      invoiceDate: json['invoice_date'] ?? '',
      dueDate: json['due_date'] ?? '',
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      paidAmount: (json['paid_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'pending',
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student': studentId,
      'student_name': studentName,
      'invoice_number': invoiceNumber,
      'invoice_date': invoiceDate,
      'due_date': dueDate,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'status': status,
      'remarks': remarks,
    };
  }

  bool get isPaid => status == 'paid';
  bool get isOverdue => status == 'overdue';
}
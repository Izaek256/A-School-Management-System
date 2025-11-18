class Invoice {
  final String id;
  final String studentId;
  final String studentName;
  final String className;
  final String description;
  final double amount;
  final String dueDate;
  final String status; // paid, pending, overdue
  final String issuedDate;
  final String? paidDate;

  Invoice({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.className,
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.issuedDate,
    this.paidDate,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as String,
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      className: json['class_name'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: json['due_date'] as String,
      status: json['status'] as String,
      issuedDate: json['issued_date'] as String,
      paidDate: json['paid_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'student_name': studentName,
      'class_name': className,
      'description': description,
      'amount': amount,
      'due_date': dueDate,
      'status': status,
      'issued_date': issuedDate,
      'paid_date': paidDate,
    };
  }

  bool get isPaid => status == 'paid';
  bool get isOverdue => status == 'overdue';
}
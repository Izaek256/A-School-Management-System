from django.db import models
from core.models import TenantModel


class FeeType(TenantModel):
    """
    Model representing different types of fees.
    """
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return self.name

    class Meta(TenantModel.Meta):
        db_table = 'finance_fee_type'


class FeeStructure(TenantModel):
    """
    Model representing fee structure for classes.
    """
    name = models.CharField(max_length=200)
    class_assigned = models.ForeignKey('academics.Class', on_delete=models.CASCADE)
    fee_type = models.ForeignKey(FeeType, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    due_date = models.DateField()
    academic_year = models.ForeignKey('academics.AcademicYear', on_delete=models.CASCADE)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.name} - {self.class_assigned}"

    class Meta(TenantModel.Meta):
        db_table = 'finance_fee_structure'


class Discount(TenantModel):
    """
    Model representing discounts applicable to fees.
    """
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    discount_type = models.CharField(max_length=20, choices=[('percentage', 'Percentage'), ('fixed', 'Fixed Amount')])
    discount_value = models.DecimalField(max_digits=5, decimal_places=2)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return self.name

    class Meta(TenantModel.Meta):
        db_table = 'finance_discount'


class FeeInvoice(TenantModel):
    """
    Model representing fee invoices for students.
    """
    INVOICE_STATUS_CHOICES = [
        ('draft', 'Draft'),
        ('unpaid', 'Unpaid'),
        ('partially_paid', 'Partially Paid'),
        ('paid', 'Paid'),
        ('overdue', 'Overdue'),
        ('cancelled', 'Cancelled'),
    ]
    
    student = models.ForeignKey('students.Student', on_delete=models.CASCADE)
    invoice_number = models.CharField(max_length=50, unique=True)
    invoice_date = models.DateField()
    due_date = models.DateField()
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    discount = models.ForeignKey(Discount, on_delete=models.SET_NULL, null=True, blank=True)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    paid_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.CharField(max_length=20, choices=INVOICE_STATUS_CHOICES, default='unpaid')
    remarks = models.TextField(blank=True)
    generated_by = models.ForeignKey('accounts.User', on_delete=models.SET_NULL, null=True, blank=True)
    
    def __str__(self):
        return f"Invoice {self.invoice_number} for {self.student}"

    class Meta(TenantModel.Meta):
        db_table = 'finance_fee_invoice'


class InvoiceItem(TenantModel):
    """
    Model representing individual items in a fee invoice.
    """
    invoice = models.ForeignKey(FeeInvoice, on_delete=models.CASCADE, related_name='items')
    fee_type = models.ForeignKey(FeeType, on_delete=models.CASCADE)
    description = models.CharField(max_length=200)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    
    def __str__(self):
        return f"{self.description} - {self.amount}"

    class Meta(TenantModel.Meta):
        db_table = 'finance_invoice_item'


class Payment(TenantModel):
    """
    Model representing payments made against invoices.
    """
    PAYMENT_METHOD_CHOICES = [
        ('cash', 'Cash'),
        ('bank_transfer', 'Bank Transfer'),
        ('credit_card', 'Credit Card'),
        ('debit_card', 'Debit Card'),
        ('mobile_money', 'Mobile Money'),
        ('cheque', 'Cheque'),
    ]
    
    invoice = models.ForeignKey(FeeInvoice, on_delete=models.CASCADE, related_name='payments')
    payment_date = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=20, choices=PAYMENT_METHOD_CHOICES)
    transaction_id = models.CharField(max_length=100, blank=True)
    remarks = models.TextField(blank=True)
    received_by = models.ForeignKey('accounts.User', on_delete=models.SET_NULL, null=True, blank=True)
    
    def __str__(self):
        return f"Payment of {self.amount} on {self.payment_date}"

    class Meta(TenantModel.Meta):
        db_table = 'finance_payment'
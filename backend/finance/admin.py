from django.contrib import admin
from .models import FeeType, Discount, FeeStructure, FeeInvoice, InvoiceItem, Payment

# Register your models here
@admin.register(FeeType)
class FeeTypeAdmin(admin.ModelAdmin):
    list_display = ('name', 'school', 'is_active', 'created_at')
    list_filter = ('school', 'is_active', 'created_at')
    search_fields = ('name',)
    ordering = ('name',)

@admin.register(Discount)
class DiscountAdmin(admin.ModelAdmin):
    list_display = ('name', 'school', 'discount_type', 'discount_value', 'is_active')
    list_filter = ('school', 'discount_type', 'is_active', 'created_at')
    search_fields = ('name',)
    ordering = ('name',)

@admin.register(FeeStructure)
class FeeStructureAdmin(admin.ModelAdmin):
    list_display = ('name', 'class_assigned', 'school', 'fee_type', 'amount', 'due_date', 'academic_year')
    list_filter = ('school', 'academic_year', 'created_at')
    search_fields = ('name', 'class_assigned__name')
    ordering = ('-created_at',)

@admin.register(FeeInvoice)
class FeeInvoiceAdmin(admin.ModelAdmin):
    list_display = ('invoice_number', 'student', 'school', 'total_amount', 'due_date', 'status', 'created_at')
    list_filter = ('school', 'status', 'due_date', 'created_at')
    search_fields = ('invoice_number', 'student__first_name', 'student__last_name')
    ordering = ('-created_at',)

@admin.register(InvoiceItem)
class InvoiceItemAdmin(admin.ModelAdmin):
    list_display = ('invoice', 'fee_type', 'description', 'amount', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('invoice__invoice_number', 'fee_type__name', 'description')
    ordering = ('-created_at',)

@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ('invoice', 'payment_date', 'amount', 'payment_method', 'transaction_id', 'created_at')
    list_filter = ('payment_method', 'payment_date', 'created_at')
    search_fields = ('invoice__invoice_number', 'transaction_id')
    ordering = ('-payment_date',)
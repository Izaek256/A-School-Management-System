from rest_framework import serializers
from django.db.models import Sum
from .models import FeeType, FeeStructure, Discount, FeeInvoice, InvoiceItem, Payment
from students.models import Student
from academics.models import Class, AcademicYear


class FeeTypeSerializer(serializers.ModelSerializer):
    """
    Serializer for the FeeType model.
    """
    class Meta:
        model = FeeType
        fields = [
            'id', 'name', 'description', 'is_active', 
            'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class FeeStructureSerializer(serializers.ModelSerializer):
    """
    Serializer for the FeeStructure model.
    """
    class_name = serializers.CharField(source='class_assigned.name', read_only=True)
    fee_type_name = serializers.CharField(source='fee_type.name', read_only=True)
    academic_year_name = serializers.CharField(source='academic_year.name', read_only=True)
    
    class Meta:
        model = FeeStructure
        fields = [
            'id', 'name', 'class_assigned', 'class_name', 'fee_type', 
            'fee_type_name', 'amount', 'due_date', 'academic_year', 
            'academic_year_name', 'is_active', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class DiscountSerializer(serializers.ModelSerializer):
    """
    Serializer for the Discount model.
    """
    class Meta:
        model = Discount
        fields = [
            'id', 'name', 'description', 'discount_type', 
            'discount_value', 'is_active', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class InvoiceItemSerializer(serializers.ModelSerializer):
    """
    Serializer for the InvoiceItem model.
    """
    fee_type_name = serializers.CharField(source='fee_type.name', read_only=True)
    
    class Meta:
        model = InvoiceItem
        fields = [
            'id', 'invoice', 'fee_type', 'fee_type_name', 
            'description', 'amount'
        ]
        read_only_fields = ['id']


class FeeInvoiceSerializer(serializers.ModelSerializer):
    """
    Serializer for the FeeInvoice model.
    """
    student_name = serializers.CharField(source='student.first_name', read_only=True)
    discount_name = serializers.CharField(source='discount.name', read_only=True)
    generated_by_name = serializers.CharField(source='generated_by.username', read_only=True)
    items = InvoiceItemSerializer(many=True, read_only=True)
    total_paid = serializers.SerializerMethodField()
    
    class Meta:
        model = FeeInvoice
        fields = [
            'id', 'student', 'student_name', 'invoice_number', 'invoice_date', 
            'due_date', 'total_amount', 'discount', 'discount_name', 
            'discount_amount', 'paid_amount', 'total_paid', 'status', 'remarks', 
            'generated_by', 'generated_by_name', 'items', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'invoice_number', 'created_at', 'updated_at']
    
    def get_total_paid(self, obj):
        return obj.payments.aggregate(
            total_paid=Sum('amount')
        )['total_paid'] or 0


class FeeInvoiceCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating FeeInvoice with items.
    """
    items = InvoiceItemSerializer(many=True)
    
    class Meta:
        model = FeeInvoice
        fields = [
            'student', 'invoice_date', 'due_date', 'total_amount', 
            'discount', 'remarks', 'items'
        ]
    
    def create(self, validated_data):
        items_data = validated_data.pop('items')
        school = self.context['request'].user.school
        user = self.context['request'].user
        
        # Create invoice
        invoice = FeeInvoice.objects.create(
            school=school,
            generated_by=user,
            **validated_data
        )
        
        # Create invoice items
        for item_data in items_data:
            InvoiceItem.objects.create(invoice=invoice, **item_data)
        
        return invoice


class PaymentSerializer(serializers.ModelSerializer):
    """
    Serializer for the Payment model.
    """
    invoice_number = serializers.CharField(source='invoice.invoice_number', read_only=True)
    received_by_name = serializers.CharField(source='received_by.username', read_only=True)
    
    class Meta:
        model = Payment
        fields = [
            'id', 'invoice', 'invoice_number', 'payment_date', 'amount', 
            'payment_method', 'transaction_id', 'remarks', 'received_by', 
            'received_by_name', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class PaymentCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating Payment.
    """
    class Meta:
        model = Payment
        fields = [
            'invoice', 'payment_date', 'amount', 
            'payment_method', 'transaction_id', 'remarks'
        ]
    
    def create(self, validated_data):
        school = self.context['request'].user.school
        user = self.context['request'].user
        
        # Create payment
        payment = Payment.objects.create(
            school=school,
            received_by=user,
            **validated_data
        )
        
        # Update invoice paid amount
        invoice = payment.invoice
        invoice.paid_amount += payment.amount
        if invoice.paid_amount >= invoice.total_amount:
            invoice.status = 'paid'
        elif invoice.paid_amount > 0:
            invoice.status = 'partially_paid'
        invoice.save()
        
        return payment

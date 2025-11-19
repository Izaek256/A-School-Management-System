from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from django_filters.rest_framework import DjangoFilterBackend
from .models import FeeType, FeeStructure, Discount, FeeInvoice, InvoiceItem, Payment
from .serializers import (
    FeeTypeSerializer, FeeStructureSerializer, DiscountSerializer,
    FeeInvoiceSerializer, FeeInvoiceCreateSerializer, PaymentSerializer,
    PaymentCreateSerializer
)


class FeeTypeViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing fee types.
    """
    queryset = FeeType.objects.all()
    serializer_class = FeeTypeSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['is_active']
    
    def get_queryset(self):
        """
        Filter fee types based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return FeeType.objects.all()
        elif user.school:
            return FeeType.objects.filter(school=user.school)
        return FeeType.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating a fee type.
        """
        user = self.request.user
        serializer.save(school=user.school)


class FeeStructureViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing fee structures.
    """
    queryset = FeeStructure.objects.all()
    serializer_class = FeeStructureSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['class_assigned', 'academic_year', 'is_active']
    
    def get_queryset(self):
        """
        Filter fee structures based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return FeeStructure.objects.all()
        elif user.school:
            return FeeStructure.objects.filter(school=user.school)
        return FeeStructure.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating a fee structure.
        """
        user = self.request.user
        serializer.save(school=user.school)


class DiscountViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing discounts.
    """
    queryset = Discount.objects.all()
    serializer_class = DiscountSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['is_active']
    
    def get_queryset(self):
        """
        Filter discounts based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Discount.objects.all()
        elif user.school:
            return Discount.objects.filter(school=user.school)
        return Discount.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating a discount.
        """
        user = self.request.user
        serializer.save(school=user.school)


class FeeInvoiceViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing fee invoices.
    """
    queryset = FeeInvoice.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['student', 'status']
    
    def get_queryset(self):
        """
        Filter fee invoices based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return FeeInvoice.objects.all()
        elif user.school:
            return FeeInvoice.objects.filter(school=user.school)
        return FeeInvoice.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return FeeInvoiceCreateSerializer
        return FeeInvoiceSerializer
    
    def perform_create(self, serializer):
        """
        Set the school and generated_by when creating a fee invoice.
        """
        user = self.request.user
        serializer.save(school=user.school, generated_by=user)


class PaymentViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing payments.
    """
    queryset = Payment.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['invoice', 'payment_method']
    
    def get_queryset(self):
        """
        Filter payments based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Payment.objects.all()
        elif user.school:
            return Payment.objects.filter(school=user.school)
        return Payment.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return PaymentCreateSerializer
        return PaymentSerializer
    
    def perform_create(self, serializer):
        """
        Set the school and received_by when creating a payment.
        """
        user = self.request.user
        serializer.save(school=user.school, received_by=user)
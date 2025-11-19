from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    FeeTypeViewSet, FeeStructureViewSet, DiscountViewSet,
    FeeInvoiceViewSet, PaymentViewSet
)

# Create router and register viewsets
router = DefaultRouter()
router.register(r'fee-types', FeeTypeViewSet, basename='fee-type')
router.register(r'fee-structures', FeeStructureViewSet, basename='fee-structure')
router.register(r'discounts', DiscountViewSet, basename='discount')
router.register(r'invoices', FeeInvoiceViewSet, basename='invoice')
router.register(r'payments', PaymentViewSet, basename='payment')

urlpatterns = [
    path('', include(router.urls)),
]
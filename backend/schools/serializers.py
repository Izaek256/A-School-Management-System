from rest_framework import serializers
from .models import School


class SchoolSerializer(serializers.ModelSerializer):
    """
    Serializer for the School model.
    """
    class Meta:
        model = School
        fields = [
            'id', 'name', 'slug', 'email', 'phone', 'address', 'city',
            'state', 'country', 'postal_code', 'logo', 'website',
            'is_verified', 'subscription_plan', 'subscription_expiry',
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']
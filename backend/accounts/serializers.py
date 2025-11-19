from rest_framework import serializers
from .models import User, NotificationToken
from schools.models import School


class UserSerializer(serializers.ModelSerializer):
    """
    Serializer for the User model.
    """
    password = serializers.CharField(write_only=True)
    school_name = serializers.CharField(source='school.name', read_only=True)
    
    class Meta:
        model = User
        fields = [
            'id', 'username', 'email', 'first_name', 'last_name', 'role',
            'school', 'school_name', 'phone', 'profile_picture', 'date_of_birth',
            'address', 'city', 'state', 'country', 'postal_code', 'password',
            'is_active', 'date_joined'
        ]
        read_only_fields = ['id', 'date_joined']
    
    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user


class UserRegistrationSerializer(serializers.ModelSerializer):
    """
    Serializer for user registration.
    """
    password = serializers.CharField(write_only=True)
    password_confirm = serializers.CharField(write_only=True)
    school_slug = serializers.SlugField(write_only=True)
    
    class Meta:
        model = User
        fields = [
            'username', 'email', 'first_name', 'last_name', 'role',
            'school_slug', 'phone', 'date_of_birth', 'password', 'password_confirm'
        ]
    
    def validate(self, attrs):
        if attrs['password'] != attrs['password_confirm']:
            raise serializers.ValidationError("Passwords do not match.")
        
        # Check if school exists
        try:
            school = School.objects.get(slug=attrs['school_slug'])
            attrs['school'] = school
        except School.DoesNotExist:
            raise serializers.ValidationError("School does not exist.")
        
        return attrs
    
    def create(self, validated_data):
        validated_data.pop('password_confirm')
        validated_data.pop('school_slug')
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)
        user.save()
        return user


class LoginSerializer(serializers.Serializer):
    """
    Serializer for user login.
    """
    username = serializers.CharField()
    password = serializers.CharField()


class NotificationTokenSerializer(serializers.ModelSerializer):
    """
    Serializer for notification tokens.
    """
    class Meta:
        model = NotificationToken
        fields = ['id', 'token', 'device_type', 'is_active']
        read_only_fields = ['id']


class UserProfileSerializer(serializers.ModelSerializer):
    """
    Serializer for user profile updates.
    """
    class Meta:
        model = User
        fields = [
            'first_name', 'last_name', 'email', 'phone', 'profile_picture',
            'date_of_birth', 'address', 'city', 'state', 'country', 'postal_code'
        ]
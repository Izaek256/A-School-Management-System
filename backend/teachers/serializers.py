from rest_framework import serializers
from .models import Teacher
from accounts.models import User


class TeacherSerializer(serializers.ModelSerializer):
    """
    Serializer for the Teacher model.
    """
    user_username = serializers.CharField(source='user.username', read_only=True)
    
    class Meta:
        model = Teacher
        fields = [
            'id', 'user', 'user_username', 'employee_id', 'first_name', 'last_name',
            'date_of_birth', 'gender', 'blood_group', 'religion', 'phone', 'email',
            'address', 'city', 'state', 'country', 'postal_code', 'joining_date',
            'qualification', 'experience', 'salary', 'department', 'designation',
            'is_active', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class TeacherCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating teachers with user creation.
    """
    username = serializers.CharField(write_only=True)
    password = serializers.CharField(write_only=True)
    email = serializers.EmailField()
    
    class Meta:
        model = Teacher
        fields = [
            'username', 'password', 'email', 'employee_id', 'first_name', 'last_name',
            'date_of_birth', 'gender', 'blood_group', 'religion', 'phone', 'email',
            'address', 'city', 'state', 'country', 'postal_code', 'joining_date',
            'qualification', 'experience', 'salary', 'department', 'designation'
        ]
    
    def create(self, validated_data):
        # Extract user data
        username = validated_data.pop('username')
        password = validated_data.pop('password')
        email = validated_data.pop('email')
        
        # Get school from context
        school = self.context['request'].user.school
        
        # Create user
        user = User.objects.create_user(
            username=username,
            password=password,
            email=email,
            role='teacher',
            school=school
        )
        
        # Create teacher
        teacher = Teacher.objects.create(
            user=user,
            school=school,
            **validated_data
        )
        
        return teacher
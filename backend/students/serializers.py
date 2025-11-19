from rest_framework import serializers
from .models import Student, Guardian
from accounts.models import User
from academics.models import Class


class GuardianSerializer(serializers.ModelSerializer):
    """
    Serializer for the Guardian model.
    """
    class Meta:
        model = Guardian
        fields = [
            'id', 'first_name', 'last_name', 'relationship', 'phone',
            'email', 'occupation', 'address', 'is_primary_contact'
        ]
        read_only_fields = ['id']


class StudentSerializer(serializers.ModelSerializer):
    """
    Serializer for the Student model.
    """
    user_username = serializers.CharField(source='user.username', read_only=True)
    admission_class_name = serializers.CharField(source='admission_class.name', read_only=True)
    current_class_name = serializers.CharField(source='current_class.name', read_only=True)
    guardians = GuardianSerializer(many=True, read_only=True)
    
    class Meta:
        model = Student
        fields = [
            'id', 'user', 'user_username', 'student_id', 'first_name', 'last_name',
            'date_of_birth', 'gender', 'blood_group', 'religion', 'phone', 'email',
            'address', 'city', 'state', 'country', 'postal_code', 'father_name',
            'mother_name', 'parent_phone', 'parent_email', 'admission_date',
            'admission_class', 'admission_class_name', 'current_class', 
            'current_class_name', 'roll_number', 'created_at', 'updated_at',
            'is_active', 'guardians'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']
    
    def create(self, validated_data):
        # Create student
        student = Student.objects.create(**validated_data)
        return student


class StudentCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating students with user creation.
    """
    username = serializers.CharField(write_only=True)
    password = serializers.CharField(write_only=True)
    email = serializers.EmailField()
    
    class Meta:
        model = Student
        fields = [
            'username', 'password', 'email', 'student_id', 'first_name', 'last_name',
            'date_of_birth', 'gender', 'blood_group', 'religion', 'phone',
            'address', 'city', 'state', 'country', 'postal_code', 'father_name',
            'mother_name', 'parent_phone', 'parent_email', 'admission_date',
            'admission_class', 'current_class', 'roll_number'
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
            role='student',
            school=school
        )
        
        # Create student
        student = Student.objects.create(
            user=user,
            school=school,
            **validated_data
        )
        
        return student
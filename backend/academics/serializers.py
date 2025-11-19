from rest_framework import serializers
from .models import (
    AcademicYear, Class, Subject, Enrollment, 
    Attendance, Exam, ExamResult
)
from students.models import Student
from teachers.models import Teacher


class AcademicYearSerializer(serializers.ModelSerializer):
    """
    Serializer for the AcademicYear model.
    """
    class Meta:
        model = AcademicYear
        fields = [
            'id', 'name', 'start_date', 'end_date', 
            'is_current', 'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class ClassSerializer(serializers.ModelSerializer):
    """
    Serializer for the Class model.
    """
    class_teacher_name = serializers.CharField(source='class_teacher.first_name', read_only=True)
    academic_year_name = serializers.CharField(source='academic_year.name', read_only=True)
    
    class Meta:
        model = Class
        fields = [
            'id', 'name', 'section', 'class_teacher', 'class_teacher_name',
            'academic_year', 'academic_year_name', 'capacity', 
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class SubjectSerializer(serializers.ModelSerializer):
    """
    Serializer for the Subject model.
    """
    teacher_name = serializers.CharField(source='teacher.first_name', read_only=True)
    classes_count = serializers.SerializerMethodField()
    
    class Meta:
        model = Subject
        fields = [
            'id', 'name', 'code', 'description', 'class_assigned',
            'teacher', 'teacher_name', 'credit_hours', 'classes_count',
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']
    
    def get_classes_count(self, obj):
        return obj.class_assigned.count()


class EnrollmentSerializer(serializers.ModelSerializer):
    """
    Serializer for the Enrollment model.
    """
    student_name = serializers.CharField(source='student.first_name', read_only=True)
    class_name = serializers.CharField(source='class_enrolled.name', read_only=True)
    academic_year_name = serializers.CharField(source='academic_year.name', read_only=True)
    
    class Meta:
        model = Enrollment
        fields = [
            'id', 'student', 'student_name', 'class_enrolled', 'class_name',
            'enrollment_date', 'academic_year', 'academic_year_name',
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'enrollment_date', 'created_at', 'updated_at']


class AttendanceSerializer(serializers.ModelSerializer):
    """
    Serializer for the Attendance model.
    """
    student_name = serializers.CharField(source='student.first_name', read_only=True)
    class_name = serializers.CharField(source='class_attended.name', read_only=True)
    subject_name = serializers.CharField(source='subject.name', read_only=True)
    taken_by_name = serializers.CharField(source='taken_by.first_name', read_only=True)
    
    class Meta:
        model = Attendance
        fields = [
            'id', 'student', 'student_name', 'class_attended', 'class_name',
            'subject', 'subject_name', 'date', 'status', 'remarks', 'taken_by', 
            'taken_by_name', 'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class ExamSerializer(serializers.ModelSerializer):
    """
    Serializer for the Exam model.
    """
    subject_name = serializers.CharField(source='subject.name', read_only=True)
    class_name = serializers.CharField(source='class_assigned.name', read_only=True)
    academic_year_name = serializers.CharField(source='academic_year.name', read_only=True)
    
    class Meta:
        model = Exam
        fields = [
            'id', 'name', 'exam_type', 'subject', 'subject_name', 'class_assigned', 
            'class_name', 'date', 'start_time', 'end_time', 'max_marks', 
            'passing_marks', 'academic_year', 'academic_year_name', 'is_published',
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class ExamResultSerializer(serializers.ModelSerializer):
    """
    Serializer for the ExamResult model.
    """
    exam_name = serializers.CharField(source='exam.name', read_only=True)
    student_name = serializers.CharField(source='student.first_name', read_only=True)
    
    class Meta:
        model = ExamResult
        fields = [
            'id', 'exam', 'exam_name', 'student', 'student_name', 'marks_obtained',
            'grade', 'remarks', 'is_pass', 'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']
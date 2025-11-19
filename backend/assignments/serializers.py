from rest_framework import serializers
from django.utils import timezone
from .models import Assignment, Submission
from academics.models import Class, Subject
from teachers.models import Teacher
from students.models import Student


class AssignmentSerializer(serializers.ModelSerializer):
    """
    Serializer for the Assignment model.
    """
    class_name = serializers.CharField(source='class_assigned.name', read_only=True)
    subject_name = serializers.CharField(source='subject.name', read_only=True)
    teacher_name = serializers.CharField(source='teacher.first_name', read_only=True)
    
    class Meta:
        model = Assignment
        fields = [
            'id', 'title', 'description', 'class_assigned', 'class_name',
            'subject', 'subject_name', 'teacher', 'teacher_name', 
            'assignment_type', 'assigned_date', 'due_date', 'max_marks',
            'attachment', 'is_active', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class SubmissionSerializer(serializers.ModelSerializer):
    """
    Serializer for the Submission model.
    """
    assignment_title = serializers.CharField(source='assignment.title', read_only=True)
    student_name = serializers.CharField(source='student.first_name', read_only=True)
    teacher_name = serializers.CharField(source='graded_by.first_name', read_only=True)
    
    class Meta:
        model = Submission
        fields = [
            'id', 'assignment', 'assignment_title', 'student', 'student_name',
            'submission_date', 'submission_text', 'attachment', 'marks_obtained',
            'status', 'feedback', 'graded_by', 'teacher_name', 'graded_date',
            'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'submission_date', 'created_at', 'updated_at']


class SubmissionCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating Submission.
    """
    class Meta:
        model = Submission
        fields = [
            'assignment', 'submission_text', 'attachment'
        ]
    
    def create(self, validated_data):
        # Set the student from the request user
        student = self.context['request'].user.student_profile
        validated_data['student'] = student
        validated_data['status'] = 'submitted'
        
        # Create submission
        submission = Submission.objects.create(**validated_data)
        return submission


class SubmissionGradeSerializer(serializers.ModelSerializer):
    """
    Serializer for grading Submission.
    """
    class Meta:
        model = Submission
        fields = [
            'marks_obtained', 'feedback', 'status'
        ]
    
    def update(self, instance, validated_data):
        # Set the graded_by from the request user
        instance.graded_by = self.context['request'].user.teacher_profile
        instance.status = 'graded'
        instance.graded_date = timezone.now()
        
        # Update submission
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        return instance

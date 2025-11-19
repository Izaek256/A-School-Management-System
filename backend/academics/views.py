from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from django_filters.rest_framework import DjangoFilterBackend
from .models import (
    AcademicYear, Class, Subject, Enrollment, 
    Attendance, Exam, ExamResult
)
from .serializers import (
    AcademicYearSerializer, ClassSerializer, SubjectSerializer, 
    EnrollmentSerializer, AttendanceSerializer, ExamSerializer, 
    ExamResultSerializer
)


class AcademicYearViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing academic years.
    """
    queryset = AcademicYear.objects.all()
    serializer_class = AcademicYearSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['is_current']
    
    def get_queryset(self):
        """
        Filter academic years based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return AcademicYear.objects.all()
        elif user.school:
            return AcademicYear.objects.filter(school=user.school)
        return AcademicYear.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating an academic year.
        """
        user = self.request.user
        serializer.save(school=user.school)


class ClassViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing classes.
    """
    queryset = Class.objects.all()
    serializer_class = ClassSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['academic_year', 'name']
    
    def get_queryset(self):
        """
        Filter classes based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Class.objects.all()
        elif user.school:
            return Class.objects.filter(school=user.school)
        return Class.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating a class.
        """
        user = self.request.user
        serializer.save(school=user.school)


class SubjectViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing subjects.
    """
    queryset = Subject.objects.all()
    serializer_class = SubjectSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['teacher']
    
    def get_queryset(self):
        """
        Filter subjects based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Subject.objects.all()
        elif user.school:
            return Subject.objects.filter(school=user.school)
        return Subject.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating a subject.
        """
        user = self.request.user
        serializer.save(school=user.school)


class EnrollmentViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing enrollments.
    """
    queryset = Enrollment.objects.all()
    serializer_class = EnrollmentSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['academic_year', 'class_enrolled']
    
    def get_queryset(self):
        """
        Filter enrollments based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Enrollment.objects.all()
        elif user.school:
            return Enrollment.objects.filter(school=user.school)
        return Enrollment.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating an enrollment.
        """
        user = self.request.user
        serializer.save(school=user.school)


class AttendanceViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing attendance.
    """
    queryset = Attendance.objects.all()
    serializer_class = AttendanceSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['date', 'status', 'class_attended', 'subject']
    
    def get_queryset(self):
        """
        Filter attendance records based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Attendance.objects.all()
        elif user.school:
            return Attendance.objects.filter(school=user.school)
        return Attendance.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school and taken_by when creating an attendance record.
        """
        user = self.request.user
        serializer.save(school=user.school, taken_by=user.teacher_profile if hasattr(user, 'teacher_profile') else None)


class ExamViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing exams.
    """
    queryset = Exam.objects.all()
    serializer_class = ExamSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['exam_type', 'class_assigned', 'subject', 'academic_year']
    
    def get_queryset(self):
        """
        Filter exams based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Exam.objects.all()
        elif user.school:
            return Exam.objects.filter(school=user.school)
        return Exam.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating an exam.
        """
        user = self.request.user
        serializer.save(school=user.school)


class ExamResultViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing exam results.
    """
    queryset = ExamResult.objects.all()
    serializer_class = ExamResultSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['exam', 'student']
    
    def get_queryset(self):
        """
        Filter exam results based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return ExamResult.objects.all()
        elif user.school:
            return ExamResult.objects.filter(school=user.school)
        return ExamResult.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating an exam result.
        """
        user = self.request.user
        serializer.save(school=user.school)
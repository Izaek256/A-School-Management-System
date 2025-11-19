from rest_framework import viewsets, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Assignment, Submission
from .serializers import (
    AssignmentSerializer, SubmissionSerializer, 
    SubmissionCreateSerializer, SubmissionGradeSerializer
)


class AssignmentViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing assignments.
    """
    queryset = Assignment.objects.all()
    serializer_class = AssignmentSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['class_assigned', 'subject', 'teacher', 'assignment_type']
    
    def get_queryset(self):
        """
        Filter assignments based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Assignment.objects.all()
        elif user.school:
            return Assignment.objects.filter(school=user.school)
        return Assignment.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school when creating an assignment.
        """
        user = self.request.user
        serializer.save(school=user.school)


class SubmissionViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing submissions.
    """
    queryset = Submission.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['assignment', 'student', 'status']
    
    def get_queryset(self):
        """
        Filter submissions based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Submission.objects.all()
        elif user.school:
            return Submission.objects.filter(school=user.school)
        return Submission.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return SubmissionCreateSerializer
        elif self.action == 'grade':
            return SubmissionGradeSerializer
        return SubmissionSerializer
    
    def perform_create(self, serializer):
        """
        Set the school when creating a submission.
        """
        user = self.request.user
        serializer.save(school=user.school)
    
    @action(detail=True, methods=['put'])
    def grade(self, request, pk=None):
        """
        Grade a submission.
        """
        submission = self.get_object()
        serializer = SubmissionGradeSerializer(submission, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
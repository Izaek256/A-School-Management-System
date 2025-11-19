from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from django_filters.rest_framework import DjangoFilterBackend
from .models import Teacher
from .serializers import TeacherSerializer, TeacherCreateSerializer


class TeacherViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing teachers.
    """
    queryset = Teacher.objects.all()
    serializer_class = TeacherSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['department', 'designation', 'is_active']
    
    def get_queryset(self):
        """
        Filter teachers based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Teacher.objects.all()
        elif user.school:
            return Teacher.objects.filter(school=user.school)
        return Teacher.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return TeacherCreateSerializer
        return TeacherSerializer
    
    def perform_create(self, serializer):
        """
        Set the school when creating a teacher.
        """
        user = self.request.user
        serializer.save(school=user.school)
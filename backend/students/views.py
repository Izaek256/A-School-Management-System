from rest_framework import viewsets, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Student, Guardian
from .serializers import StudentSerializer, StudentCreateSerializer, GuardianSerializer


class StudentViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing students.
    """
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['current_class', 'gender']
    
    def get_queryset(self):
        """
        Filter students based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Student.objects.all()
        elif user.school:
            return Student.objects.filter(school=user.school)
        return Student.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return StudentCreateSerializer
        return StudentSerializer
    
    def perform_create(self, serializer):
        """
        Set the school when creating a student.
        """
        user = self.request.user
        serializer.save(school=user.school)
    
    @action(detail=True, methods=['post'])
    def add_guardian(self, request, pk=None):
        """
        Add a guardian to a student.
        """
        student = self.get_object()
        serializer = GuardianSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(student=student)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class GuardianViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing guardians.
    """
    queryset = Guardian.objects.all()
    serializer_class = GuardianSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        """
        Filter guardians based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Guardian.objects.all()
        elif user.school:
            return Guardian.objects.filter(student__school=user.school)
        return Guardian.objects.none()
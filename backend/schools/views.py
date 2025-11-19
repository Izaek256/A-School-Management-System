from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import School
from .serializers import SchoolSerializer


class SchoolViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing schools.
    """
    queryset = School.objects.all()
    serializer_class = SchoolSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        """
        Filter schools based on user role.
        """
        user = self.request.user
        if user.role == 'admin':
            return School.objects.all()
        elif user.school:
            return School.objects.filter(id=user.school.id)
        return School.objects.none()
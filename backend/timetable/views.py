from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from django_filters.rest_framework import DjangoFilterBackend
from .models import Timetable, TimetablePeriod
from .serializers import (
    TimetableSerializer, TimetableCreateSerializer, 
    TimetableUpdateSerializer, TimetablePeriodSerializer
)


class TimetableViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing timetables.
    """
    queryset = Timetable.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['class_assigned', 'academic_year', 'is_active']
    
    def get_queryset(self):
        """
        Filter timetables based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Timetable.objects.all()
        elif user.school:
            return Timetable.objects.filter(school=user.school)
        return Timetable.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return TimetableCreateSerializer
        elif self.action in ['update', 'partial_update']:
            return TimetableUpdateSerializer
        return TimetableSerializer
    
    def perform_create(self, serializer):
        """
        Set the school when creating a timetable.
        """
        user = self.request.user
        serializer.save(school=user.school)


class TimetablePeriodViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing timetable periods.
    """
    queryset = TimetablePeriod.objects.all()
    serializer_class = TimetablePeriodSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['timetable', 'day_of_week', 'period_number']
    
    def get_queryset(self):
        """
        Filter timetable periods based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return TimetablePeriod.objects.all()
        elif user.school:
            return TimetablePeriod.objects.filter(timetable__school=user.school)
        return TimetablePeriod.objects.none()
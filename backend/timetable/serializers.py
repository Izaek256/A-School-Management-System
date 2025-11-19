from rest_framework import serializers
from .models import Timetable, TimetablePeriod
from academics.models import Class, AcademicYear, Subject
from teachers.models import Teacher


class TimetablePeriodSerializer(serializers.ModelSerializer):
    """
    Serializer for the TimetablePeriod model.
    """
    subject_name = serializers.CharField(source='subject.name', read_only=True)
    teacher_name = serializers.CharField(source='teacher.first_name', read_only=True)
    
    class Meta:
        model = TimetablePeriod
        fields = [
            'id', 'timetable', 'day_of_week', 'period_number', 
            'start_time', 'end_time', 'subject', 'subject_name',
            'teacher', 'teacher_name'
        ]


class TimetableSerializer(serializers.ModelSerializer):
    """
    Serializer for the Timetable model.
    """
    class_name = serializers.CharField(source='class_assigned.name', read_only=True)
    academic_year_name = serializers.CharField(source='academic_year.name', read_only=True)
    periods = TimetablePeriodSerializer(many=True, read_only=True)
    
    class Meta:
        model = Timetable
        fields = [
            'id', 'name', 'class_assigned', 'class_name', 'academic_year',
            'academic_year_name', 'is_active', 'periods', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class TimetableCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating Timetable with periods.
    """
    periods = TimetablePeriodSerializer(many=True)
    
    class Meta:
        model = Timetable
        fields = [
            'name', 'class_assigned', 'academic_year', 'is_active', 'periods'
        ]
    
    def create(self, validated_data):
        periods_data = validated_data.pop('periods')
        school = self.context['request'].user.school
        
        # Create timetable
        timetable = Timetable.objects.create(school=school, **validated_data)
        
        # Create timetable periods
        for period_data in periods_data:
            TimetablePeriod.objects.create(timetable=timetable, **period_data)
        
        return timetable


class TimetableUpdateSerializer(serializers.ModelSerializer):
    """
    Serializer for updating Timetable with periods.
    """
    periods = TimetablePeriodSerializer(many=True)
    
    class Meta:
        model = Timetable
        fields = [
            'name', 'class_assigned', 'academic_year', 'is_active', 'periods'
        ]
    
    def update(self, instance, validated_data):
        periods_data = validated_data.pop('periods', None)
        
        # Update timetable
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()
        
        # Update timetable periods if provided
        if periods_data is not None:
            # Delete existing periods
            instance.periods.all().delete()
            
            # Create new periods
            for period_data in periods_data:
                TimetablePeriod.objects.create(timetable=instance, **period_data)
        
        return instance
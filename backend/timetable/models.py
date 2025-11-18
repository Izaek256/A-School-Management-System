from django.db import models
from core.models import TenantModel


class Timetable(TenantModel):
    """
    Model representing a timetable for a class.
    """
    name = models.CharField(max_length=200)
    class_assigned = models.ForeignKey('academics.Class', on_delete=models.CASCADE)
    academic_year = models.ForeignKey('academics.AcademicYear', on_delete=models.CASCADE)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.name} - {self.class_assigned}"

    class Meta(TenantModel.Meta):
        db_table = 'timetable_timetable'


class TimetablePeriod(models.Model):
    """
    Model representing periods in a timetable.
    """
    timetable = models.ForeignKey(Timetable, on_delete=models.CASCADE, related_name='periods')
    day_of_week = models.CharField(max_length=10, choices=[
        ('monday', 'Monday'),
        ('tuesday', 'Tuesday'),
        ('wednesday', 'Wednesday'),
        ('thursday', 'Thursday'),
        ('friday', 'Friday'),
        ('saturday', 'Saturday'),
        ('sunday', 'Sunday'),
    ])
    period_number = models.PositiveIntegerField()
    start_time = models.TimeField()
    end_time = models.TimeField()
    subject = models.ForeignKey('academics.Subject', on_delete=models.CASCADE)
    teacher = models.ForeignKey('teachers.Teacher', on_delete=models.CASCADE)
    
    def __str__(self):
        return f"{self.day_of_week} Period {self.period_number}: {self.subject}"

    class Meta:
        db_table = 'timetable_period'
        unique_together = ['timetable', 'day_of_week', 'period_number']
        ordering = ['day_of_week', 'period_number']
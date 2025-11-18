from django.db import models
from core.models import TenantModel


class Assignment(TenantModel):
    """
    Model representing assignments given to students.
    """
    ASSIGNMENT_TYPE_CHOICES = [
        ('homework', 'Homework'),
        ('project', 'Project'),
        ('essay', 'Essay'),
        ('other', 'Other'),
    ]
    
    title = models.CharField(max_length=200)
    description = models.TextField()
    class_assigned = models.ForeignKey('academics.Class', on_delete=models.CASCADE)
    subject = models.ForeignKey('academics.Subject', on_delete=models.CASCADE)
    teacher = models.ForeignKey('teachers.Teacher', on_delete=models.CASCADE)
    assignment_type = models.CharField(max_length=20, choices=ASSIGNMENT_TYPE_CHOICES)
    assigned_date = models.DateField()
    due_date = models.DateField()
    max_marks = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    attachment = models.URLField(blank=True)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.title} - {self.class_assigned}"

    class Meta(TenantModel.Meta):
        db_table = 'assignments_assignment'


class Submission(TenantModel):
    """
    Model representing assignment submissions by students.
    """
    SUBMISSION_STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('submitted', 'Submitted'),
        ('late', 'Late'),
        ('graded', 'Graded'),
    ]
    
    assignment = models.ForeignKey(Assignment, on_delete=models.CASCADE)
    student = models.ForeignKey('students.Student', on_delete=models.CASCADE)
    submission_date = models.DateTimeField(auto_now_add=True)
    submission_text = models.TextField(blank=True)
    attachment = models.URLField(blank=True)
    marks_obtained = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    status = models.CharField(max_length=20, choices=SUBMISSION_STATUS_CHOICES, default='pending')
    feedback = models.TextField(blank=True)
    graded_by = models.ForeignKey('teachers.Teacher', on_delete=models.SET_NULL, null=True, blank=True, related_name='graded_submissions')
    graded_date = models.DateTimeField(null=True, blank=True)
    
    def __str__(self):
        return f"{self.student} - {self.assignment}"

    class Meta(TenantModel.Meta):
        db_table = 'assignments_submission'
        unique_together = ['school', 'assignment', 'student']
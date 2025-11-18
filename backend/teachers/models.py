from django.db import models
from core.models import TenantModel


class Teacher(TenantModel):
    """
    Model representing a teacher in the system.
    """
    user = models.OneToOneField('accounts.User', on_delete=models.CASCADE, related_name='teacher_profile')
    employee_id = models.CharField(max_length=50, unique=True)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    gender = models.CharField(max_length=10, choices=[('male', 'Male'), ('female', 'Female'), ('other', 'Other')])
    blood_group = models.CharField(max_length=10, blank=True)
    religion = models.CharField(max_length=50, blank=True)
    phone = models.CharField(max_length=20, blank=True)
    email = models.EmailField(blank=True)
    address = models.TextField(blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=100, blank=True)
    country = models.CharField(max_length=100, blank=True)
    postal_code = models.CharField(max_length=20, blank=True)
    joining_date = models.DateField()
    qualification = models.CharField(max_length=200, blank=True)
    experience = models.TextField(blank=True)
    salary = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    department = models.CharField(max_length=100, blank=True)
    designation = models.CharField(max_length=100, blank=True)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.employee_id})"

    class Meta(TenantModel.Meta):
        db_table = 'teachers_teacher'
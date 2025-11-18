from django.db import models
from core.models import TenantModel


class Student(TenantModel):
    """
    Model representing a student in the system.
    """
    user = models.OneToOneField('accounts.User', on_delete=models.CASCADE, related_name='student_profile')
    student_id = models.CharField(max_length=50, unique=True)
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
    father_name = models.CharField(max_length=100, blank=True)
    mother_name = models.CharField(max_length=100, blank=True)
    parent_phone = models.CharField(max_length=20, blank=True)
    parent_email = models.EmailField(blank=True)
    admission_date = models.DateField()
    admission_class = models.ForeignKey('academics.Class', on_delete=models.SET_NULL, null=True, blank=True)
    current_class = models.ForeignKey('academics.Class', on_delete=models.SET_NULL, null=True, blank=True, related_name='current_students')
    roll_number = models.CharField(max_length=20, blank=True)
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.student_id})"

    class Meta(TenantModel.Meta):
        db_table = 'students_student'


class Guardian(models.Model):
    """
    Model representing a guardian/parent of a student.
    """
    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='guardians')
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    relationship = models.CharField(max_length=50)  # Father, Mother, Guardian, etc.
    phone = models.CharField(max_length=20)
    email = models.EmailField()
    occupation = models.CharField(max_length=100, blank=True)
    address = models.TextField(blank=True)
    is_primary_contact = models.BooleanField(default=False)
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.relationship})"

    class Meta:
        db_table = 'students_guardian'
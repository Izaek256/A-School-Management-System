from django.db import models
from core.models import TenantModel


class AcademicYear(TenantModel):
    """
    Model representing an academic year.
    """
    name = models.CharField(max_length=100)
    start_date = models.DateField()
    end_date = models.DateField()
    is_current = models.BooleanField(default=False)
    
    def __str__(self):
        return self.name

    class Meta(TenantModel.Meta):
        db_table = 'academics_academic_year'


class Class(TenantModel):
    """
    Model representing a class/grade in school.
    """
    name = models.CharField(max_length=100)  # e.g., "Class 1", "Grade 10"
    section = models.CharField(max_length=50, blank=True)  # e.g., "A", "B"
    class_teacher = models.ForeignKey('teachers.Teacher', on_delete=models.SET_NULL, null=True, blank=True)
    academic_year = models.ForeignKey(AcademicYear, on_delete=models.CASCADE)
    capacity = models.PositiveIntegerField(default=0)
    
    def __str__(self):
        section_str = f" - {self.section}" if self.section else ""
        return f"{self.name}{section_str}"

    class Meta(TenantModel.Meta):
        db_table = 'academics_class'
        unique_together = ['school', 'name', 'section', 'academic_year']


class Subject(TenantModel):
    """
    Model representing a subject taught in school.
    """
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=20, unique=True)
    description = models.TextField(blank=True)
    class_assigned = models.ManyToManyField(Class, blank=True, related_name='subjects')
    teacher = models.ForeignKey('teachers.Teacher', on_delete=models.SET_NULL, null=True, blank=True, related_name='subjects')
    credit_hours = models.DecimalField(max_digits=3, decimal_places=1, default=1.0)
    
    def __str__(self):
        return f"{self.name} ({self.code})"

    class Meta(TenantModel.Meta):
        db_table = 'academics_subject'


class Enrollment(TenantModel):
    """
    Model representing student enrollment in a class.
    """
    student = models.ForeignKey('students.Student', on_delete=models.CASCADE)
    class_enrolled = models.ForeignKey(Class, on_delete=models.CASCADE)
    enrollment_date = models.DateField(auto_now_add=True)
    academic_year = models.ForeignKey(AcademicYear, on_delete=models.CASCADE)
    
    def __str__(self):
        return f"{self.student} enrolled in {self.class_enrolled}"

    class Meta(TenantModel.Meta):
        db_table = 'academics_enrollment'
        unique_together = ['school', 'student', 'class_enrolled', 'academic_year']


class Attendance(TenantModel):
    """
    Model representing student attendance records.
    """
    ATTENDANCE_STATUS_CHOICES = [
        ('present', 'Present'),
        ('absent', 'Absent'),
        ('late', 'Late'),
        ('excused', 'Excused'),
    ]
    
    student = models.ForeignKey('students.Student', on_delete=models.CASCADE)
    class_attended = models.ForeignKey(Class, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, null=True, blank=True)
    date = models.DateField()
    status = models.CharField(max_length=10, choices=ATTENDANCE_STATUS_CHOICES)
    remarks = models.TextField(blank=True)
    taken_by = models.ForeignKey('teachers.Teacher', on_delete=models.SET_NULL, null=True, blank=True)
    
    def __str__(self):
        return f"{self.student} - {self.date} - {self.status}"

    class Meta(TenantModel.Meta):
        db_table = 'academics_attendance'
        unique_together = ['school', 'student', 'class_attended', 'subject', 'date']


class Exam(TenantModel):
    """
    Model representing an exam.
    """
    EXAM_TYPE_CHOICES = [
        ('midterm', 'Midterm Exam'),
        ('final', 'Final Exam'),
        ('quiz', 'Quiz'),
        ('assignment', 'Assignment'),
        ('project', 'Project'),
    ]
    
    name = models.CharField(max_length=200)
    exam_type = models.CharField(max_length=20, choices=EXAM_TYPE_CHOICES)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    class_assigned = models.ForeignKey(Class, on_delete=models.CASCADE)
    date = models.DateField()
    start_time = models.TimeField()
    end_time = models.TimeField()
    max_marks = models.DecimalField(max_digits=5, decimal_places=2)
    passing_marks = models.DecimalField(max_digits=5, decimal_places=2)
    academic_year = models.ForeignKey(AcademicYear, on_delete=models.CASCADE)
    is_published = models.BooleanField(default=False)
    
    def __str__(self):
        return f"{self.name} - {self.subject}"

    class Meta(TenantModel.Meta):
        db_table = 'academics_exam'


class ExamResult(TenantModel):
    """
    Model representing exam results for students.
    """
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE)
    student = models.ForeignKey('students.Student', on_delete=models.CASCADE)
    marks_obtained = models.DecimalField(max_digits=5, decimal_places=2)
    grade = models.CharField(max_length=5, blank=True)
    remarks = models.TextField(blank=True)
    is_pass = models.BooleanField(default=False)
    
    def __str__(self):
        return f"{self.student} - {self.exam} - {self.marks_obtained}"

    class Meta(TenantModel.Meta):
        db_table = 'academics_exam_result'
        unique_together = ['school', 'exam', 'student']
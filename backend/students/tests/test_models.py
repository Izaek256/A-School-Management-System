from django.test import TestCase
from django.contrib.auth import get_user_model
from schools.models import School
from students.models import Student

User = get_user_model()

class StudentModelTest(TestCase):
    def setUp(self):
        self.school = School.objects.create(
            name="Test School",
            slug="test-school",
            email="test@testschool.com"
        )
        
        self.user = User.objects.create_user(
            username='teststudent',
            email='student@testschool.com',
            password='testpass123',
            role='student',
            school=self.school
        )
        
        self.student_data = {
            'user': self.user,
            'school': self.school,
            'student_id': 'STU001',
            'first_name': 'John',
            'last_name': 'Doe',
            'date_of_birth': '2005-01-01',
            'gender': 'male',
            'admission_date': '2020-09-01',
        }

    def test_student_creation(self):
        student = Student.objects.create(**self.student_data)
        self.assertEqual(student.student_id, 'STU001')
        self.assertEqual(student.first_name, 'John')
        self.assertEqual(student.last_name, 'Doe')
        self.assertEqual(str(student), 'John Doe (STU001)')
        self.assertEqual(student.user, self.user)
        self.assertEqual(student.school, self.school)

    def test_student_str_representation(self):
        student = Student.objects.create(**self.student_data)
        self.assertEqual(str(student), 'John Doe (STU001)')
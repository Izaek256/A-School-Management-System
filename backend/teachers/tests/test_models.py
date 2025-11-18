from django.test import TestCase
from django.contrib.auth import get_user_model
from schools.models import School
from teachers.models import Teacher

User = get_user_model()

class TeacherModelTest(TestCase):
    def setUp(self):
        self.school = School.objects.create(
            name="Test School",
            slug="test-school",
            email="test@testschool.com"
        )
        
        self.user = User.objects.create_user(
            username='testteacher',
            email='teacher@testschool.com',
            password='testpass123',
            role='teacher',
            school=self.school
        )
        
        self.teacher_data = {
            'user': self.user,
            'school': self.school,
            'employee_id': 'EMP001',
            'first_name': 'Jane',
            'last_name': 'Smith',
            'date_of_birth': '1980-01-01',
            'gender': 'female',
            'joining_date': '2010-09-01',
            'qualification': 'M.Ed',
            'department': 'Mathematics',
            'designation': 'Senior Teacher',
        }

    def test_teacher_creation(self):
        teacher = Teacher.objects.create(**self.teacher_data)
        self.assertEqual(teacher.employee_id, 'EMP001')
        self.assertEqual(teacher.first_name, 'Jane')
        self.assertEqual(teacher.last_name, 'Smith')
        self.assertEqual(teacher.user, self.user)
        self.assertEqual(teacher.school, self.school)
        self.assertEqual(teacher.qualification, 'M.Ed')
        self.assertEqual(teacher.department, 'Mathematics')
        self.assertEqual(teacher.designation, 'Senior Teacher')

    def test_teacher_str_representation(self):
        teacher = Teacher.objects.create(**self.teacher_data)
        self.assertEqual(str(teacher), 'Jane Smith (EMP001)')
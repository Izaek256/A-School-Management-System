from django.test import TestCase
from django.contrib.auth import get_user_model
from schools.models import School
from academics.models import AcademicYear, Class, Subject

User = get_user_model()

class AcademicModelTest(TestCase):
    def setUp(self):
        self.school = School.objects.create(
            name="Test School",
            slug="test-school",
            email="test@testschool.com"
        )
        
        self.academic_year_data = {
            'school': self.school,
            'name': '2023-2024',
            'start_date': '2023-09-01',
            'end_date': '2024-06-30',
            'is_current': True,
        }
        
        self.class_data = {
            'school': self.school,
            'name': 'Class 10',
            'section': 'A',
        }
        
        self.subject_data = {
            'school': self.school,
            'name': 'Mathematics',
            'code': 'MATH101',
        }

    def test_academic_year_creation(self):
        academic_year = AcademicYear.objects.create(**self.academic_year_data)
        self.assertEqual(academic_year.name, '2023-2024')
        self.assertEqual(academic_year.school, self.school)
        self.assertTrue(academic_year.is_current)

    def test_class_creation(self):
        academic_year = AcademicYear.objects.create(**self.academic_year_data)
        class_data = self.class_data.copy()
        class_data['academic_year'] = academic_year
        class_obj = Class.objects.create(**class_data)
        self.assertEqual(class_obj.name, 'Class 10')
        self.assertEqual(class_obj.section, 'A')
        self.assertEqual(class_obj.academic_year, academic_year)

    def test_subject_creation(self):
        subject = Subject.objects.create(**self.subject_data)
        self.assertEqual(subject.name, 'Mathematics')
        self.assertEqual(subject.code, 'MATH101')
        self.assertEqual(subject.school, self.school)
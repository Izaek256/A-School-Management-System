from django.test import TestCase
from django.contrib.auth import get_user_model
from schools.models import School

User = get_user_model()

class UserModelTest(TestCase):
    def setUp(self):
        self.school = School.objects.create(
            name="Test School",
            slug="test-school",
            email="test@testschool.com"
        )
        
        self.user_data = {
            'username': 'testuser',
            'email': 'test@example.com',
            'password': 'testpass123',
            'role': 'student',
            'school': self.school
        }

    def test_user_creation(self):
        user = User.objects.create_user(**self.user_data)
        self.assertEqual(user.username, 'testuser')
        self.assertEqual(user.email, 'test@example.com')
        self.assertEqual(user.role, 'student')
        self.assertEqual(user.school, self.school)
        self.assertTrue(user.is_active)
        self.assertFalse(user.is_staff)
        self.assertFalse(user.is_superuser)

    def test_superuser_creation(self):
        superuser = User.objects.create_superuser(
            username='admin',
            email='admin@example.com',
            password='adminpass123',
            role='admin',
            school=self.school
        )
        self.assertEqual(superuser.username, 'admin')
        self.assertTrue(superuser.is_active)
        self.assertTrue(superuser.is_staff)
        self.assertTrue(superuser.is_superuser)

    def test_user_str_representation(self):
        user = User.objects.create_user(**self.user_data)
        self.assertEqual(str(user), 'testuser (Student)')
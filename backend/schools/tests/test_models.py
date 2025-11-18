from django.test import TestCase
from schools.models import School

class SchoolModelTest(TestCase):
    def setUp(self):
        self.school_data = {
            'name': 'Test School',
            'slug': 'test-school',
            'email': 'test@testschool.com',
            'phone': '+1234567890',
            'address': '123 Test Street',
            'city': 'Test City',
            'state': 'Test State',
            'country': 'Test Country',
            'postal_code': '12345',
            'website': 'https://testschool.com',
            'is_verified': False,
            'subscription_plan': 'basic',
        }

    def test_school_creation(self):
        school = School.objects.create(**self.school_data)
        self.assertEqual(school.name, 'Test School')
        self.assertEqual(school.slug, 'test-school')
        self.assertEqual(school.email, 'test@testschool.com')
        self.assertEqual(school.phone, '+1234567890')
        self.assertEqual(school.address, '123 Test Street')
        self.assertEqual(school.city, 'Test City')
        self.assertEqual(school.state, 'Test State')
        self.assertEqual(school.country, 'Test Country')
        self.assertEqual(school.postal_code, '12345')
        self.assertEqual(school.website, 'https://testschool.com')
        self.assertFalse(school.is_verified)
        self.assertEqual(school.subscription_plan, 'basic')
        self.assertTrue(school.is_active)

    def test_school_str_representation(self):
        school = School.objects.create(**self.school_data)
        self.assertEqual(str(school), 'Test School')
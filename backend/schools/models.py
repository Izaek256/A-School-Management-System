from django.db import models
from core.models import BaseModel


class School(BaseModel):
    """
    Model representing a school (tenant) in the system.
    """
    name = models.CharField(max_length=255)
    slug = models.SlugField(unique=True)
    email = models.EmailField()
    phone = models.CharField(max_length=20, blank=True)
    address = models.TextField(blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=100, blank=True)
    country = models.CharField(max_length=100, blank=True)
    postal_code = models.CharField(max_length=20, blank=True)
    logo = models.URLField(blank=True)
    website = models.URLField(blank=True)
    is_verified = models.BooleanField(default=False)
    subscription_plan = models.CharField(max_length=50, blank=True)
    subscription_expiry = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'schools_school'
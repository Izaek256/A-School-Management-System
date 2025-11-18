from django.db import models
from django.utils import timezone


class BaseModel(models.Model):
    """
    Abstract base model that provides common fields for all models.
    """
    created_at = models.DateTimeField(default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        abstract = True


class TenantModel(BaseModel):
    """
    Abstract model that includes tenant (school) information.
    """
    school = models.ForeignKey('schools.School', on_delete=models.CASCADE)

    class Meta:
        abstract = True
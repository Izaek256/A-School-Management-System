from rest_framework import permissions


class IsAdmin(permissions.BasePermission):
    """
    Custom permission to only allow admin users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role == 'admin'


class IsTeacher(permissions.BasePermission):
    """
    Custom permission to only allow teacher users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role == 'teacher'


class IsStudent(permissions.BasePermission):
    """
    Custom permission to only allow student users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role == 'student'


class IsAccountant(permissions.BasePermission):
    """
    Custom permission to only allow accountant users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role == 'accountant'


class IsParent(permissions.BasePermission):
    """
    Custom permission to only allow parent users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role == 'parent'


class IsSchoolAdmin(permissions.BasePermission):
    """
    Custom permission to only allow school admin users.
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role in ['admin', 'accountant']


class IsStaff(permissions.BasePermission):
    """
    Custom permission to only allow staff users (teachers and admin).
    """
    
    def has_permission(self, request, view):
        return request.user and request.user.role in ['admin', 'teacher', 'accountant']


class IsOwnerOrAdmin(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object or admin users.
    """
    
    def has_object_permission(self, request, view, obj):
        # Admin can access everything
        if request.user.role == 'admin':
            return True
        
        # Check if user is the owner of the object
        if hasattr(obj, 'user'):
            return obj.user == request.user
        elif hasattr(obj, 'sender'):
            return obj.sender == request.user
        elif hasattr(obj, 'recipient'):
            return obj.recipient == request.user
        
        return False


class IsSchoolMember(permissions.BasePermission):
    """
    Custom permission to only allow members of the same school.
    """
    
    def has_object_permission(self, request, view, obj):
        # Admin can access everything
        if request.user.role == 'admin':
            return True
        
        # Check if user and object belong to the same school
        if hasattr(obj, 'school') and hasattr(request.user, 'school'):
            return obj.school == request.user.school
        
        return False
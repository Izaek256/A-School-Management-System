import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/views/auth/login_view.dart';
import 'package:frontend/views/auth/register_school_view.dart';
import 'package:frontend/views/auth/forgot_password_view.dart';
import 'package:frontend/views/dashboard/dashboard_view.dart';
import 'package:frontend/views/students/students_list_view.dart';
import 'package:frontend/views/students/student_profile_view.dart';
import 'package:frontend/views/teachers/teachers_list_view.dart';
import 'package:frontend/views/teachers/teacher_profile_view.dart';
import 'package:frontend/views/classes/classes_list_view.dart';
import 'package:frontend/views/classes/class_details_view.dart';
import 'package:frontend/views/exams/exams_list_view.dart';
import 'package:frontend/views/exams/create_exam_view.dart';
import 'package:frontend/views/exams/exam_results_view.dart';
import 'package:frontend/views/attendance/attendance_view.dart';
import 'package:frontend/views/finance/invoices_list_view.dart';
import 'package:frontend/views/finance/create_invoice_view.dart';
import 'package:frontend/views/finance/payment_history_view.dart';
import 'package:frontend/views/timetable/timetable_view.dart';
import 'package:frontend/views/assignments/assignments_list_view.dart';
import 'package:frontend/views/assignments/submit_assignment_view.dart';
import 'package:frontend/views/announcements/announcements_view.dart';
import 'package:frontend/views/notifications/notifications_view.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/register-school',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterSchoolView();
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordView();
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardView();
        },
      ),
      GoRoute(
        path: '/students',
        builder: (BuildContext context, GoRouterState state) {
          return const StudentsListView();
        },
      ),
      GoRoute(
        path: '/students/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id']!;
          return StudentProfileView(studentId: id);
        },
      ),
      GoRoute(
        path: '/teachers',
        builder: (BuildContext context, GoRouterState state) {
          return const TeachersListView();
        },
      ),
      GoRoute(
        path: '/teachers/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id']!;
          return TeacherProfileView(teacherId: id);
        },
      ),
      GoRoute(
        path: '/classes',
        builder: (BuildContext context, GoRouterState state) {
          return const ClassesListView();
        },
      ),
      GoRoute(
        path: '/classes/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id']!;
          return ClassDetailsView(classId: id);
        },
      ),
      GoRoute(
        path: '/exams',
        builder: (BuildContext context, GoRouterState state) {
          return const ExamsListView();
        },
      ),
      GoRoute(
        path: '/exams/create',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateExamView();
        },
      ),
      GoRoute(
        path: '/exams/:id/results',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id']!;
          return ExamResultsView(examId: id);
        },
      ),
      GoRoute(
        path: '/attendance',
        builder: (BuildContext context, GoRouterState state) {
          return const AttendanceView();
        },
      ),
      GoRoute(
        path: '/finance/invoices',
        builder: (BuildContext context, GoRouterState state) {
          return const InvoicesListView();
        },
      ),
      GoRoute(
        path: '/finance/invoices/create',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateInvoiceView();
        },
      ),
      GoRoute(
        path: '/finance/payments',
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentHistoryView();
        },
      ),
      GoRoute(
        path: '/timetable',
        builder: (BuildContext context, GoRouterState state) {
          return const TimetableView();
        },
      ),
      GoRoute(
        path: '/assignments',
        builder: (BuildContext context, GoRouterState state) {
          return const AssignmentsListView();
        },
      ),
      GoRoute(
        path: '/assignments/submit',
        builder: (BuildContext context, GoRouterState state) {
          return const SubmitAssignmentView();
        },
      ),
      GoRoute(
        path: '/announcements',
        builder: (BuildContext context, GoRouterState state) {
          return const AnnouncementsView();
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsView();
        },
      ),
    ],
  );
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/features/academic_info/views/academic_info.dart';
import 'package:lms/features/auth/views/login_page.dart';
import 'package:lms/features/auth/views/otp_screen.dart';
import 'package:lms/features/auth/views/sign_up_page.dart';
import 'package:lms/features/common/onboarding/onboarding_screen.dart';
import 'package:lms/features/common/splash/splash_screen.dart';
import 'package:lms/features/dashboard/dashboard.dart';
import 'package:lms/features/exam/views/exam_result_screen.dart';
import 'package:lms/features/exam/views/exam_screen.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:lms/features/message/views/message_screen.dart';
import 'package:lms/features/parent/models/child_model.dart';
import 'package:lms/features/parent/views/child_list_screen.dart';
import 'package:lms/features/parent/views/parent_view_progress_screen.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/features/profile/models/order_model/order_model.dart';
import 'package:lms/features/profile/views/widgets/add_or_update_address.dart';
import 'package:lms/features/profile/views/widgets/emergency_support.dart';
import 'package:lms/features/profile/views/widgets/faqs.dart';
import 'package:lms/features/profile/views/widgets/manage_address.dart';
import 'package:lms/features/profile/views/widgets/my_courses.dart';
import 'package:lms/features/profile/views/widgets/my_profile.dart';
import 'package:lms/features/profile/views/widgets/notification.dart';
import 'package:lms/features/profile/views/widgets/order_details.dart';
import 'package:lms/features/profile/views/widgets/order_history.dart';
import 'package:lms/features/purchase/views/basic_or_vip_subscription.dart';
import 'package:lms/features/purchase/views/single_subscription.dart';
import 'package:lms/features/quiz/models/quiz_result_model.dart';
import 'package:lms/features/quiz/views/quiz_result_screen.dart';
import 'package:lms/features/quiz/views/quiz_screen.dart';
import 'package:lms/features/semesters/models/chapter_model/exam.dart';
import 'package:lms/features/semesters/models/chapter_model/lesson.dart';
import 'package:lms/features/semesters/models/chapter_model/quiz.dart';
import 'package:lms/features/semesters/views/semester_screen.dart';
import 'package:lms/features/semesters/views/widgets/lessons_with_video_player.dart';
import 'package:lms/features/semesters/views/widgets/pdf_view.dart';
import 'package:lms/features/shop/views/shop_screen.dart';
import 'package:lms/features/shop/views/widgets/my_cart_screen.dart';
import 'package:lms/features/subjects/subject_based_teacher.dart';
import 'package:lms/features/subjects/subjects_list.dart';
import 'package:lms/features/teachers/views/teacher_screen.dart';
import 'package:lms/features/teachers/views/teachers_list.dart';
import 'package:lms/features/tour/tour_screen.dart';

class Routes {
  Routes._();
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const tour = '/tour';
  static const otpScreen = '/otp';
  static const academicInfo = '/academic-info';
  static const singleSubscription = '/single-subscription';
  static const basicOrVipSubscription = '/basic-or-vip-sub';
  static const dashboard = '/dashboard';
  static const teachers = '/teachers';
  static const teacherList = '/teacher-list';
  static const subjectList = '/subject-list';
  static const subjectBasedTeacher = '/subject-based-teacher';
  static const semester = '/semester';
  static const lessonVideoPlayer = '/lesson-video-player';
  static const messageScreen = '/messageScreen';
  static const shopScreen = '/shopScreen';
  static const myCart = '/myCart';
  static const pdfView = '/pdf-view';
  static const examScreen = '/examScreen';
  static const examResultScreen = '/examResultScreen';
  static const myProfile = '/myProfile';
  static const quizScreen = '/quizScreen';
  static const quizResultScreen = '/quizResultScreen';
  static const manageAddress = '/manageAddress';
  static const addOrUpdateAddress = '/addOrUpdateAddress';
  static const faqs = '/faqs';
  static const emergencySupport = '/emergencySupport';
  static const notification = '/notification';
  static const parentViewProgress = '/parentViewProgress';
  static const childList = '/childList';
  static const myCourses = '/myCourses';
  static const orderHistory = '/orderHistory';
  static const orderDetails = '/orderDetails';
}

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: Routes.splash,
    // redirect: (context, state) async {
    //   Box authBox = Hive.box(AppConstants.authBox);

    //   if (authBox.get(AppConstants.authToken) != null) {
    //     return Routes.dashboard;
    //   }
    //   return Routes.login;
    // },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SignUpScreen(
              isDataFilled: extra?['isDataFilled'] as bool,
              hasSocialData: extra?['hasSocialData'] as Map<String, dynamic>?);
        },
      ),
      GoRoute(
        path: Routes.tour,
        builder: (context, state) => const TourScreen(),
      ),
      GoRoute(
        path: Routes.otpScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OTPScreen(
            isParentLogin: extra?['isParentLogin'] as bool?,
            otpCode: extra?['otpCode'] as String,
            phoneNumber: extra?['phoneNumber'] as String,
          );
        },
      ),
      GoRoute(
        path: Routes.academicInfo,
        builder: (context, state) => const AcademicInfoScreen(),
      ),
      GoRoute(
        path: Routes.singleSubscription,
        builder: (context, state) => SingleSubscriptionScreen(
          course: state.extra as Course,
        ),
      ),
      GoRoute(
        path: Routes.basicOrVipSubscription,
        builder: (context, state) => BasicOrVipSubscriptionScreen(
          course: state.extra as Course?,
        ),
      ),
      GoRoute(
        path: Routes.dashboard,
        builder: (context, state) => Dashboard(),
      ),
      GoRoute(
        path: Routes.teachers,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return TeacherScreen(
            teacherId: extra['teacherId'] as int,
            isParentView: extra['isParentView'] as bool?,
          );
        },
      ),
      GoRoute(
        path: Routes.teacherList,
        builder: (context, state) => const TeachersList(),
      ),
      GoRoute(
        path: Routes.subjectList,
        builder: (context, state) => const SubjectsList(),
      ),
      GoRoute(
        path: Routes.subjectBasedTeacher,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SubjectBasedTeacher(
            subjectId: extra?['subjectId'] as int,
            subjectName: extra?['subjectName'] as String,
          );
        },
      ),
      GoRoute(
        path: Routes.semester,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return SemesterScreen(
            subjectName: extra['subjectName'],
            teacherName: extra['teacherName'],
            subjectId: extra['subjectId'],
            teacherId: extra['teacherId'],
          );
        },
        routes: [
          GoRoute(
            path: Routes.pdfView,
            builder: (context, state) {
              final extra = state.extra as String;
              return PDFViewer(url: extra);
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.lessonVideoPlayer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return LessonVideoPlayerScreen(
            semesterTitle: extra['semester_title'] as String,
            lessonList: extra['lessonList'] as List<Lesson>,
            chapterId: extra['chapterId'] as int,
            teacherId: extra['teacherId'] as int,
            subjectId: extra['subjectId'] as int,
            chapterTitle: extra['chapter_title'] as String,
            selectedPassLesson: extra['selectedPassLesson'] as Lesson?,
          );
        },
      ),
      GoRoute(
        path: Routes.messageScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final int teacherId = extra['teacherId'] as int;
          final SenderType senderType = extra['senderType'] as SenderType;
          return MessageScreen(
            teacherId: teacherId,
            senderType: senderType,
          );
        },
      ),
      GoRoute(
        path: Routes.shopScreen,
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: Routes.myCart,
        builder: (context, state) => const MyCartScreen(),
      ),
      GoRoute(
        path: Routes.examScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ExamScreen(
            examModel: state.extra as Exam,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation
                .drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: Routes.examResultScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ExamResultScreen(
            isFromChapter: state.extra as bool,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                  position: animation.drive(
                      Tween(begin: const Offset(1, 0), end: Offset.zero)),
                  child: child),
        ),
      ),
      GoRoute(
        path: Routes.quizScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: QuizScreen(
            quizModel: state.extra as Quiz,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation
                .drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: Routes.quizResultScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          return CustomTransitionPage(
            key: state.pageKey,
            child: QuizResultScreen(
              isFromChapter: extra?['isFromChapter'] as bool,
              result: extra?['result'] as QuizeResultModel,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero),
              ),
              child: child,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.myProfile,
        builder: (context, state) => const MyProfileScreen(),
      ),
      GoRoute(
        path: Routes.manageAddress,
        builder: (context, state) => const ManageAddressScreen(),
      ),
      GoRoute(
        path: Routes.addOrUpdateAddress,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return AddOrUpdateAddressScreen(
            addressModel: extra?['addressModel'] as AddressModel?,
            isUpdate: extra?['isUpdate'] as bool?,
          );
        },
      ),
      GoRoute(
        path: Routes.faqs,
        builder: (context, state) => const FAQSScreen(),
      ),
      GoRoute(
        path: Routes.emergencySupport,
        builder: (context, state) => const EmergencySupportScreen(),
      ),
      GoRoute(
        path: Routes.notification,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: Routes.parentViewProgress,
        builder: (context, state) => ParentViewProgressScreen(
          childList: state.extra as List<ChildModel>?,
        ),
      ),
      GoRoute(
        path: Routes.childList,
        builder: (context, state) => const ChildListScreen(),
      ),
      GoRoute(
        path: Routes.myCourses,
        builder: (context, state) => const MyCourses(),
      ),
      GoRoute(
        path: Routes.orderHistory,
        builder: (context, state) => const OrderHistory(),
      ),
      GoRoute(
        path: Routes.orderDetails,
        builder: (context, state) =>
            OrderDetails(orderModel: state.extra as OrderModel),
      ),
    ],
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log in to your account`
  String get loginToYrAccount {
    return Intl.message(
      'Log in to your account',
      name: 'loginToYrAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter credentials to access your account`
  String get enterCredentialsToA {
    return Intl.message(
      'Enter credentials to access your account',
      name: 'enterCredentialsToA',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message(
      'Student',
      name: 'student',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get parent {
    return Intl.message(
      'Parent',
      name: 'parent',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Or, login with`
  String get orloginwith {
    return Intl.message(
      'Or, login with',
      name: 'orloginwith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get registerNow {
    return Intl.message(
      'Register now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Tour`
  String get tour {
    return Intl.message(
      'Tour',
      name: 'tour',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Proceed Next`
  String get proceedNext {
    return Intl.message(
      'Proceed Next',
      name: 'proceedNext',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `We sent an OTP code to your phone number`
  String get weHaveSent {
    return Intl.message(
      'We sent an OTP code to your phone number',
      name: 'weHaveSent',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code below`
  String get enterCode {
    return Intl.message(
      'Enter the OTP code below',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Re-Send OTP in`
  String get reSendCode {
    return Intl.message(
      'Re-Send OTP in',
      name: 'reSendCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOTP {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOTP',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details to create an account`
  String get createAnAccount {
    return Intl.message(
      'Enter your details to create an account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Parent's Phone`
  String get parentPhone {
    return Intl.message(
      'Refferal\'s Phone',
      name: 'parentPhone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `I accept and agree to the`
  String get iAcceptAndAgree {
    return Intl.message(
      'I accept and agree to the',
      name: 'iAcceptAndAgree',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `of StudyMart`
  String get ofBridge {
    return Intl.message(
      'of StudyMart',
      name: 'ofBridge',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `How it works?`
  String get howItsWork {
    return Intl.message(
      'How it works?',
      name: 'howItsWork',
      desc: '',
      args: [],
    );
  }

  /// `See the video below`
  String get seeThevideo {
    return Intl.message(
      'See the video below',
      name: 'seeThevideo',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get createyourAccount {
    return Intl.message(
      'Create your account',
      name: 'createyourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to a Premium Plan`
  String get subscribeToPremiumPlan {
    return Intl.message(
      'Subscribe to a Premium Plan',
      name: 'subscribeToPremiumPlan',
      desc: '',
      args: [],
    );
  }

  /// `Study regularly, take quizzes and complete exams`
  String get studyRegularly {
    return Intl.message(
      'Study regularly, take quizzes and complete exams',
      name: 'studyRegularly',
      desc: '',
      args: [],
    );
  }

  /// `Finish your course and receive your certificate`
  String get finishYourCourse {
    return Intl.message(
      'Finish your course and receive your certificate',
      name: 'finishYourCourse',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Academic Info`
  String get academicInfo {
    return Intl.message(
      'Academic Info',
      name: 'academicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enter your academic information below`
  String get enterAcademicInfo {
    return Intl.message(
      'Enter your academic information below',
      name: 'enterAcademicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get grade {
    return Intl.message(
      'Grade',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `School Type`
  String get schoolType {
    return Intl.message(
      'School Type',
      name: 'schoolType',
      desc: '',
      args: [],
    );
  }

  /// `Choose Subject`
  String get chooseSub {
    return Intl.message(
      'Choose Subject',
      name: 'chooseSub',
      desc: '',
      args: [],
    );
  }

  /// `GAT`
  String get gat {
    return Intl.message(
      'GAT',
      name: 'gat',
      desc: '',
      args: [],
    );
  }

  /// `TOEFL`
  String get toefl {
    return Intl.message(
      'TOEFL',
      name: 'toefl',
      desc: '',
      args: [],
    );
  }

  /// `IELTS`
  String get ielts {
    return Intl.message(
      'IELTS',
      name: 'ielts',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to GAT Plan`
  String get subsToGatPlan {
    return Intl.message(
      'Subscribe to GAT Plan',
      name: 'subsToGatPlan',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the `
  String get welcomTo {
    return Intl.message(
      'Welcome to the ',
      name: 'welcomTo',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vip {
    return Intl.message(
      'VIP',
      name: 'vip',
      desc: '',
      args: [],
    );
  }

  /// ` Plan!`
  String get plan {
    return Intl.message(
      ' Plan!',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `You've successfully purchased and unlocked exclusive features.`
  String get youHaveSucc {
    return Intl.message(
      'You\'ve successfully purchased and unlocked exclusive features.',
      name: 'youHaveSucc',
      desc: '',
      args: [],
    );
  }

  /// `Explore VIP Features`
  String get exploreVip {
    return Intl.message(
      'Explore VIP Features',
      name: 'exploreVip',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `English School`
  String get englishSchool {
    return Intl.message(
      'English School',
      name: 'englishSchool',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message(
      'Subjects',
      name: 'subjects',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Best Teachers`
  String get bestTeacher {
    return Intl.message(
      'Best Teachers',
      name: 'bestTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Overall Progress`
  String get overAllProgress {
    return Intl.message(
      'Overall Progress',
      name: 'overAllProgress',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message(
      'Lesson',
      name: 'lesson',
      desc: '',
      args: [],
    );
  }

  /// `Exam`
  String get exam {
    return Intl.message(
      'Exam',
      name: 'exam',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `No Teacher Found`
  String get noTeacherFound {
    return Intl.message(
      'No Teacher Found',
      name: 'noTeacherFound',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get viewProfile {
    return Intl.message(
      'View Profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Guest User`
  String get guestUser {
    return Intl.message(
      'Guest User',
      name: 'guestUser',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Manage Address`
  String get manageAddress {
    return Intl.message(
      'Manage Address',
      name: 'manageAddress',
      desc: '',
      args: [],
    );
  }

  /// `Support & legals`
  String get supportlegals {
    return Intl.message(
      'Support & legals',
      name: 'supportlegals',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Support`
  String get emergencySupport {
    return Intl.message(
      'Emergency Support',
      name: 'emergencySupport',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get fAQs {
    return Intl.message(
      'FAQs',
      name: 'fAQs',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Notebooks`
  String get notebooks {
    return Intl.message(
      'Notebooks',
      name: 'notebooks',
      desc: '',
      args: [],
    );
  }

  /// `Art & Craft Material`
  String get artCraftMaterial {
    return Intl.message(
      'Art & Craft Material',
      name: 'artCraftMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Stationery`
  String get stationery {
    return Intl.message(
      'Stationery',
      name: 'stationery',
      desc: '',
      args: [],
    );
  }

  /// `Please login to view progress`
  String get pleaselogintoviewprogress {
    return Intl.message(
      'Please login to view progress',
      name: 'pleaselogintoviewprogress',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get ext {
    return Intl.message(
      'Next',
      name: 'ext',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Your Online Learning Journey`
  String get welcometoYourOnlineLearningJourney {
    return Intl.message(
      'Welcome to Your Online Learning Journey',
      name: 'welcometoYourOnlineLearningJourney',
      desc: '',
      args: [],
    );
  }

  /// `Discover courses tailored to your needs and interests.`
  String get discovercoursestailoredtoyourneedsandinterests {
    return Intl.message(
      'Discover courses tailored to your needs and interests.',
      name: 'discovercoursestailoredtoyourneedsandinterests',
      desc: '',
      args: [],
    );
  }

  /// `Access Premium Study Resources`
  String get accessPremiumStudyResources {
    return Intl.message(
      'Access Premium Study Resources',
      name: 'accessPremiumStudyResources',
      desc: '',
      args: [],
    );
  }

  /// `Unlock exclusive content with our premium subscription.`
  String get unlockexclusivecontentwithourpremiumsubscription {
    return Intl.message(
      'Unlock exclusive content with our premium subscription.',
      name: 'unlockexclusivecontentwithourpremiumsubscription',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Progress & Achievements`
  String get trackYourProgressAchievements {
    return Intl.message(
      'Track Your Progress & Achievements',
      name: 'trackYourProgressAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Monitor your learning and celebrate your milestones.`
  String get monitoryourlearningandcelebrateyourmilestones {
    return Intl.message(
      'Monitor your learning and celebrate your milestones.',
      name: 'monitoryourlearningandcelebrateyourmilestones',
      desc: '',
      args: [],
    );
  }

  /// `Get Certificates for Completed Courses`
  String get getCertificatesforCompletedCourses {
    return Intl.message(
      'Get Certificates for Completed Courses',
      name: 'getCertificatesforCompletedCourses',
      desc: '',
      args: [],
    );
  }

  /// `Showcase your success with official course certificates.`
  String get showcaseyoursuccesswithofficialcoursecertificates {
    return Intl.message(
      'Showcase your success with official course certificates.',
      name: 'showcaseyoursuccesswithofficialcoursecertificates',
      desc: '',
      args: [],
    );
  }

  /// `No Course Found`
  String get noCourseFound {
    return Intl.message(
      'No Course Found',
      name: 'noCourseFound',
      desc: '',
      args: [],
    );
  }

  /// `This subject is not free`
  String get thissubjectisnotfree {
    return Intl.message(
      'This subject is not free',
      name: 'thissubjectisnotfree',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Ask Teacher`
  String get askTeacher {
    return Intl.message(
      'Ask Teacher',
      name: 'askTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Write your ask ...`
  String get writeyourask {
    return Intl.message(
      'Write your ask ...',
      name: 'writeyourask',
      desc: '',
      args: [],
    );
  }

  /// `Select a Profile`
  String get selectProfile {
    return Intl.message(
      'Select a Profile',
      name: 'selectProfile',
      desc: '',
      args: [],
    );
  }

  /// `Select your child's profile to view their academic progress`
  String get selectyourchildprofiletoviewtheiracademicprogress {
    return Intl.message(
      'Select your child\'s profile to view their academic progress',
      name: 'selectyourchildprofiletoviewtheiracademicprogress',
      desc: '',
      args: [],
    );
  }

  /// `Semester`
  String get sem {
    return Intl.message(
      'Semester',
      name: 'sem',
      desc: '',
      args: [],
    );
  }

  /// `Please choose an Plan`
  String get pleasechooseanPlan {
    return Intl.message(
      'Please choose an Plan',
      name: 'pleasechooseanPlan',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vIP {
    return Intl.message(
      'VIP',
      name: 'vIP',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Basic`
  String get basic {
    return Intl.message(
      'Basic',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to`
  String get subscribeTo {
    return Intl.message(
      'Subscribe to',
      name: 'subscribeTo',
      desc: '',
      args: [],
    );
  }

  /// `Back to Dashboard`
  String get backtoChapter {
    return Intl.message(
      'Back to Dashboard',
      name: 'backtoChapter',
      desc: '',
      args: [],
    );
  }

  /// `THANK YOU!`
  String get tHANKYOU {
    return Intl.message(
      'THANK YOU!',
      name: 'tHANKYOU',
      desc: '',
      args: [],
    );
  }

  /// `Here is the breakdown of your results:`
  String get hereisthebreakdownofyourresults {
    return Intl.message(
      'Here is the breakdown of your results:',
      name: 'hereisthebreakdownofyourresults',
      desc: '',
      args: [],
    );
  }

  /// `Total Questions`
  String get totalQuestions {
    return Intl.message(
      'Total Questions',
      name: 'totalQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Answered  Questions`
  String get answeredQuestions {
    return Intl.message(
      'Answered  Questions',
      name: 'answeredQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Skipped Questions`
  String get skippedQuestions {
    return Intl.message(
      'Skipped Questions',
      name: 'skippedQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect Answers`
  String get incorrectAnswers {
    return Intl.message(
      'Incorrect Answers',
      name: 'incorrectAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Are you Sure?`
  String get areyouSure {
    return Intl.message(
      'Are you Sure?',
      name: 'areyouSure',
      desc: '',
      args: [],
    );
  }

  /// `Want to exit from `
  String get wanttoexitfrom {
    return Intl.message(
      'Want to exit from ',
      name: 'wanttoexitfrom',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `You haven't reated yet`
  String get youhavenreatedyet {
    return Intl.message(
      'You haven\'t reated yet',
      name: 'youhavenreatedyet',
      desc: '',
      args: [],
    );
  }

  /// `Rate Now`
  String get rateNow {
    return Intl.message(
      'Rate Now',
      name: 'rateNow',
      desc: '',
      args: [],
    );
  }

  /// `No Semester Found`
  String get NoSemesterFound {
    return Intl.message(
      'No Semester Found',
      name: 'NoSemesterFound',
      desc: '',
      args: [],
    );
  }

  /// `This semester is locked`
  String get Thissemesterislocked {
    return Intl.message(
      'This semester is locked',
      name: 'Thissemesterislocked',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFound {
    return Intl.message(
      'No Data Found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `All Subjects`
  String get allSubjects {
    return Intl.message(
      'All Subjects',
      name: 'allSubjects',
      desc: '',
      args: [],
    );
  }

  /// `Teacher`
  String get teacher {
    return Intl.message(
      'Teacher',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `No Notification found`
  String get noNotificationfound {
    return Intl.message(
      'No Notification found',
      name: 'noNotificationfound',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Your Address`
  String get pleaseAddYourAddress {
    return Intl.message(
      'Please Add Your Address',
      name: 'pleaseAddYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `New Address`
  String get newAddress {
    return Intl.message(
      'New Address',
      name: 'newAddress',
      desc: '',
      args: [],
    );
  }

  /// `Need Help?`
  String get needHelp {
    return Intl.message(
      'Need Help?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `Contact Our Support Team Today!`
  String get contactOurSupportTeamToday {
    return Intl.message(
      'Contact Our Support Team Today!',
      name: 'contactOurSupportTeamToday',
      desc: '',
      args: [],
    );
  }

  /// `Purpose`
  String get purpose {
    return Intl.message(
      'Purpose',
      name: 'purpose',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here`
  String get writeyourmessagehere {
    return Intl.message(
      'Write your message here',
      name: 'writeyourmessagehere',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Your message has been sent successfully`
  String get yourmessagehasbeensentsuccessfully {
    return Intl.message(
      'Your message has been sent successfully',
      name: 'yourmessagehasbeensentsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `or contact us at: `
  String get orcontactusat {
    return Intl.message(
      'or contact us at: ',
      name: 'orcontactusat',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Search By Subject`
  String get searchBySub {
    return Intl.message(
      'Search By Subject',
      name: 'searchBySub',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSure {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addtoCart {
    return Intl.message(
      'Add to Cart',
      name: 'addtoCart',
      desc: '',
      args: [],
    );
  }

  /// `Select Quantity`
  String get selectQty {
    return Intl.message(
      'Select Quantity',
      name: 'selectQty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `All Teachers`
  String get allTeachers {
    return Intl.message(
      'All Teachers',
      name: 'allTeachers',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Features`
  String get features {
    return Intl.message(
      'Features',
      name: 'features',
      desc: '',
      args: [],
    );
  }

  /// `Update Address`
  String get updateAddress {
    return Intl.message(
      'Update Address',
      name: 'updateAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message(
      'Add Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Complete Profile`
  String get complete_profile {
    return Intl.message(
      'Complete Profile',
      name: 'complete_profile',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the terms and conditions`
  String get pleaseAccept {
    return Intl.message(
      'Please accept the terms and conditions',
      name: 'pleaseAccept',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password do not match`
  String get passwordDoNotMatch {
    return Intl.message(
      'Password do not match',
      name: 'passwordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `My Courses`
  String get myCourses {
    return Intl.message(
      'My Courses',
      name: 'myCourses',
      desc: '',
      args: [],
    );
  }

  /// `No Course Purchase yet!`
  String get noCoursePurchase {
    return Intl.message(
      'No Course Purchase yet!',
      name: 'noCoursePurchase',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get order_history {
    return Intl.message(
      'Order History',
      name: 'order_history',
      desc: '',
      args: [],
    );
  }

  /// `Order Not Found`
  String get orderNotFound {
    return Intl.message(
      'Order Not Found',
      name: 'orderNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Total Items`
  String get totalItems {
    return Intl.message(
      'Total Items',
      name: 'totalItems',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `No Item Found`
  String get noItemFound {
    return Intl.message(
      'No Item Found',
      name: 'noItemFound',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Payable Amount`
  String get payableAmount {
    return Intl.message(
      'Payable Amount',
      name: 'payableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge`
  String get deliveryCharge {
    return Intl.message(
      'Delivery Charge',
      name: 'deliveryCharge',
      desc: '',
      args: [],
    );
  }

  /// `How was the course?`
  String get howWasTheCourse {
    return Intl.message(
      'How was the course?',
      name: 'howWasTheCourse',
      desc: '',
      args: [],
    );
  }

  /// `Write about what you have learned from this course and inspire others.`
  String get writeAboutWhat {
    return Intl.message(
      'Write about what you have learned from this course and inspire others.',
      name: 'writeAboutWhat',
      desc: '',
      args: [],
    );
  }

  /// `Write here...`
  String get writeHere {
    return Intl.message(
      'Write here...',
      name: 'writeHere',
      desc: '',
      args: [],
    );
  }

  /// `Enter some text`
  String get enterSomeTxt {
    return Intl.message(
      'Enter some text',
      name: 'enterSomeTxt',
      desc: '',
      args: [],
    );
  }

  /// `Your have successfully rated this teacher`
  String get successFullyAdd {
    return Intl.message(
      'Your have successfully rated this teacher',
      name: 'successFullyAdd',
      desc: '',
      args: [],
    );
  }

  /// `Students`
  String get students {
    return Intl.message(
      'Students',
      name: 'students',
      desc: '',
      args: [],
    );
  }

  /// `About Teacher`
  String get aboutTeacher {
    return Intl.message(
      'About Teacher',
      name: 'aboutTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Joined`
  String get joined {
    return Intl.message(
      'Joined',
      name: 'joined',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get readMore {
    return Intl.message(
      'Read More',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Reviews`
  String get ratingAndReviews {
    return Intl.message(
      'Rating & Reviews',
      name: 'ratingAndReviews',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get selectCity {
    return Intl.message(
      'Select City',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Select Area`
  String get selectArea {
    return Intl.message(
      'Select Area',
      name: 'selectArea',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get block {
    return Intl.message(
      'Block',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `House No`
  String get houseNo {
    return Intl.message(
      'House No',
      name: 'houseNo',
      desc: '',
      args: [],
    );
  }

  /// `Avenue`
  String get avenue {
    return Intl.message(
      'Avenue',
      name: 'avenue',
      desc: '',
      args: [],
    );
  }

  /// `Address Line`
  String get addressLine {
    return Intl.message(
      'Address Line',
      name: 'addressLine',
      desc: '',
      args: [],
    );
  }

  /// `Address Tag`
  String get addressTag {
    return Intl.message(
      'Address Tag',
      name: 'addressTag',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Make this ID default address`
  String get makeIdDefaultAddress {
    return Intl.message(
      'Make this ID default address',
      name: 'makeIdDefaultAddress',
      desc: '',
      args: [],
    );
  }

  /// `Delete this`
  String get deleteThis {
    return Intl.message(
      'Delete this',
      name: 'deleteThis',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Address stored successfully`
  String get addressStoredSuccessfully {
    return Intl.message(
      'Address stored successfully',
      name: 'addressStoredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `No Quiz Available`
  String get noQuizAvailable {
    return Intl.message(
      'No Quiz Available',
      name: 'noQuizAvailable',
      desc: '',
      args: [],
    );
  }

  /// `You have completed the Semester`
  String get youHaveComplete {
    return Intl.message(
      'You have completed the Semester',
      name: 'youHaveComplete',
      desc: '',
      args: [],
    );
  }

  /// `Back to Dashboard`
  String get backToDashboard {
    return Intl.message(
      'Back to Dashboard',
      name: 'backToDashboard',
      desc: '',
      args: [],
    );
  }

  /// `You achieved`
  String get youAchive {
    return Intl.message(
      'You achieved',
      name: 'youAchive',
      desc: '',
      args: [],
    );
  }

  /// `Out of`
  String get outOf {
    return Intl.message(
      'Out of',
      name: 'outOf',
      desc: '',
      args: [],
    );
  }

  /// `Marks`
  String get marks {
    return Intl.message(
      'Marks',
      name: 'marks',
      desc: '',
      args: [],
    );
  }

  /// `Open File`
  String get openFile {
    return Intl.message(
      'Open File',
      name: 'openFile',
      desc: '',
      args: [],
    );
  }

  /// `Downloading...`
  String get downloading {
    return Intl.message(
      'Downloading...',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Download`
  String get tapToDownload {
    return Intl.message(
      'Tap to Download',
      name: 'tapToDownload',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get selectAddress {
    return Intl.message(
      'Select Address',
      name: 'selectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNew {
    return Intl.message(
      'Add New',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `No Chapter Found`
  String get noChapterFound {
    return Intl.message(
      'No Chapter Found',
      name: 'noChapterFound',
      desc: '',
      args: [],
    );
  }

  /// `Start Exam`
  String get startExam {
    return Intl.message(
      'Start Exam',
      name: 'startExam',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Exam`
  String get startYourExam {
    return Intl.message(
      'Start Your Exam',
      name: 'startYourExam',
      desc: '',
      args: [],
    );
  }

  /// `Number of Questions`
  String get nmbrOfQuestions {
    return Intl.message(
      'Number of Questions',
      name: 'nmbrOfQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Question Type`
  String get questionType {
    return Intl.message(
      'Question Type',
      name: 'questionType',
      desc: '',
      args: [],
    );
  }

  /// `MCQ`
  String get mcq {
    return Intl.message(
      'MCQ',
      name: 'mcq',
      desc: '',
      args: [],
    );
  }

  /// `Total Mark`
  String get totalMark {
    return Intl.message(
      'Total Mark',
      name: 'totalMark',
      desc: '',
      args: [],
    );
  }

  /// `Exam Duration`
  String get examDuration {
    return Intl.message(
      'Exam Duration',
      name: 'examDuration',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Ensure you have a stable internet connection.`
  String get ensureYouHave {
    return Intl.message(
      'Ensure you have a stable internet connection.',
      name: 'ensureYouHave',
      desc: '',
      args: [],
    );
  }

  /// `Carefully read each question before submiting your answer.`
  String get carefullyRead {
    return Intl.message(
      'Carefully read each question before submiting your answer.',
      name: 'carefullyRead',
      desc: '',
      args: [],
    );
  }

  /// `Start Quiz`
  String get startQuiz {
    return Intl.message(
      'Start Quiz',
      name: 'startQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Quiz`
  String get startYourQuiz {
    return Intl.message(
      'Start Your Quiz',
      name: 'startYourQuiz',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Your Certificate is ready.`
  String get yourCertificate {
    return Intl.message(
      'Your Certificate is ready.',
      name: 'yourCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Loacation`
  String get addYourLocation {
    return Intl.message(
      'Add Your Loacation',
      name: 'addYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully`
  String get orderPlaceSuccessFully {
    return Intl.message(
      'Order placed successfully',
      name: 'orderPlaceSuccessFully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please add address`
  String get pleaseAddAddress {
    return Intl.message(
      'Please add address',
      name: 'pleaseAddAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please add items to cart`
  String get pleaseAddItemCart {
    return Intl.message(
      'Please add items to cart',
      name: 'pleaseAddItemCart',
      desc: '',
      args: [],
    );
  }

  /// `Default Address`
  String get defaultAddress {
    return Intl.message(
      'Default Address',
      name: 'defaultAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to Delete the address?`
  String get areYouSureDeleteAddress {
    return Intl.message(
      'Are you sure you want to Delete the address?',
      name: 'areYouSureDeleteAddress',
      desc: '',
      args: [],
    );
  }

  /// `Delete Successfully`
  String get deleteSuccessfully {
    return Intl.message(
      'Delete Successfully',
      name: 'deleteSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `No Exam Available`
  String get noExamAvailable {
    return Intl.message(
      'No Exam Available',
      name: 'noExamAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Time`
  String get remainigTime {
    return Intl.message(
      'Remaining Time',
      name: 'remainigTime',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get ofT {
    return Intl.message(
      'of',
      name: 'ofT',
      desc: '',
      args: [],
    );
  }

  /// `Do You Really Want To Download This Certificate?`
  String get areYouSureToDownload {
    return Intl.message(
      'Do You Really Want To Download This Certificate?',
      name: 'areYouSureToDownload',
      desc: '',
      args: [],
    );
  }

  /// `Quiz Result`
  String get quizeResult {
    return Intl.message(
      'Quiz Result',
      name: 'quizeResult',
      desc: '',
      args: [],
    );
  }

  /// `Exam Result`
  String get examResult {
    return Intl.message(
      'Exam Result',
      name: 'examResult',
      desc: '',
      args: [],
    );
  }

  /// `Certificate`
  String get certificate {
    return Intl.message(
      'Certificate',
      name: 'certificate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

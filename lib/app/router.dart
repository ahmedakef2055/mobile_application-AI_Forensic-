import 'package:go_router/go_router.dart';
import '../features/splash/splash_page.dart';
import '../features/auth/login_page_new.dart';
import '../features/auth/signup_page.dart';
import '../features/auth/forgot_password_page.dart';
import '../features/alerts/security_alerts_page.dart';
import '../features/incidents/incident_detail_page.dart';
import '../features/home/home_navigation_wrapper.dart';
import '../features/home/security_dashboard_home_page.dart';
import '../features/profile/profile_settings_page.dart';
import '../features/splash/signing_out_splash_page.dart';
import '../features/incidents/incidents_page.dart';
import '../features/alerts/alerts_page.dart';
import '../features/profile/profile_page.dart';
import '../features/settings/settings_page.dart';
import '../features/notifications/notifications_page.dart';
import '../features/onboarding/onboarding_page.dart';

final appRouter = GoRouter(
  initialLocation: SplashPage.routePath,
  routes: [
    GoRoute(
      path: SplashPage.routePath,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: OnboardingPage.routePath,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: LoginPage.routePath,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: SignupPage.routePath,
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: ForgotPasswordPage.routePath,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: HomeNavigationWrapper.routePath,
      builder: (context, state) => const HomeNavigationWrapper(),
    ),
    GoRoute(
      path: SecurityDashboardHomePage.routePath,
      builder: (context, state) => const SecurityDashboardHomePage(),
    ),
    GoRoute(
      path: SecurityAlertsPage.routePath,
      builder: (context, state) => const SecurityAlertsPage(),
    ),
    GoRoute(
      path: IncidentDetailPage.routePath,
      builder: (context, state) => const IncidentDetailPage(),
    ),
    GoRoute(
      path: ProfileSettingsPage.routePath,
      builder: (context, state) => const ProfileSettingsPage(),
    ),
    GoRoute(
      path: SigningOutSplashPage.routePath,
      builder: (context, state) => const SigningOutSplashPage(),
    ),
    GoRoute(
      path: IncidentsPage.routePath,
      builder: (context, state) => const IncidentsPage(),
    ),
    GoRoute(
      path: AlertsPage.routePath,
      builder: (context, state) => const AlertsPage(),
    ),
    GoRoute(
      path: ProfilePage.routePath,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: SettingsPage.routePath,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: NotificationsPage.routePath,
      builder: (context, state) => const NotificationsPage(),
    ),
  ],
);
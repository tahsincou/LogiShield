import 'package:go_router/go_router.dart';
import 'package:logishield/features/auth/presentaion/pages/login_page.dart';
import 'package:logishield/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:logishield/features/logistics/parcel/domain/entities/parcel.dart';
import 'package:logishield/features/logistics/parcel/presentation/pages/parcel_details_page.dart';
import 'package:logishield/features/logistics/parcel/presentation/pages/parcel_page.dart';
import 'package:logishield/features/settings/settings_page.dart';
import 'package:logishield/features/splash/presentation/pages/splash_page.dart';

import '../../features/logistics/parcel/presentation/pages/parcel_form_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardPage()),
      GoRoute(path: '/parcels', builder: (_, __) => const ParcelPage()),
      GoRoute(
        path: '/parcel-details',
        builder: (_, state) {
          return ParcelDetailsPage(parcel: state.extra as Parcel);
        },
      ),
      GoRoute(
        path: '/create-parcel',
        builder: (_, __) => const ParcelFormPage(),
      ),
      GoRoute(
        path: '/edit-parcel',
        builder: (_, state) {
          return ParcelFormPage(parcel: state.extra as Parcel);
        },
      ),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
    ],
  );
}

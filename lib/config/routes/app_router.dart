import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/start_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/matches/presentation/screens/matches_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/chat/presentation/screens/chat_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../shared/widgets/custom_bottom_nav.dart';

/// App router configuration using GoRouter
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/start',
    routes: [
      // Auth routes
      GoRoute(
        path: '/start',
        name: 'start',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const StartScreen(),
        ),
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const SignInScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const SignUpScreen(),
        ),
      ),
      // Main app routes with bottom navigation
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const _MainScaffold(currentIndex: 0, child: HomeScreen()),
        ),
      ),
      GoRoute(
        path: '/matches',
        name: 'matches',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const _MainScaffold(currentIndex: 1, child: MatchesScreen()),
        ),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const _MainScaffold(currentIndex: 2, child: ChatListScreen()),
        ),
      ),
      GoRoute(
        path: '/chat/:userId',
        name: 'chatDetail',
        pageBuilder: (context, state) {
          final userId = state.pathParameters['userId']!;
          final extra = state.extra as Map<String, dynamic>?;
          final userName = extra?['userName'] as String? ?? 'Utilisateur';
          final userPhotoUrl = extra?['userPhotoUrl'] as String? ?? '';
          
          return _buildPageWithSlideTransition(
            context,
            state,
            ChatDetailScreen(
              userId: userId,
              userName: userName,
              userPhotoUrl: userPhotoUrl,
            ),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const _MainScaffold(currentIndex: 3, child: ProfileScreen()),
        ),
      ),
    ],
    // Error page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );

  /// Custom slide transition for route navigation
  static CustomTransitionPage _buildPageWithSlideTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide from right to left animation
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 150),
    );
  }
}

/// Main scaffold with bottom navigation
class _MainScaffold extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const _MainScaffold({
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNav(currentIndex: currentIndex),
    );
  }
}

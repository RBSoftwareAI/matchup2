import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/matches/presentation/providers/matches_provider.dart';
import 'features/profile/presentation/providers/profile_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

void main() {
  runApp(const MyApp());
}

/// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MatchesProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp.router(
        title: 'MatchUp',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

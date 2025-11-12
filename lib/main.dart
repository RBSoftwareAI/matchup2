import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/home/presentation/providers/home_provider.dart';

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

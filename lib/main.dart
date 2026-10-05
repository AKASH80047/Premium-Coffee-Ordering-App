import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme.dart';
import 'screens/splash_screen.dart';

import 'core/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BreworaState().init();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BreworaApp());
}

class BreworaApp extends StatelessWidget {
  const BreworaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: BreworaState(),
      builder: (context, _) {
        return MaterialApp(
          title: 'Brewora',
          debugShowCheckedModeBanner: false,
          themeMode: BreworaState().isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'state/app_state.dart';

void main() {
  runApp(const TahminLigiApp());
}

class TahminLigiApp extends StatelessWidget {
  const TahminLigiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Tahmin Ligi',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            supportedLocales: const [Locale('tr'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: _lightTheme,
            darkTheme: _darkTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

/// "Sahil Yeşili" — aydınlık mod paleti. Krem zemin, tek koyu yeşil vurgu.
final ThemeData _lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF6F4EC),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1F4D3A),
    onPrimary: Colors.white,
    secondary: Color(0xFF1F4D3A),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE6EDE7),
    onSecondaryContainer: Color(0xFF1F4D3A),
    surface: Colors.white,
    onSurface: Color(0xFF1C2620),
    onSurfaceVariant: Color(0xFF6B7268),
    outline: Color(0xFFE3DFCF),
    surfaceContainerHighest: Color(0xFFEDE9DB),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: Color(0xFFE3DFCF)),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: const Color(0xFFE6EDE7),
    surfaceTintColor: Colors.transparent,
  ),
);

/// "Gece Modu" — karanlık mod paleti. Antrasit zemin, tek turkuaz vurgu.
final ThemeData _darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF12161C),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF2FB8A6),
    onPrimary: Color(0xFF0D1613),
    secondary: Color(0xFF2FB8A6),
    onSecondary: Color(0xFF0D1613),
    secondaryContainer: Color(0xFF1E2B29),
    onSecondaryContainer: Color(0xFF4FD6C4),
    surface: Color(0xFF1B2129),
    onSurface: Color(0xFFEDEFF2),
    onSurfaceVariant: Color(0xFF8C94A0),
    outline: Color(0xFF262D37),
    surfaceContainerHighest: Color(0xFF1E2530),
  ),
  cardTheme: const CardThemeData(
    color: Color(0xFF1B2129),
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: Color(0xFF262D37)),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: const Color(0xFF161B22),
    indicatorColor: const Color(0xFF1E2B29),
    surfaceTintColor: Colors.transparent,
  ),
);

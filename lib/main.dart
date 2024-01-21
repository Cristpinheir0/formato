import 'package:flutter/material.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/pages/home_page.dart';
import 'package:formato/pages/shared/themes/color_schemes.g.dart';

void main() {
  setUpInjetorDependencia();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.primary,
        appBarTheme: AppBarTheme(color: lightColorScheme.primary),
        bottomAppBarTheme: BottomAppBarTheme(color: lightColorScheme.primary),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.primary,
        bottomAppBarTheme: BottomAppBarTheme(color: darkColorScheme.primary),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(currentPageIndex: 1),
    );
  }
}

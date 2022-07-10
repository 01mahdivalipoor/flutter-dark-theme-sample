import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<AppThemeProvider>(context);
        return MaterialApp(
          title: 'Flutter App',
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          //TODO: Homepage Scaffold
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AppThemeChanger(),
                  Text('Theme switch'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

///Theme provider
class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isActive) {
    themeMode = isActive ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

///Theme Switcher
class AppThemeChanger extends StatelessWidget {
  const AppThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<AppThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}

class AppTheme {
  ///Light Theme
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
  );

  ///Dark Theme
  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}

import 'package:flutter/material.dart';

// =======================================================
// DATA THEME
// =======================================================
class AppTheme {
  bool isDarkMode = false;

  ThemeData get themeData {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor:
          isDarkMode ? Colors.grey[900]! : Colors.grey[100]!,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

// =======================================================
// INHERITED WIDGET UNTUK THEME
// =======================================================
class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme appTheme;
  final VoidCallback toggleTheme;

  const ThemeInheritedWidget({
    super.key,
    required this.appTheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return appTheme.isDarkMode != oldWidget.appTheme.isDarkMode;
  }
}

// =======================================================
// APLIKASI UTAMA
// =======================================================
class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  final AppTheme appTheme = AppTheme();

  void toggleTheme() {
    setState(() {
      appTheme.isDarkMode = !appTheme.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      appTheme: appTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 🔹 Hilangkan tulisan "debug"
        title: 'Login & Register App',
        theme: appTheme.themeData,
        home: const LoginScreen(), // 🔹 Halaman pertama: Login
        routes: {
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}

void main() {
  runApp(const ThemeApp());
}

// =======================================================
// LOGIN SCREEN
// =======================================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context)!.appTheme;
    final toggle = ThemeInheritedWidget.of(context)!.toggleTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        actions: [
          IconButton(
            icon: Icon(
              theme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: toggle,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Back!',
                  style: TextStyle(
                      fontSize: 26,
                      color: theme.textColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // login logic nanti di sini
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Belum punya akun? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// REGISTER SCREEN (ADMIN INPUT)
// =======================================================
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context)!.appTheme;
    final toggle = ThemeInheritedWidget.of(context)!.toggleTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page (Admin)'),
        actions: [
          IconButton(
            icon: Icon(
              theme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: toggle,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Admin Register',
                  style: TextStyle(
                      fontSize: 26,
                      color: theme.textColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

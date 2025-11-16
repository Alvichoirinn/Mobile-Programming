import 'package:flutter/material.dart';

void main() {
  runApp(ThemeApp());
}

// Data Theme, class berikut digunakan untuk mengatur tema aplikasi
class AppTheme {
  bool isDarkMode = false;

  ThemeData get themeData {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

// Inherited widget untuk theme digunakan untuk menyediakan akses global ke tema aplikasi
class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme apptheme;
  final VoidCallback toggleTheme;

  ThemeInheritedWidget({
    required this.apptheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }

  @override // digunakan untuk menentukan kapan widget turunannya perlu dibangun ulang
  bool updateShouldNotify(covariant ThemeInheritedWidget oldWidget) {
    return oldWidget.apptheme.isDarkMode != apptheme.isDarkMode;
  }
}

// Aplikasi utama digunakan untuk menginisialisasi dan menjalankan aplikasi Flutter
class ThemeApp extends StatefulWidget {
  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  AppTheme appTheme = AppTheme();

  void toggleTheme() {
    setState(() {
      appTheme.isDarkMode = !appTheme.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      apptheme: appTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        theme: appTheme.themeData,
        home: FirstScreen(),
        routes: {'/second': (context) => SecondScreen()},
      ),
    );
  }
}

// Screen Pertama
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
        actions: [
          IconButton(
            icon: Icon(
              themeInherited?.apptheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeInherited?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        color: themeInherited?.apptheme.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Screen Pertama',
                style: TextStyle(
                  fontSize: 24,
                  color: themeInherited?.apptheme.textColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                themeInherited?.apptheme.isDarkMode == true
                    ? 'Mode Gelap'
                    : 'Mode Terang',
                style: TextStyle(color: themeInherited?.apptheme.textColor),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text('Pergi ke Screen 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen Kedua
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        actions: [
          IconButton(
            icon: Icon(
              themeInherited?.apptheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeInherited?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        color: themeInherited?.apptheme.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Screen Kedua',
                style: TextStyle(
                  fontSize: 24,
                  color: themeInherited?.apptheme.textColor,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Theme sama di semua screen',
                style: TextStyle(color: themeInherited?.apptheme.textColor),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kembali ke Screen 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

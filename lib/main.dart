import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chess_learning_page.dart';
import 'screens/chess_list_screen.dart';
import 'screens/chess_edit_screen.dart';
import 'providers/chess_provider.dart';

void main() {
  runApp(const ChessApp());
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChessProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chess Hub',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Color(0xFFD4AF37),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomePage(),
          ChessListScreen.routeName: (ctx) => const ChessListScreen(),
          ChessEditScreen.routeName: (ctx) => const ChessEditScreen(),
          '/learning': (ctx) => ChessLearningPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ใช้ Text แทน Icon สำหรับ Chess Symbol
                const Text(
                  '♛',
                  style: TextStyle(fontSize: 80, color: Color(0xFFD4AF37)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Chess Hub',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: const Icon(Icons.collections),
                  label: const Text(
                    'Chess Collection',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ChessListScreen.routeName);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.school),
                  label: const Text(
                    'Chess Learning Mode',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/learning');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


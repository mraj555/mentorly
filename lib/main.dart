import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorly/providers/class_provider.dart';
import 'package:mentorly/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClassProvider(),
      child: MaterialApp(
        title: 'Mentorly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepOrangeAccent, brightness: .light),
          textTheme: GoogleFonts.interTextTheme(),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            elevation: 4,
            margin: .symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

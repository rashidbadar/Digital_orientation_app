// lib/screens/welcome_page.dart
import 'package:flutter/material.dart';
import 'smartkids_page.dart';
import 'readify_page.dart';
import 'abbasi_page.dart';
import 'aeri_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // List of series with title and page reference
  final List<Map<String, dynamic>> _series = [
    {"title": "SmartKids Series", "page": SmartKidsPage()},
    {"title": "Readify Series", "page": ReadifyPage()},
    {"title": "Abbasi Series", "page": AbbasiPage()},
    {"title": "AERI Series", "page": AeriPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _series
                .map(
                  (series) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ), // Full-width buttons
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => series['page']),
                        );
                      },
                      child: Text(series['title']),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

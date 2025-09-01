// lib/screens/welcome_page.dart
import 'package:flutter/material.dart';
import 'smartkids_page.dart';
import 'readify_page.dart';
import 'abbasi_page.dart';
import 'aeri_page.dart';
import 'repository_review.dart'; // ADD THIS IMPORT

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
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome header
              const Icon(Icons.school, size: 64, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Digital Orientation App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Select a series to explore:",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Series buttons
              Expanded(
                child: ListView(
                  children: _series
                      .map(
                        (series) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => series['page'],
                                ),
                              );
                            },
                            child: Text(series['title']),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),

      // ADD FLOATING ACTION BUTTON HERE
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RepositoryReviewScreen(),
            ),
          );
        },
        tooltip: 'View Code Analysis',
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        heroTag: "welcomeReviewFab",
        child: const Icon(Icons.analytics),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

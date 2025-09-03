import 'package:flutter/material.dart';
import 'smartkids_page.dart';
import 'readify_page.dart';
import 'abbasi_page.dart';
import 'aeri_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // List of series with title and page reference
  final List<Map<String, Widget>> _series = [
    {"title": const Text("SmartKids Series"), "page": SmartKidsPage()},
    {"title": const Text("Readify Series"), "page": ReadifyPage()},
    {"title": const Text("Abbasi Series"), "page": AbbasiPage()},
    {"title": const Text("AERI Series"), "page": AeriPage()},
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
        child: Column(
          children: [
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
            Expanded(
              child: ListView.builder(
                itemCount: _series.length,
                itemBuilder: (context, index) {
                  final series = _series[index];
                  return Padding(
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
                          MaterialPageRoute(builder: (_) => series['page']!),
                        );
                      },
                      child: series['title']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

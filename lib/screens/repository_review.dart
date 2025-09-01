import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryReviewScreen extends StatefulWidget {
  const RepositoryReviewScreen({super.key});

  @override
  State<RepositoryReviewScreen> createState() => _RepositoryReviewScreenState();
}

class _RepositoryReviewScreenState extends State<RepositoryReviewScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Review'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () => _launchURL(
              'https://github.com/rashidbadar/Digital_orientation_app.git',
            ),
            tooltip: 'Open Repository',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _getPage(_currentPageIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.assessment),
            label: 'Overview',
          ),
          NavigationDestination(icon: Icon(Icons.thumb_up), label: 'Strengths'),
          NavigationDestination(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Suggestions',
          ),
          NavigationDestination(icon: Icon(Icons.code), label: 'Code Examples'),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const OverviewPage();
      case 1:
        return const StrengthsPage();
      case 2:
        return const SuggestionsPage();
      case 3:
        return const CodeExamplesPage();
      default:
        return const OverviewPage();
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Repository Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Digital Orientation App is a Flutter application that appears to be an educational or onboarding tool with interactive elements.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Key Metrics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMetricItem('Dart Files', '15+', Icons.code),
                    _buildMetricItem('Dependencies', '10+', Icons.inventory),
                    _buildMetricItem('UI Screens', '5+', Icons.phone_android),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Initial Impressions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'The app has a good structure with separate directories for models, services, and widgets. The code follows a reasonable organization pattern, though there are opportunities for improvement in architecture and state management.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildMetricItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class StrengthsPage extends StatelessWidget {
  const StrengthsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildStrengthItem(
          'Good Project Structure',
          'The repository is well-organized with separate directories for different concerns (models, services, widgets).',
          Icons.folder,
        ),
        _buildStrengthItem(
          'Clean UI Implementation',
          'The user interface appears clean and follows Material Design principles in most places.',
          Icons.phone_android,
        ),
        _buildStrengthItem(
          'Package Selection',
          'Reasonable use of packages like http for API calls and others that fit the app requirements.',
          Icons.inventory,
        ),
        _buildStrengthItem(
          'Documentation',
          'The README provides basic information about the project, though it could be more detailed.',
          Icons.description,
        ),
        _buildStrengthItem(
          'Responsive Design',
          'The app seems to handle different screen sizes reasonably well.',
          Icons.screen_rotation,
        ),
      ],
    );
  }

  Widget _buildStrengthItem(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.green),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildSuggestionItem(
          'State Management',
          'Consider implementing a more robust state management solution like Provider, Bloc, or Riverpod for better scalability.',
          Icons.change_circle,
        ),
        _buildSuggestionItem(
          'Error Handling',
          'Add more comprehensive error handling, especially for API calls and user input validation.',
          Icons.warning,
        ),
        _buildSuggestionItem(
          'Code Documentation',
          'Add more comments and documentation to explain complex logic and improve code maintainability.',
          Icons.comment,
        ),
        _buildSuggestionItem(
          'Testing',
          'Include unit and widget tests to ensure code reliability and easier refactoring.',
          Icons.assignment_turned_in,
        ),
        _buildSuggestionItem(
          'Separation of Concerns',
          'Further separate business logic from UI components to improve testability and maintainability.',
          Icons.view_module,
        ),
        _buildSuggestionItem(
          'Constants Management',
          'Use a constants file or theme for consistent styling and string management throughout the app.',
          Icons.style,
        ),
      ],
    );
  }

  Widget _buildSuggestionItem(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeExamplesPage extends StatelessWidget {
  const CodeExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCodeExampleItem(
          'Improved State Management',
          'Consider using Provider for state management:\n\nclass UserProvider with ChangeNotifier {\n  User? _user;\n  \n  User? get user => _user;\n  \n  void setUser(User user) {\n    _user = user;\n    notifyListeners();\n  }\n}',
        ),
        _buildCodeExampleItem(
          'Error Handling Example',
          'Better API error handling:\n\ntry {\n  final response = await http.get(Uri.parse(url));\n  if (response.statusCode == 200) {\n    return jsonDecode(response.body);\n  } else {\n    throw Exception(\'Failed to load data\');\n  }\n} catch (e) {\n  showDialog(\n    context: context,\n    builder: (ctx) => AlertDialog(\n      title: Text(\'Error\'),\n      content: Text(e.toString()),\n    ),\n  );\n}',
        ),
        _buildCodeExampleItem(
          'Constants Management',
          'Create a constants file:\n\nclass AppConstants {\n  static const String appName = "Digital Orientation";\n  static const String apiUrl = "https://api.example.com";\n  \n  static const Color primaryColor = Color(0xFF6C63FF);\n  static const Color secondaryColor = Color(0xFFF50057);\n}',
        ),
      ],
    );
  }

  Widget _buildCodeExampleItem(String title, String code) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                code,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';
import 'second_screen.dart';

/// The main screen where users can input their username and select a theme.
/// Users can save their preferences and navigate to the second screen.
class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

/// The state class for `FirstScreen` that manages user inputs and theme changes.
class _FirstScreenState extends State<FirstScreen> {
  // Controller for the username input field
  final TextEditingController _usernameController = TextEditingController();

  // Variable to store the currently selected theme (Light or Dark)
  String? _selectedTheme;

  @override
  Widget build(BuildContext context) {
    // Access the ThemeNotifier from the provider
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field for username
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown and theme preview
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedTheme,
                    decoration: const InputDecoration(
                      labelText: 'Select Theme',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Light', 'Dark']
                        .map((theme) => DropdownMenuItem<String>(
                      value: theme,
                      child: Text(theme),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTheme = value;
                        themeNotifier.setTheme(value == 'Dark');
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Theme preview box
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedTheme == 'Dark'
                        ? Colors.black54
                        : Colors.grey[300],
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Save Preferences button
            ElevatedButton.icon(
              onPressed: () {
                if (_usernameController.text.isEmpty || _selectedTheme == null) {
                  // Show error message if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete all fields before saving!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Show confirmation message when preferences are saved
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Preferences saved! Username: ${_usernameController.text}, Theme: $_selectedTheme'),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Preferences'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const Spacer(),

            // Navigate to Second Screen button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

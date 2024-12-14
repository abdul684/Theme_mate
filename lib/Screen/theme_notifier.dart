import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class manages the app's theme (light or dark mode) and notifies listeners of changes.
/// It uses the ChangeNotifier to enable state management and updates the UI when the theme changes.
class ThemeNotifier extends ChangeNotifier {
  // Private variable to track whether dark mode is enabled.
  bool _isDarkMode = false;

  // Getter to expose the current theme mode (true for dark mode, false for light mode).
  bool get isDarkMode => _isDarkMode;

  /// Constructor to initialize the ThemeNotifier and load the saved theme preference.
  ThemeNotifier() {
    _loadThemeFromPreferences();
  }

  /// Sets the theme to either dark mode or light mode based on the [isDarkMode] parameter.
  /// Saves the theme preference locally and notifies listeners to rebuild the UI.
  void setTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _saveThemeToPreferences();
    notifyListeners();
  }

  /// Toggles the current theme between dark mode and light mode.
  /// Saves the updated theme preference and notifies listeners to update the UI.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPreferences();
    notifyListeners();
  }

  /// Loads the saved theme preference (dark or light mode) from local storage.
  /// If no preference is saved, it defaults to light mode.
  Future<void> _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light mode if no preference exists.
    notifyListeners(); // Notify listeners to apply the loaded theme.
  }

  /// Saves the current theme preference (dark or light mode) to local storage.
  Future<void> _saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode); // Save the current theme mode.
  }
}

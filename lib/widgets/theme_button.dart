import 'package:flutter/material.dart';
import 'package:movieex/providers/theme.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (val) {
          themeProvider.toggleTheme(val);
        });
  }
}

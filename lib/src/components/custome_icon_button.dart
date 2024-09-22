import 'package:flutter/material.dart';

import '../utils/Constants/colors.dart';

class CustomButton extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool isSelectedScreen;
  final double? width; // Optional width

  const CustomButton({
    Key? key,

    required this.title,
    required this.isSelectedScreen,
    required this.icon,
    required this.onPress,
    this.width, // Optional width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,// Set button width
      child: ElevatedButton(

        onPressed: onPress,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(2),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return isSelectedScreen ? AppColors.primary : Colors.white; // Change color when hovered
              }
              return isSelectedScreen ? Colors.white : AppColors.primary; // Default background color
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return isSelectedScreen ? Colors.white : AppColors.primary; // Text/icon color when hovered
              }
              return isSelectedScreen ? AppColors.primary :Colors.white; // Default text/icon color
            },
          ),

          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Border radius
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align icon and text to the start
          children: [
            Icon(icon), // Icon on the left
            SizedBox(width: 8), // Space between the icon and text
            Text(title),
          ],
        ),
      ),
    );
  }
}

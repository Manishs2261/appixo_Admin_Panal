
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardWidgets extends StatelessWidget {
  const CustomCardWidgets({
    super.key, required this.title, required this.totalUser,
  });


  final String title;
  final String totalUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Adds a nice shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 250,
        height: 100,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white, // White background color
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Soft shadow
              blurRadius: 6,
              offset: Offset(1, 1), // Shadow offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Dark text color for contrast
                ),
              ),
              SizedBox(height: 6),
              Text(
                totalUser,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54, // Lighter text for description
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

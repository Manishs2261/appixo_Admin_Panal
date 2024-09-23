import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(50), // Circular image
                  child: Image.network(
                    'data:image/jpeg;base64,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',
                    // Replace with actual photo URL
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16), // Space between image and text

                // Profile Information (Name, Email, City)

                Text(
                  'John Doe', // Name
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 16),
                // Email
                Text(
                  'john.doe@example.com', // Email
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 16),
                // City

                Text(
                  'New York City', // City
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(width: 16),

                Icon(Icons.delete)
              ],
            ),
          ),
        ));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Dynamically calculate the width of each card based on screen size
        double cardWidth;

        // Adjust card width based on screen size
        if (constraints.maxWidth > 1200) {
          cardWidth = (constraints.maxWidth / 5) - 10; // 5 items in a row for larger screens
        } else if (constraints.maxWidth > 800) {
          cardWidth = (constraints.maxWidth / 4) - 10; // 4 items in a row for medium screens
        } else if (constraints.maxWidth > 600) {
          cardWidth = (constraints.maxWidth / 3) - 10; // 3 items in a row for smaller tablets
        } else {
          cardWidth = (constraints.maxWidth / 2) - 10; // 2 items in a row for mobile screens
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('rentCollection').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No rooms available.'));
            }

            // Get the list of documents from the snapshot
            final rooms = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Wrap(
                spacing: 8.0, // Space between items horizontally
                runSpacing: 8.0, // Space between items vertically
                children: List.generate(rooms.length, (index) {
                  final roomData = rooms[index].data() as Map<String, dynamic>;
                  return Container(
                    width: cardWidth, // Set card width dynamically
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // White background
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4), // Shadow offset
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: roomData['coverImageId'],
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.photo),
                                ),
                              ),
                              // Name
                              Text(
                                roomData['houseName'] ?? 'Room Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // Name
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87, // Dark color for contrast
                                ),
                              ),
                              Text(
                                roomData['owner'] ?? 'Owner Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // Name
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87, // Dark color for contrast
                                ),
                              ),
                              // Email
                              Text(
                                roomData['email'] ?? 'example@example.com',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // Email
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey, // Lighter text color
                                ),
                              ),
                              // City
                              Row(
                                children: [
                                  Icon(Icons.location_city, size: 16, color: Colors.grey),
                                  // City icon
                                  SizedBox(width: 4),
                                  Text(
                                    roomData['city'] ?? 'City Name',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis, // City
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:appixoadmin/src/utils/Constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var snapData;

  bool isSwitched = false;
  int currentPage = 0; // Track current page
  final int itemsPerPage = 7; // 5 items per page

  // Controller for search input
  TextEditingController searchController = TextEditingController();
  String searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery =
                        value.toLowerCase(); // Update search query on change
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search by Name or Email',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('loginUser').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        SizedBox(width: 8),
                        Text("No Internet Connection"),
                      ],
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  // Handle null or empty data
                  if (data == null || data.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  // Filter data based on search query (name or email)
                  var filteredData = data.where((doc) {
                    var userData = doc.data();
                    var name = userData['Name']?.toLowerCase() ?? '';
                    var email = userData['email']?.toLowerCase() ?? '';
                    return name.contains(searchQuery) ||
                        email.contains(searchQuery);
                  }).toList();

                  // Calculate the start and end indices for the current page
                  int startIndex = currentPage * itemsPerPage;
                  int endIndex =
                      (startIndex + itemsPerPage < filteredData.length)
                          ? startIndex + itemsPerPage
                          : filteredData.length;

                  var currentData = filteredData.sublist(
                      startIndex, endIndex); // Paginated data

                  // Calculate the display range for the pagination summary
                  int showingFrom = startIndex + 1;
                  int showingTo = endIndex;
                  int totalResults = filteredData.length;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: currentData.length,
                          itemBuilder: (_, index) {
                            var userData = currentData[index].data();

                            // Extract user details from Firestore
                            var name = userData['Name'] ?? 'Unknown Name';
                            var email = userData['email'] ?? 'Unknown Email';
                            var city = userData['city'] ?? 'Unknown City';
                            var profilePic =
                                userData['userImage'] ?? 'default_image_url';

                            int serialNumber = startIndex + index + 1;

                            // Handle timestamp conversion
                            var timestamp = userData['createdAt'] as Timestamp?;
                            DateTime? dateTime;
                            if (timestamp != null) {
                              dateTime = timestamp.toDate();
                            }

                            return Container(
                              child: Card(
                                margin: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [

                                      // Serial Number
                                      Container(
                                        width: 30,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '$serialNumber',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      // Profile Picture
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: profilePic,
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.person),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Space between image and text

                                      // Profile Information (Name, Email, City)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name, // Name
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              email, // Email
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              city, // City
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            if (dateTime !=
                                                null) // If `Timestamp` field exists
                                              Text(
                                                'Joined: ${dateTime.toLocal().toString()}',
                                                // Display DateTime
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        children: [
                                          Text("Rooms"),
                                          Text("200"),
                                          Text(
                                            "View",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: [
                                          Text("Foods"),
                                          Text("200"),
                                          Text(
                                            "View",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: [
                                          Text("Deals"),
                                          Text("200"),
                                          Text(
                                            "View",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // Aligns the row content in the center
                                        children: [
                                          Text(
                                            isSwitched ? 'Active' : 'Inactive',
                                            // Changes the text based on switch value
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: isSwitched
                                                    ? Colors.green
                                                    : Colors
                                                        .red), // Customize the text style
                                          ),
                                          SizedBox(width: 10),
                                          // Adds some spacing between the text and switch
                                          Transform.scale(
                                            scale: 0.75,
                                            // Scales the switch size (optional)
                                            child: Switch(
                                              value: isSwitched,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched = value;
                                                });
                                              },
                                              activeColor: Colors.green,
                                              // Active thumb color
                                              inactiveThumbColor: Colors.red,
                                              // Inactive thumb color
                                              activeTrackColor:
                                                  Colors.green.withOpacity(0.5),
                                              inactiveTrackColor:
                                                  Colors.red.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          // Add functionality to handle delete, if required
                                          // Example: deleteUser(userData['uid']);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Pagination controls
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Pagination summary (Showing X to Y of Z results)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Showing $showingFrom to $showingTo of $totalResults results",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,foregroundColor: Colors.white),

                              onPressed: currentPage > 0
                                  ? () {
                                      setState(() {
                                        currentPage--;
                                      });
                                    }
                                  : null, // Disable if on the first page
                              child: const Text('Previous'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,foregroundColor: Colors.white),
                              onPressed: endIndex < filteredData.length
                                  ? () {
                                      setState(() {
                                        currentPage++;
                                      });
                                    }
                                  : null, // Disable if on the last page
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClass {


  static Future<int> getUserCount() async {
    try {
      // Fetch the collection snapshot
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('loginUser').get();

      // Check if the snapshot is empty
      if (querySnapshot.docs.isEmpty) {
        print("No documents found in the 'loginUser' collection.");
      } else {
        print("Found documents in 'loginUser': ${querySnapshot.docs.length}");
      }

      // Get the total number of documents
      int userCount = querySnapshot.size;
      print("Total number of users: $userCount");

      return userCount;

    } catch (e) {
      print("Error fetching user count: $e");
      return 0; // Return 0 if an error occurs
    }
  }




}

import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClass {
  static Future<int> getUserCount() async {
    try {
      // Fetch the collection snapshot
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('loginUser').get();

      if (querySnapshot.docs.isNotEmpty) {
        print("Documents found:");
        querySnapshot.docs.forEach((doc) {
          print("Document ID: ${doc.id}");
        });
      } else {
        print("No documents found in the 'loginUser' collection.");
      }

      return querySnapshot.size;
    } catch (e) {
      print("Error fetching user count: $e");
      return 0; // Return 0 if an error occurs
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClass{


 static Future<int> getUserCount() async {
    try {
      // Replace 'users' with the name of your Firestore collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('loginUser').get();

      // Return the total number of documents (users)
      print(querySnapshot.size);
      return querySnapshot.size;

    } catch (e) {
      print("Error fetching user count: $e");
      return 0; // Return 0 in case of an error
    }
  }
}
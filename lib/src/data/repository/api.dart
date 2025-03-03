import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/helpers/helper_function.dart';
import '../../utils/logger/logger.dart';


class ApisClass {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;

  // for accessing cloud firestorm database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static var coverImageDownloadUrl;
  static var userRentId = "";
  static var otherDownloadUrl;
  static var reviewId = "";
  static var starOne;
  static var starTwo;
  static var starThree;
  static var starFour;
  static var starFive;
  static var averageRating;
  static var totalNumberOfStar;

  static String coverImageFileId = '';

  // upload  Cover image data in firebase database
  static Future uploadCoverImage(File imageFile) async {
    try {
      final reference =
      storage.ref().child('coverImage/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileId = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      coverImageDownloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//============== Edit Post Room Data APis ===================

  //upload other images in firebase database
  static Future uploadOtherImage(File imageFile, itemId) async {
    try {
      final reference =
      storage.ref().child('otherImage/$itemId/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      otherDownloadUrl = await snapshot.ref.getDownloadURL();
      //rent collection data base
      await firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection("$itemId")
          .add({'OtherImage': otherDownloadUrl}).then((value) async {
        AppLoggerHelper.info(value.id);
        userRentId = value.id;
//user personal collection data base
        await firebaseFirestore
            .collection("OtherImageList")
            .doc(itemId)
            .collection("$itemId")
            .doc(userRentId)
            .set({'OtherImage': otherDownloadUrl});

        return null;
      });
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryData(itemId) async {
    var collection = firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOne = data?['ratingStar01'] ?? 0;
    starTwo = data?['ratingStar02'] ?? 0;
    starThree = data?['ratingStar03'] ?? 0;
    starFour = data?['ratingStar04'] ?? 0;
    starFive = data?['ratingStar05'] ?? 0;
    totalNumberOfStar = data?['totalNumberOfStar'] ?? 0;
    averageRating = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryData(
      itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .set({
      'ratingStar01': one,
      'ratingStar02': two,
      'ratingStar03': three,
      'ratingStar04': four,
      'ratingStar05': five,
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    });
  }

  //update Rating bar summary data
  static Future<void> updateRatingBarStarSummaryData(
      itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .update({
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    }).then((value) {
      AppLoggerHelper.info("Update Rating bar average successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar average successfully");
    });
  }

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewData(itemId) async {
    var collection = firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId);

    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';

    return reviewId;
  }


}

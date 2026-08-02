import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/config/theme/app_strings.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseServices {
  final db = FirebaseFirestore.instance;

  CollectionReference<CategoryData> _getCategoryData() {
    return db
        .collection(AppStrings.eventAppCollectionName)
        .withConverter<CategoryData>(
          fromFirestore: (snapshot, options) {
            return CategoryData.fromFirestore(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toFirestore();
          },
        );
  }

  Stream<List<CategoryData>> getCategoryDataStream() {
    return _getCategoryData().snapshots().map((snapshot) {
      List<CategoryData> categoryData = [];

      for (var doc in snapshot.docs) {
        categoryData.add(doc.data());
      }

      return categoryData;
    });
  }

  Stream<QuerySnapshot<CategoryData>> getRealTime(String eventID) {
    final collectionRef = _getCategoryData().where(
      "eventID",
      isEqualTo: eventID,
    );
    return collectionRef.snapshots();
  }

  Future<void> createNewEvent(CategoryData category) async {
    var docRef = _getCategoryData().doc();
    category.categoryID = docRef.id;
    docRef.set(category);
  }

  Future<void> updateFavouriteEvent(String userID, bool newValue) async {
    await FirebaseFirestore.instance
        .collection(AppStrings.eventAppCollectionName)
        .doc(userID)
        .update({'isFavourite': newValue});
  }

  Stream<QuerySnapshot<CategoryData>> getFavouriteCollection(bool favourite) {
    final collectionRef = _getCategoryData().where(
      "isFavourite",
      isEqualTo: favourite,
    );
    return collectionRef.snapshots();
  }

  Future<void> updateEvent(
    String userID,
    String title,
    String description,
    DateTime? selectedDateTime,
    TimeOfDay? selectedTime,
  ) async {
    await FirebaseFirestore.instance
        .collection(AppStrings.eventAppCollectionName)
        .doc(userID)
        .update({
          "categoryName": title,
          "categoryDescription": description,
          "categoryDate": selectedDateTime?.millisecondsSinceEpoch,
          "categoryTime": selectedTime == null
              ? null
              : selectedTime.hour * 60 + selectedTime.minute,
        });
  }

  Future<void> deleteEvent(String userID) async {
    await FirebaseFirestore.instance
        .collection(AppStrings.eventAppCollectionName)
        .doc(userID)
        .delete();
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Authentication error",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: e.message ?? "No user found for that email.",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: e.message ?? "Wrong password provided for that user.",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
      return false;
    }
  }

  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Password reset email sent",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Something went wrong",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential;
    } on GoogleSignInException catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Google authentication failed",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return null;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return null;
    }
  }
}

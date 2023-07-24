import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/global.dart';

class FirestoreMethods {

  Stream<QuerySnapshot<Map<String, dynamic>>>get meetingsHistory => firestore
      .collection('users')
      .doc(fAuth.currentUser!.uid)
      .collection('meetings')
      .snapshots();

  void addToMeetingHistory(String meetingName) async {
    try {
      await firestore
          .collection('users')
          .doc(fAuth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}

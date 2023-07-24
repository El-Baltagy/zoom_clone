import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../utils/global.dart';
import '../utils/utils.dart';


class AuthMethods {


  Stream<User?> get authChanges => fAuth.authStateChanges();
  User get user => fAuth.currentUser!;

  // Future<bool> signInWithGoogle(BuildContext context) async {
  //   bool res = false;
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //
  //     User? user = userCredential.user;
  //
  //     if (user != null) {
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         await _firestore.collection('users').doc(user.uid).set({
  //           'username': user.displayName,
  //           'uid': user.uid,
  //           'profilePhoto': user.photoURL,
  //         });
  //       }
  //       res = true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //     res = false;
  //   }
  //   return res;
  // }

  void signOut() async {
    try {
      fAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

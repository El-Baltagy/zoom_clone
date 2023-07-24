import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../resources/cash_helper.dart';

User? currentFirebaseUser;

FirebaseAuth fAuth=FirebaseAuth.instance;
FirebaseDatabase fDB=FirebaseDatabase.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;


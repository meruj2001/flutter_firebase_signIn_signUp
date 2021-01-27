import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_signup/models/brew_model.dart';
import 'package:flutter_signin_signup/models/user_model.dart';

class Database {
  final String uid;
  Database({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // get brews stream
  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map(_brewListfromSnapshot);
  }

  // brew list from snapshot
  List<BrewModel> _brewListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BrewModel(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 100,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // get user doc stream
  Stream<UserDataModel> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: uid,
      name: snapshot.data()['name'],
      strength: snapshot.data()['strength'],
      sugars: snapshot.data()['sugars'],
    );
  }
}

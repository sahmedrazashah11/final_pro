import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SaveData {
  Future<String> UploadDataToFirebase(String childName, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childName).child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    print('child Name: $childName');

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> SaveDataImage(
      {
      //required String name,
      required String firstName,
      required String secondName,
      required String email,
      required String password,
      required  String countryValue,
      required  String stateValue ,
      required String cityValue ,
      required String storeName,
      required String userType,
      required String selectedValue,
      required Uint8List file,
      required String v_user_id}) async {
    String resp = "some Error Occurred";
    try {
      String imageUrl = await UploadDataToFirebase('/user_profile', file);
      await firestore.collection('user_profile/').add({
        'v_first_name': firstName,
        'v_second_name': secondName,
        'v_user_id': v_user_id,
        'v_email': email,
        'userType': userType,
        'v_password': password,
        'v_industry': selectedValue,
        'v_store_country': countryValue,
        'v_store_state': stateValue,
        'v_store_city': cityValue,
        'v_store_name': storeName,
        'date_time': DateTime.now(),
        'v_password': password,
        'v_imageLink': imageUrl,
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

}

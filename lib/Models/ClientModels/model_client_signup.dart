import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ClientSaveData {
  Future<String> UploadDataToFirebase(String childName, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childName).child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    print('child Name: $childName');

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> ClientSaveDataImage(
      {
      //required String name,

      required String firstName,
      required String secondName,
      required String email,
      required String password,
      required String city,
      required String companyName,
      required String website,
      required String userType,
      // required PhoneNumber phoneNumber,
      required Uint8List file,
      required String v_user_id}) async {
    String resp = "some Error Occurred";
    try {
      String imageUrl = await UploadDataToFirebase('/client_profile', file);
      await firestore.collection('client_profile/').add({
        'c_first_name': firstName,
        'c_second_name': secondName,
        'c_user_id': v_user_id,
        'c_email': email,
        'c_password': password,
        'c_user_type': userType,
        'c_company_name': companyName,
        'c_store_city': city,
        'c_website': website,
        'date_time': DateTime.now(),
        // 'phoneNumber': phoneNumber,
        'c_imageLink': imageUrl,
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

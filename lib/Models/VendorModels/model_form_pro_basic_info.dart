import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ModelProBaic{
    Future<String> UploadDataToFirebase(String childName, Uint8List bannerImage) async {
    Reference ref =
        _storage.ref().child(childName).child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(bannerImage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
   
   Future<List<String>> UploadImages(String childName, List<XFile> imagefiles) async {
  List<String> downloadUrls = [];

  for (XFile imagefile in imagefiles) {
    Reference ref = _storage.ref().child(childName).child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(await imagefile.readAsBytes());
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    downloadUrls.add(downloadUrl);
  }

  return downloadUrls;
}
  Future<String> SaveData({
     required String productTitle,
     required String priceRange,
     required RangeValues minOrder,
     required String productType,
     required List<String> size,
     required String v_user_id,
     required Uint8List bannerImage,
     required List<XFile> imagefiles,
      // required Uint8List bannerImage,
      // required Uint8List prodcutimage,

  }) async{
    String resp = "some Error Occurred";
    try{
  print('modelpro $size');
Map<String, dynamic> minOrderMap = {
  'minOrder': minOrder.start,
  'maxOrder': minOrder.end,
};
      String bannerImageUrl = await UploadDataToFirebase('/product_basic_info', bannerImage);
      List<String> imageUrls = await UploadImages('/product_basic_info', imagefiles);
        await firestore.collection('product_basic_info').add({
          'v_user_id': v_user_id,
          'product_title': productTitle,
          'price_range': priceRange,
          'min_order': minOrderMap,
          'product_type': productType,
          'product_size': size,
          'bannar_Image': bannerImageUrl,
          'product_Image': imageUrls,
        });
        resp = 'success';
    }catch (err) {
      resp = err.toString();
  print('modelpro $resp');

    }
    return resp;
  }
}
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ModelProductDescription{
  Future<String> SaveData({
     required String printingMethods,
     required String brandName,
     required String productFeature,
     required String modelNumber,
     required String collar,
     required String fabricWeight,
     required String avalibleQuantity,
     required String material,
     required String technics,
     required String sleeveStyle,
     required String gender,
     required String design,
     required String patternType,
     required String style,
     required String fabricType,
     required String weavingMethod,
     required String sampleLead,
     required String countryValue,
     required String stateValue,
     required String cityValue,
     required String address,
     required String v_user_id,
  }) async{
    String resp = "some Error Occurred";
    try{
      
await firestore.collection('product_description').add({
  'v_user_id': v_user_id,
  'printing_Methods': printingMethods,
  'brandName': brandName,
  'productFeature': productFeature,
  'modelNumber': modelNumber,
  'collar': collar,
  'fabricWeight': fabricWeight,
  'avalibleQuantity': avalibleQuantity,
  'material': material,
  'technics': technics,
  'sleeveStyle': sleeveStyle,
  'gender': gender,
  'design': design,
  'patternType': patternType,
  'style': style,
  'fabricType': fabricType,
  'weavingMethod': weavingMethod,
  'sampleLead': sampleLead,
  'countryValue': countryValue,
  'stateValue': stateValue,
  'cityValue': cityValue,
  'address': address,
});
resp = 'success';
    }catch (err) {
      resp = err.toString();
  print('modelpro $resp');

    }
    return resp;
  }
}
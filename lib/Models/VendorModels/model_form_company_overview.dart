import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;


class ModelCompanyOv{
      Future<List<String>> UploadImagesCompanyImages(String childName, List<XFile> imagefiles) async {
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
Future<String> Certification(String childName, Uint8List imageCertification) async {
      
      Reference ref =  _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(imageCertification);
     TaskSnapshot snapshot = await uploadTask;
     String downloadUrl = await snapshot.ref.getDownloadURL();
     return downloadUrl;
   }
   Future<String> ProductCertification(String childName, Uint8List imageProductCertification) async {
      
      Reference ref =  _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(imageProductCertification);
     TaskSnapshot snapshot = await uploadTask;
     String downloadUrl = await snapshot.ref.getDownloadURL();
     return downloadUrl;
   }
   Future<String> Patents(String childName, Uint8List imagePatents) async {
      
      Reference ref =  _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(imagePatents);
     TaskSnapshot snapshot = await uploadTask;
     String downloadUrl = await snapshot.ref.getDownloadURL();
     return downloadUrl;
   }
   Future<String> TradeMarks(String childName, Uint8List imageTrademark) async {
      
      Reference ref =  _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(imageTrademark);
     TaskSnapshot snapshot = await uploadTask;
     String downloadUrl = await snapshot.ref.getDownloadURL();
     return downloadUrl;
   }

Future<String> SaveCompanyOverveiw({
     required String companyName,
     required String businessType,
     required String mainProducts,
     required String totalEmployee,
     required String totalAnnualRevenue,
     required String yearEstablished,
     required String countryValue,
     required String stateValue,
     required String cityValue,
     required String v_user_id,
     required List<XFile> imageCompanyImage,
     required Uint8List imageCertification,
     required Uint8List imageProductCertification,
     required Uint8List imagePatents,
     required Uint8List imageTrademark,
})async{
         String resp = "some Error Occurred";
          try{

      List<String> imageCompanyImageUrl = await UploadImagesCompanyImages('/vendor_company_overview', imageCompanyImage);
      String imageCertificationUrl = await Certification('/vendor_company_overview', imageCertification);
      String imageProductCertificationUrl = await ProductCertification('/vendor_company_overview', imageProductCertification);
      String imagePatentsUrl = await Patents('/vendor_company_overview', imagePatents);
      String imageTrademarkUrl = await TradeMarks('/vendor_company_overview', imageTrademark);
        await firestore.collection('vendor_company_overview').add({
          'v_user_id': v_user_id,
          'companyName': companyName,
          'businessType': businessType,
          'mainProducts': mainProducts,
          'totalEmployee': totalEmployee,
          'totalAnnualRevenue': totalAnnualRevenue,
          'yearEstablished': yearEstablished,
          'countryValue': countryValue,
          'stateValue': stateValue,
          'cityValue': cityValue,
          'imageCompanyImage': imageCompanyImageUrl,
          'imageCertification': imageCertificationUrl,
          'imageProductCertification': imageProductCertificationUrl,
          'imagePatents': imagePatentsUrl,
          'imageTrademark': imageTrademarkUrl,
        });
        resp = 'success';
    }catch (err) {
      resp = err.toString();
  print('modelpro $resp');

    }
    return resp;
}


}
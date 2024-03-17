import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  var userData = {}.obs; // Using Rx for reactive data

  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection('user_profile')
          .doc(uid)
          .get();

      if (document.exists) {
        userData.value = document.data() ?? {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}

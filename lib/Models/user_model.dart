class UserModel {
  String? user_id;
  String? email;
  String? fullname;
  String? phoneNumber;
  String? password;
  String? user_role;
  String? user_image;

  UserModel(
      {this.user_id,
      this.email,
      this.fullname,
      this.phoneNumber,
      this.password,
      this.user_role,
      this.user_image});

  // Receiving Data From the Server
  factory UserModel.fromMap(map) {
    return UserModel(
      user_id: map['user_id'],
      email: map['email'],
      fullname: map['fullname'],
      phoneNumber: map['phoneNumber'],
      user_role: map['user_role'],
      user_image: map['user_image'],
    );
  }

  // Sending Data from Server
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'email': email,
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'password': password,
      'user_role': user_role,
      'user_image': user_image,
    };
  }
}

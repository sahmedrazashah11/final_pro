import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexi_productimage_slider/flexi_productimage_slider.dart';
import 'package:gallery_zoom_slides/gallery_zoom_slides.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/Vendor/store/create_store_screen.dart';
import 'package:get/get.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import '../../../Client/fitness_app_theme.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class VendorViewStore extends StatefulWidget {
  const VendorViewStore({super.key});

  @override
  State<VendorViewStore> createState() => _VendorViewStoreState();
}

FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;
String VendorID = user!.uid;

class _VendorViewStoreState extends State<VendorViewStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_square),
              onPressed: () {
                Get.to(const CreateStore());
              },
            ),
            // add more IconButton
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Stack(
            children: <Widget>[
              getAppBarUI(),
              SingleChildScrollView(
                child: Container(
                  child: Column(children: [
                    //ProductImageSlider(),
                    PriceTagesAndSize(),
                    ProdcutTabBar(),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: getUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            String userName =
                                snapshot.data!['v_first_name'] ?? 'Unknown';
                            String profilePicture = snapshot
                                    .data!['v_imageLink'] ??
                                'https://wallpapers.com/images/featured-full/cool-profile-picture-87h46gcobjl5e4xu.jpg';
                            print("hello123" + userName);
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(profilePicture),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    userName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      letterSpacing: 1.2,
                                      color: FitnessAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      // Get the current user from FirebaseAuth
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Use the current user's ID to fetch user data
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user_profile')
            .where('v_user_id', isEqualTo: currentUser.uid)
            .limit(1)
            .get();
        print("User IDvv: ${currentUser.uid}");

        // Check if any documents match the query
        if (querySnapshot.docs.isNotEmpty) {
          // Get data from the first matching document
          Map<String, dynamic>? userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
            // Print the user ID and any other data you need
            print("User ID outer vender: ${currentUser.uid}");
            print("User Data: $userData");

            return userData;
          } else {
            print("Error: User data is null");
            return {};
          }
        } else {
          // No matching documents found
          print("User document not found for userId: ${currentUser.uid}");
          return {};
        }
      } else {
        // No current user found
        print("No current user found");
        return {};
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {};
    }
  }

  Widget ProductImageSlider() {
    List<String> arrayImages = const [
      "https://i.ibb.co/ZLFHX3F/1.png",
      "https://i.ibb.co/JKJvs5S/2.png",
      "https://i.ibb.co/LCzV7b3/3.png",
      "https://i.ibb.co/L8JHn1L/4.png",
      "https://i.ibb.co/7RWNCXH/5.png",
      "https://i.ibb.co/bBsh5Pm/6.png",
    ];
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 65,
        ),
        flexiProductimageSlider(
          //required fields
          arrayImages: arrayImages,

          // optional fields

          //set where you want to set your thumbnail
          sliderStyle: SliderStyle.overSlider, //.nextToSlider

          // set you slider height like 1.0,1.5,2.0 etc...
          aspectRatio: 0.8,

          //set content mode of image
          boxFit: BoxFit.cover,

          //set this if you want to set any default image index when it loads
          selectedImagePosition: 0,

          //set your thumbnail alignment in slider
          thumbnailAlignment: ThumbnailAlignment.bottom, //.right , .bottom
          thumbnailBorderType: ThumbnailBorderType.all, //.bottom, .all
          thumbnailBorderWidth: 1.5, //double value

          //set corner radius of your thumbnail
          thumbnailBorderRadius: 2,

          //set your thumbnail height & width
          //NOTE : if you set ThumbnailShape.circle then set thumbnail width height same
          thumbnailWidth: 55,
          thumbnailHeight: 55,

          //set color of current image thumbnail border
          thumbnailBorderColor: Colors.blue,

          //make you action when user click on image
          onTap: (index) {
            print("selected index : $index");

            //for zooming effect on click
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => galleryZoomSlides(
                          //required fields
                          arrayImages: arrayImages,

                          //Optional fields
                          zoomTheme:
                              ZoomTheme.theme3, //.theme1, .theme2, .theme3
                          selectedImagePosition: index,
                          selectedThumbnailColor: Colors.blue,
                        )));
          },
        ),
      ],
    );

    // This trailing comma makes auto-formattin
  }

  Widget PriceTagesAndSize() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Expanded(
          child: FutureBuilder<Map<String, dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            dynamic productImages = snapshot.data!['product_Image'] ?? [];
            String product_title = snapshot.data!['product_title'] ?? 'Unknown';
            String product_type = snapshot.data!['product_type'] ?? 'Unknown';
            String price_range = snapshot.data!['price_range'] ?? 'Unknown';
            Map<String, dynamic>? min_orderRangeData =
                snapshot.data!['min_order'];
            dynamic product_size = snapshot.data!['product_size'];
            List<String> tags;
            if (product_size is String) {
              tags = [product_size];
            } else if (product_size is List) {
              tags = List<String>.from(product_size);
            } else {
              tags = [];
            }
            double minOrder =
                (min_orderRangeData?['minOrder'] ?? 0.0).toDouble();
            double maxOrder =
                (min_orderRangeData?['maxOrder'] ?? 0.0).toDouble();
            RangeValues min_orderRange = RangeValues(minOrder, maxOrder);

            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: productImages.map<Widget>((imagePath) {
                      return FutureBuilder<String>(
                        future: getImageUrl(imagePath),
                        builder: (context, imageUrlSnapshot) {
                          if (imageUrlSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (imageUrlSnapshot.hasError) {
                            return Text('Error: ${imageUrlSnapshot.error}');
                          } else {
                            return Image.network(
                              imageUrlSnapshot.data!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                  Text(
                    product_title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(product_type),
                  Text(
                    "Order Range: ${min_orderRange.start} - ${min_orderRange.end}",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Price Range: $price_range',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const Text(
                    'Size',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tags.map((tag) {
                      return Padding(
                        padding: EdgeInsets.all(1),
                        child: _buildTag(tag),
                      );
                    }).toList(),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const Text(
                    "Purchase Details:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          "Shipping:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Contact supplier to negotiate shipping"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          "Payments:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Enjoy encrypted and secure payments"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          "Returns & Refund:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Eligible for returns and refunds \n View details"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }

  // Function to fetch image URL from Firebase Storage
  Future<String> getImageUrl(String imagePath) async {
    final ref =
        firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
    return await ref.getDownloadURL();
  }

  Widget _buildTag(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getData() async {
    try {
      // Get the current user from FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      String VendorID = user!.uid;

      if (VendorID != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('product_basic_info')
            .where('v_user_id', isEqualTo: VendorID)
            .get();
        print("priceRanage $VendorID");
        if (querySnapshot.docs.isNotEmpty) {
          // Return the data if it exists
          return querySnapshot.docs.first.data() as Map<String, dynamic>;
        } else {
          // Return an empty map if no data is found
          print("No data found for the user");
          return {};
        }
      } else {
        // Handle the case when the user is null
        print("Error: User data is null");
        return {};
      }
    } catch (e) {
      // Handle errors and return an empty map
      print("Error fetching user data: $e");
      return {};
    }
  }

  Widget ProdcutTabBar() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: const Color.fromARGB(255, 206, 203, 203),
        width: MediaQuery.sizeOf(context).width,
        height: 500,
        child: ContainedTabBarView(
          tabs: const [
            Text(
              'Product Details',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Company Profile',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Company Profile',
              style: TextStyle(color: Colors.black),
            ),
          ],
          views: [
            Container(
              child: Row(
                children: [ProductDetails()],
              ),
            ),
            Container(
              child: CompanyProfile(),
            ),
            Container(color: Colors.green)
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }

  Widget ProductDetails() {
    return Center(
      child: Container(
        color: FitnessAppTheme.grey,
        width: 300,
        height: 900,
        child: ContainedTabBarView(
          tabs: const [
            Text(
              'Product \n Description',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Specification',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Packaging & \n Delivery',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
          views: [
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Overview",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Text("Essential details:",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: FutureBuilder<Map<String, dynamic>>(
                      future: getProductData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          String printing_Methods =
                              snapshot.data!['printing_Methods'] ?? 'Unknown';
                          String countryValue =
                              snapshot.data!['countryValue'] ?? 'Unknown';
                          String cityValue =
                              snapshot.data!['cityValue'] ?? 'Unknown';
                          String brandName =
                              snapshot.data!['brandName'] ?? 'Unknown';
                          String modelNumber =
                              snapshot.data!['modelNumber'] ?? 'Unknown';
                          String fabricType =
                              snapshot.data!['fabricType'] ?? 'Unknown';
                          String productFeature =
                              snapshot.data!['productFeature'] ?? 'Unknown';
                          String fabricWeight =
                              snapshot.data!['fabricWeight'] ?? 'Unknown';
                          String gender = snapshot.data!['gender'] ?? 'Unknown';
                          String material =
                              snapshot.data!['material'] ?? 'Unknown';
                          String patternType =
                              snapshot.data!['patternType'] ?? 'Unknown';
                          String sampleLead =
                              snapshot.data!['sampleLead'] ?? 'Unknown';
                          String sleeveStyle =
                              snapshot.data!['sleeveStyle'] ?? 'Unknown';
                          String style = snapshot.data!['style'] ?? 'Unknown';
                          String technics =
                              snapshot.data!['technics'] ?? 'Unknown';
                          String weavingMethod =
                              snapshot.data!['weavingMethod'] ?? 'Unknown';

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Printing Methods: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(printing_Methods,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Place of Origin: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(countryValue + cityValue,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Brand Name: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(brandName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Model Numbe: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(modelNumber,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Features: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(fabricType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Product Feature: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(productFeature,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Fabric Weight: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(fabricWeight,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Gender: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(gender,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Material: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(material,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Pattern Type: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(patternType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sample Lead: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(sampleLead,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sleeve Style: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(sleeveStyle,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Style: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(style,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Technics: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(technics,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Weaving Method: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(weavingMethod,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Pattern Type: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(patternType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: FutureBuilder<Map<String, dynamic>>(
                      future: getProductData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          String printing_Methods =
                              snapshot.data!['printing_Methods'] ?? 'Unknown';

                          String modelNumber =
                              snapshot.data!['modelNumber'] ?? 'Unknown';
                          String fabricType =
                              snapshot.data!['fabricType'] ?? 'Unknown';
                          String productFeature =
                              snapshot.data!['productFeature'] ?? 'Unknown';
                          String fabricWeight =
                              snapshot.data!['fabricWeight'] ?? 'Unknown';
                          String gender = snapshot.data!['gender'] ?? 'Unknown';
                          String material =
                              snapshot.data!['material'] ?? 'Unknown';
                          String patternType =
                              snapshot.data!['patternType'] ?? 'Unknown';
                          String sampleLead =
                              snapshot.data!['sampleLead'] ?? 'Unknown';
                          String sleeveStyle =
                              snapshot.data!['sleeveStyle'] ?? 'Unknown';
                          String style = snapshot.data!['style'] ?? 'Unknown';

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Printing Methods: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(printing_Methods,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Model Numbe: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(modelNumber,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Features: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(fabricType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Product Feature: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(productFeature,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Fabric Weight: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(fabricWeight,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Gender: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(gender,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Material: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(material,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Pattern Type: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(patternType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sample Lead: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(sampleLead,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sleeve Style: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(sleeveStyle,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Style: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(style,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [Text("Soon")],
                ),
              ),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getProductData() async {
    try {
      // Get the current user from FirebaseAuth
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Use the current user's ID to fetch user data
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('product_description')
            .where('v_user_id', isEqualTo: currentUser.uid)
            .limit(1)
            .get();
        print("User IDvv: ${currentUser.uid}");

        // Check if any documents match the query
        if (querySnapshot.docs.isNotEmpty) {
          // Get data from the first matching document
          Map<String, dynamic>? ProductDesData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (ProductDesData != null) {
            // Print the user ID and any other data you need
            print("User ID outer vender: ${currentUser.uid}");
            print("User Data: $ProductDesData");

            return ProductDesData;
          } else {
            print("Error: User data is null");
            return {};
          }
        } else {
          // No matching documents found
          print("User document not found for userId: ${currentUser.uid}");
          return {};
        }
      } else {
        // No current user found
        print("No current user found");
        return {};
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {};
    }
  }

  Widget CompanyProfile() {
    return Center(
      child: Container(
        color: FitnessAppTheme.grey,
        width: 300,
        height: 500,
        child: ContainedTabBarView(
          tabs: const [
            Text(
              'Company \n Overview',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Production \n Capacity',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Quality \n Control',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Factory \n Inspection Report',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
          views: [
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Company Overview",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Text("Company Album:",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: FutureBuilder<Map<String, dynamic>>(
                      future: getCompanyOverview(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          String mainProducts =
                              snapshot.data!['mainProducts'] ?? 'Unknown';
                          String businessType =
                              snapshot.data!['businessType'] ?? 'Unknown';
                          String cityValue =
                              snapshot.data!['cityValue'] ?? 'Unknown';
                          String countryValue =
                              snapshot.data!['countryValue'] ?? 'Unknown';
                          String totalAnnualRevenue =
                              snapshot.data!['totalAnnualRevenue'] ?? 'Unknown';
                          String totalEmployee =
                              snapshot.data!['totalEmployee'] ?? 'Unknown';
                          String yearEstablished =
                              snapshot.data!['yearEstablished'] ?? 'Unknown';
                          String companyName =
                              snapshot.data!['companyName'] ?? 'Unknown';
                          List<String> imageUrls =
                              snapshot.data!['imageCompanyImage'] ?? [];
                          // List<String> imageUrls =
                          //     snapshot.data!['imageCompanyImage'] ?? 'Unknown';
                          return Column(
                            children: [
                              SizedBox(
                                  height: 100, // Adjust the height as needed
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image.network(
                                          imageUrls[index],
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Company Name: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(companyName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Business types: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(businessType,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Main Products: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(mainProducts,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Country / Region: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(countryValue + ", " + cityValue,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Annual Revenue: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(totalAnnualRevenue,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Employee: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(totalEmployee,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Established: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  Text(yearEstablished,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            ),
            Container(color: Colors.green),
            Container(color: Colors.green),
            Container(color: Colors.red),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getCompanyOverview() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('vendor_company_overview')
            .where('v_user_id', isEqualTo: currentUser.uid)
            .limit(1)
            .get();

        // Check if any documents match the query
        if (querySnapshot.docs.isNotEmpty) {
          // Get data from the first matching document
          Map<String, dynamic>? productDesData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (productDesData != null) {
            // Print the user ID and any other data you need
            print("User ID outer vender: ${currentUser.uid}");
            print("User Data: $productDesData");

            // Explicitly cast to List<String>
            List<String> imageUrls =
                List<String>.from(productDesData['imageCompanyImage'] ?? []);
            productDesData['imageCompanyImage'] = imageUrls;

            return productDesData;
          } else {
            print("Error: User data is null");
            return {};
          }
        } else {
          // No matching documents found
          print("User document not found for userId: ${currentUser.uid}");
          return {};
        }
      } else {
        // No current user found
        print("No current user found");
        return {};
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {};
    }
  }
}

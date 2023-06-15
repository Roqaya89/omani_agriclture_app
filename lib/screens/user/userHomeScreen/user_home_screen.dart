
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omani_agriculture_app/screens/categoryItems/category_items_screen.dart';
import 'package:omani_agriculture_app/screens/map/map_screen.dart';
import 'package:omani_agriculture_app/screens/monitoring/monitoring_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/model/firebase_auth.dart';
import 'package:omani_agriculture_app/model/getx_model.dart';
import 'package:omani_agriculture_app/screens/user/orderingDetail/user_product_odering_screen.dart';

class UserHomeScreen extends StatefulWidget {
  final String userType;

  const UserHomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final cartController = Get.find<AddToCartController>();
  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance.collection(userType).where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });


    } else {
      print('Starting usertype');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    cartController.fetchCartItems();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: darkRedColor,
          centerTitle: true,

          title: Text('Agriculture Store',style: TextStyle(fontWeight: FontWeight.bold),),),
        drawer: Drawer(
          backgroundColor: lightButtonGreyColor, //Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                  gradient: LinearGradient(begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.9
                    ], colors: [
                      darkRedColor,
                      lightRedColor,
                    ],
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/agri.jpg'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 30,
                      height: 30,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/seeds.png', fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Seeds',),
                  onTap: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Seeds'),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 30,
                      height: 30,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/plant.png', fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Plants',),
                  onTap: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Plants'),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 35,
                      height: 35,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/crops.png', fit: BoxFit.scaleDown,
                        width: 35,
                        height: 35,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Agricultural Tools',),
                  onTap: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => CategoryItemScreen(category: 'Agriculture Tools'),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 30,
                      height: 30,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/shutdown.png', fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Logout',),
                  onTap: () async {
                    _methodsHandler.signOut(context);
                  },
                ),
              ),

            ],
          ),
        ),
        // appBar: AppBar(
        //
        //   iconTheme: IconThemeData(color: secondaryColor1, size: 25),
        //   automaticallyImplyLeading: false,
        //   elevation: 1,
        //   backgroundColor: primaryColor,
        //   title:
        //   Text('Omani Attire', style: body1White,),
        //
        //   //Image.asset('assets/images/transparent_logo.png', fit: BoxFit.scaleDown,width: 230,),
        //   centerTitle: true,
        // ),

        body:SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height*0.02,
            ),
            CarouselSlider(

                items: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/agri.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.2,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/agri.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.2,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/agri.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.2,
                      )),
                ],
                options: CarouselOptions(
                  height: size.height*0.2,
                  aspectRatio: 16/9,
                  viewportFraction: 0.99,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                )
            ),
            AnimatedSmoothIndicator(
              activeIndex: current,
              count: 3,//pages.length,
              effect: const JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: .7,
                  verticalOffset: 20,
                  activeDotColor: darkPeachColor,
                  dotColor: Colors.grey),
            ),

            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              width: size.width * .9,
              padding: EdgeInsets.only(left: 10, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Menu',
                    style: body1Black,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),


            Container(
              //  color: Colors.red,
             // height: size.height * .22,
              width: size.width * .95,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: primaryColor,
                        ));
                  } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  } else {
                    return  Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Container(

                        //  color: Color(0xFFFBFBFB),
                        // height: size.height*0.66,
                        child: GridView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisExtent: size.height * 0.22,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10),
                            itemCount:snapshot.data!.docs.length,

                            itemBuilder: (BuildContext ctx, index) {

                              // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                              // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses!.length);
                              // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                              // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses![index].verseRecording.toString() + " surah record");

                              return
                                widget.userType == "Users" && snapshot.data!.docs[index]["categoryName"].toString() == "Monitoring" ? SizedBox() :

                                InkWell(
                                onTap: () {
                                  if(index == 3) {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MonitoringScreen()));

                                  } else {

                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => CategoryItemScreen(category: snapshot.data!.docs[index]["categoryName"].toString(),),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 0),
                                      ),
                                    );
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4,right: 4),
                                  child: Container(
                                    // height: size.height*0.25,
                                    width: size.width*0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: lightButtonGreyColor,
                                            spreadRadius: 2,
                                            blurRadius: 3
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(snapshot.data!.docs[index]["categoryImage"].toString(), fit: BoxFit.scaleDown,
                                              height: size.height*0.1,
                                              width: size.width*0.4,
                                              // height: 80,
                                              // width: 80,
                                            ),
                                          ),

                                          Container(
                                            width: size.width*0.4,
                                            child: Center(
                                              child: Text( snapshot.data!.docs[index]["categoryName"].toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),),
                                            ),
                                          ),



                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                },
              ),





            ),



            SizedBox(
              height: size.height * 0.02,
            ),


            Container(
             // color: redColor,
              height: size.height * 0.5,
              width: size.width * .95,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
                builder: (context, snapshotCategory) {
                  if (!snapshotCategory.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: primaryColor,
                        ));
                  } else if (snapshotCategory.hasData && snapshotCategory.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  } else {
                    return Center(
                      child: Container(
                        width: size.width * 0.95,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshotCategory.data!.docs.length, //_categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int categoryIndex) {
                              return
                                (widget.userType == "Users" || widget.userType == "Farmer") && snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString() == "Monitoring" ? SizedBox() :
                                Column(children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  width: size.width * .9,
                                  child: Text(
                                    snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString(),
                                    style: body1Black,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  //  color: Colors.red,
                                  height: size.height * .3,
                                  width: size.width * .95,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("Products").where("category", isEqualTo: snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString()).snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color: primaryColor,
                                            ));
                                      } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                                        // got data from snapshot but it is empty

                                        return Center(child: Text("No Data Found"));
                                      } else {
                                        return Center(
                                          child: Container(
                                            width: size.width * 0.95,
                                            child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data!.docs.length, //_categories.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, int index) {
                                                  return Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: GestureDetector(
                                                        onTap: () {

                                                          Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (c, a1, a2) =>
                                                               UserProductOrderingScreen(
                                                                  docId: snapshot.data!.docs[index].id.toString(),
                                                                  productName: snapshot.data!.docs[index]["productName"].toString(),
                                                                  productPrice: snapshot.data!.docs[index]["productPrice"].toString(),
                                                                  productCode: snapshot.data!.docs[index]["productCode"].toString(),
                                                                  productImage:  snapshot.data!.docs[index]["productImage"].toString(),
                                                                   productCategory:  snapshot.data!.docs[index]["category"].toString()),
                                                              transitionsBuilder: (c, anim, a2, child) =>
                                                                  FadeTransition(opacity: anim, child: child),
                                                              transitionDuration: Duration(milliseconds: 0),
                                                            ),
                                                          ).then((value) {
                                                            cartController.fetchCartItems();
                                                            setState(() {

                                                            });
                                                          });

                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(4),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(0xff000000)
                                                                    .withOpacity(0.1),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                offset: Offset(0,
                                                                    0), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          width: size.width * 0.43,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            4),
                                                                        //   color: Colors.green,
                                                                      ),
                                                                      height:
                                                                      size.height *
                                                                          0.2,
                                                                      child: Center(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Image
                                                                                .network(
                                                                              snapshot.data!.docs[index]["productImage"].toString(),
                                                                              fit: BoxFit
                                                                                  .scaleDown,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                        children: [

                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                                color:
                                                                                redColor,
                                                                                borderRadius: BorderRadius.only(
                                                                                    topRight: Radius.circular(
                                                                                        4),
                                                                                    bottomLeft:
                                                                                    Radius.circular(4))),
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.all(
                                                                                  4.0),
                                                                              child: Text(
                                                                                  'sale',
                                                                                  style:
                                                                                  caption1White),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(
                                                                    top: 7, left: 0),
                                                                child: Align(
                                                                  alignment:
                                                                  Alignment.center,
                                                                  child: Container(
                                                                    child: Text(
                                                                      snapshot.data!.docs[index]["productName"].toString(),
                                                                      style: body3Black,
                                                                      textAlign: TextAlign
                                                                          .center,
                                                                      maxLines: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    top: 4,
                                                                    bottom: 10
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          'ر.ع. ' + snapshot.data!.docs[index]["productPrice"].toString(),
                                                                          style:
                                                                          caption3Red),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              // Padding(
                                                              //   padding: const EdgeInsets.only(bottom: 10),
                                                              //   child: Container(
                                                              //     height: 30,
                                                              //     decoration: BoxDecoration(
                                                              //         borderRadius: BorderRadius.circular(10),
                                                              //         color: primaryColor1
                                                              //     ),
                                                              //     child: Padding(
                                                              //       padding: const EdgeInsets.all(8.0),
                                                              //       child: Text('Add to cart', style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                                                              //     ),
                                                              //   ),
                                                              // ),

                                                              // Row(
                                                              //   mainAxisAlignment:
                                                              //   MainAxisAlignment
                                                              //       .center,
                                                              //   children: [
                                                              //     MaterialButton(
                                                              //       onPressed: () async {
                                                              //         if (_newArrivalsProducts[
                                                              //         index]
                                                              //             .addToCart >=
                                                              //             1) {
                                                              //           setState(() {
                                                              //             _newArrivalsProducts[
                                                              //             index]
                                                              //                 .addToCart = _newArrivalsProducts[
                                                              //             index]
                                                              //                 .addToCart -
                                                              //                 1;
                                                              //           });
                                                              //         }
                                                              //       },
                                                              //       color:
                                                              //       lightGreenColor,
                                                              //       textColor:
                                                              //       Colors.white,
                                                              //       child: Icon(
                                                              //         Icons.remove,
                                                              //         size: 17,
                                                              //         color: primaryColor,
                                                              //       ),
                                                              //       minWidth:
                                                              //       size.width * 0.06,
                                                              //       padding:
                                                              //       EdgeInsets.zero,
                                                              //       shape: CircleBorder(),
                                                              //     ),
                                                              //     Text(
                                                              //         _newArrivalsProducts[
                                                              //         index]
                                                              //             .addToCart
                                                              //             .toString(),
                                                              //         style:
                                                              //         caption1Black),
                                                              //     MaterialButton(
                                                              //       onPressed: () async {
                                                              //         setState(() {
                                                              //           _newArrivalsProducts[
                                                              //           index]
                                                              //               .addToCart =
                                                              //               _newArrivalsProducts[
                                                              //               index]
                                                              //                   .addToCart +
                                                              //                   1;
                                                              //         });
                                                              //       },
                                                              //       color: primaryColor,
                                                              //       textColor:
                                                              //       Colors.white,
                                                              //       child: Icon(
                                                              //         Icons.add,
                                                              //         size: 17,
                                                              //       ),
                                                              //       minWidth:
                                                              //       size.width * 0.06,
                                                              //       padding:
                                                              //       EdgeInsets.zero,
                                                              //       shape: CircleBorder(),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));

                                                }),
                                          ),
                                        );
                                      }
                                    },
                                  ),





                                ),
                              ],);
                            }),
                      ),
                    );
                  }
                },
              ),
            ),





          ],),
        )





    );
  }
}



class Product {
  final String image;
  final String id;
  final String sale;
  final String isNew;
  final String title;
  final String quantity;
  final String ruppes;
  bool favorite;
  int addToCart;

  Product(
      {required this.title,
        required this.id,
        required this.sale,
        required this.isNew,
        required this.quantity,
        required this.ruppes,
        required this.image,
        required this.favorite,
        required this.addToCart});
}


import 'package:flutter/material.dart';
import 'package:omani_agriculture_app/constants.dart';
import 'package:omani_agriculture_app/screens/authentication/login/login_screen.dart';
import 'package:omani_agriculture_app/screens/authentication/signup/signup_screen.dart';
class WelcomeScreen extends StatefulWidget {
  final String userType;

  const WelcomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   stops: [
          //     0.1,
          //     0.9
          //   ], colors: [
          //     lightRedColor,
          //     darkRedColor
          //   ],
          // ),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        darkRedColor,
                        lightRedColor,

                      ],
                    ),

                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                      ],
                     // border: Border.all(width: 0.5,color: Colors.black),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          darkRedColor,
                          lightRedColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                        ),

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(userType: widget.userType,)));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LoginScreen()),
                          // );
                        }, child: Text('Login', style: buttonStyle)),
                  ),

                  SizedBox(
                    height: size.height*0.025,
                  ),


                  Container(

                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                      // ],
                      border: Border.all(color: Colors.black,width: 0.5),
                      color: Colors.white,
                      // color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                        ),

                        onPressed: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                          // );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(userType: widget.userType,)));
                        }, child: Text('Sign up', style: buttonStyle.copyWith(color: Colors.black))),
                  ),

                  SizedBox(
                    height: size.height*0.08,
                  ),


                  SizedBox(
                    height: size.height*0.025,
                  ),
                ],
              ),
            ),

          ],),


      ),
    );
  }
}

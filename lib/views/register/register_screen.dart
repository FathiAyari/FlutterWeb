// @dart=2.9
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:showroom_backend/models/admin.dart';
import 'package:showroom_backend/utils/constants.dart';
import 'package:showroom_backend/views/dashboard/dashboard_screen.dart';
import 'package:showroom_backend/views/register/register_controller.dart';
import 'package:showroom_backend/widgets/app_button.dart';
import 'package:showroom_backend/widgets/app_loading.dart';
import 'package:showroom_backend/widgets/app_textfield.dart';
import 'package:showroom_backend/widgets/info_message.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = RegisterController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController test=TextEditingController();


  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Stack(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/blur_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0x22000000)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 30, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/app_logo.png", width: 150),
                          Text("Showroom",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FONT_POPPINS_MEDIUM,
                                  fontSize: 25)),
                          const SizedBox(
                            height: 30,
                          ),
                          Text("Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FONT_POPPINS_MEDIUM,
                                  fontSize: 15)),
                          SizedBox(
                            height: 50,
                          ),
                          Form(
                            child: Container(
                              width: 250,
                              height: 40,

                              child: TextFormField(
                                controller: this.registerController.emailController,
                                decoration: InputDecoration(

                                  label: Text("Email",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),




                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                            placeholder: "Username",
                            controller:
                            this.registerController.usernameController,
                            colorTheme: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppTextField.password(
                            placeholder: "Mot de passe",
                            controller:
                            this.registerController.passwordController,
                            colorTheme: Colors.white,
                            onSubmit: () {
                              registerUser(context);
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          AppButton(
                            buttonText: "S'inscrire",
                            onClickHandler: () {
                              /* if(!validateEmail("${registerController.emailController.text}")){

                                InfoMessage(message: "Veuillez verifier l'adresse email").show(context);
                              }else{
                                registerUser(context);
                              }

*/
                              registerUser(context);

                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("S'authentifier",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FONT_POPPINS_LIGHT,
                                  fontSize: 15)),
                          /* ElevatedButton(onPressed: () {

                             if(!validateEmail("${test.text}")){

                               final snackbar = SnackBar(
                                 content: Text('email is not in correct format'),
                                 backgroundColor: Colors.red,
                                 shape: StadiumBorder(),


                                 elevation: 0,
                                 duration: Duration(seconds: 1),
                               );
                               ScaffoldMessenger.of(context)
                                 ..removeCurrentSnackBar()
                                 ..showSnackBar(snackbar);

                             }
                          }, child: Text("press")),
                          Form(
                            child: TextFormField(
                              controller: test,
                              decoration: InputDecoration(

                                label: Text("test"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),




                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  registerUser(BuildContext context) {
    String str=registerController.verifyInput();
    if (str.isNotEmpty) {
      InfoMessage(message: str).show(context);
    } else {
      AppLoading().show(context);
      Database db = database();
      DatabaseReference ref = db.ref('admin_users');
      var adminUser = Admin.fromJson({
        "email": registerController.emailController.text,
        "login": registerController.usernameController.text,
        "password": registerController.passwordController.text,
      });
      var result = ref.push(adminUser.toJson());
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return DashbaordScreen(
            connectedUser: adminUser,
            userKey: result.key,
          );
        },
      ));
    }
  }
}




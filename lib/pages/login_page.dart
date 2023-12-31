import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  var _errorLoginMessage = '';
  var _errorUsername = '';
  var _errorPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4D94DA),
              Color(0xFF6F52B1)
            ], // Set your gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 26.0,
                right: 20.0,
                bottom: 6.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 84.0,
                      child: Image.asset('assets/images/logo_app.png'),
                    ),
                  ),
                  SizedBox(
                    height: 61.0,
                  ),
                  SizedBox(
                    width: 260.0,
                    child: Image.asset('assets/images/alat_img.png'),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    "ALUE'S SHRIMP",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'paladins',
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(
                    height: 92.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _errorLoginMessage != ''
                              ? Container(
                                  width: double.infinity,
                                  child: Text(
                                    _errorLoginMessage,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : SizedBox(
                                  height: 0.0,
                                ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                setState(() {
                                  _errorUsername = "Username can't be empty";
                                });
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF7DC1F1),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 90.0,
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              hintText: 'NOMOR HANDPHONE',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 9.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                setState(() {
                                  _errorUsername = "Username can't be empty";
                                });
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefix: Container(
                                width: 10.0,
                              ),
                              filled: true,
                              fillColor: Color(0xFF7DC1F1),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 120.0,
                              ),
                              labelStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              hintText: 'PASSWORD',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

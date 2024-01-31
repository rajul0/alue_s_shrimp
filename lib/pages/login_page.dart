import 'package:alues_shrimp_app/pages/home_page/home_page_navbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var _errorLoginMessage = '';

  var _noHp = '';
  var _password = '';

  void _login() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: '${_noHp}@as.com', password: _password);
      // mendapatkan sebagai akunnya
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePageNav()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _errorLoginMessage = 'User tidak ditemukan.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _errorLoginMessage = 'No HP atau password yang anda masukkan salah';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          _errorLoginMessage = 'No HP atau password yang anda masukkan salah';
        });
      } else {
        setState(() {
          _errorLoginMessage = 'Terdapat kesalahan, coba lagi beberapa saat';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                                return "Nomor Hp tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _errorLoginMessage = '';
                                _noHp = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefix: SizedBox(width: 30.0),
                              filled: true,
                              fillColor: Color(0xFF7DC1F1),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
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
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
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
                                return "Password tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _errorLoginMessage = '';
                                _password = value;
                              });
                            },
                            decoration: InputDecoration(
                              prefix: SizedBox(width: 30.0),
                              filled: true,
                              fillColor: Color(0xFF7DC1F1),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
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
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  backgroundColor: Color(0xFF7DC1F1),
                                  elevation: 0.0,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  } else {
                                    setState(() {
                                      _autoValidateMode =
                                          AutovalidateMode.always;
                                    });
                                  }
                                },
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontFamily: 'ComicNeue',
                                    fontSize: 22.0,
                                    color: Color(0xFF263A48),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )
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

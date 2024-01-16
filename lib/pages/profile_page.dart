import 'package:alues_shrimp_app/pages/component/popUp.dart';
import 'package:alues_shrimp_app/proses/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool editState = true;

  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _sandiLamaController = TextEditingController();
  TextEditingController _sandiController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String? _userId;

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userId = auth.currentUser!.uid;
    _ambilDataUser();
  }

  void _ambilDataUser() async {
    data = await getDataUser(_userId);

    Future.delayed(Duration(seconds: 2));
    setState(() {
      _namaController = TextEditingController(text: data![0]['nama_pengguna']);
      _emailController = TextEditingController(text: data[0]['email']);
      _noHpController =
          TextEditingController(text: '0${data[0]['no_hp'].toString()}');
    });

    print(data);
  }

  void _simpan() async {
    List<Map<String, dynamic>> dataPenggunaTerbaru = [
      {
        'uid': _userId,
        'no_hp': int.parse(_noHpController.text),
        'nama_pengguna': _namaController.text.toString(),
        'email': _emailController.text.toString(),
      }
    ];

    if (data[0]['no_hp'] != dataPenggunaTerbaru[0]['no_hp'] ||
        data[0]['nama_pengguna'] != dataPenggunaTerbaru[0]['nama_pengguna'] ||
        data[0]['email'] != dataPenggunaTerbaru[0]['email']) {
      updateField();
    } else if (_sandiController.text.length >= 8) {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: '${_noHpController.text}@as.com',
        password: _sandiLamaController.text,
      );
      await userCredential.user!.updatePassword(_sandiController.text);

      popUpBerhasilEditProfile(context);
    } else if (_sandiController.text.length >= 1 &&
        _sandiController.text.length < 8) {
      popUbahSandiError(context);
    }
  }

  void updateField() async {
    try {
      // Perbarui field di Firestore
      QuerySnapshot querySnapshot =
          await _db.collection('akun').where('uid', isEqualTo: _userId).get();

      // update data pengguna
      if (querySnapshot.docs.isNotEmpty &&
          (_sandiController.text.length >= 8 || _sandiController.text == '')) {
        String docId = querySnapshot.docs.first.id;

        _db.collection('akun').doc(docId).update({
          'nama_pengguna': _namaController.text,
          'no_hp': int.parse(_noHpController.text),
          'email': _emailController.text,
        });

        // update display name atau nama pengguna
        await auth.currentUser!.updateDisplayName(_namaController.text);
        await auth.currentUser!.reload();

        // update password jika ada perubahan
        if (_sandiController.text.length >= 8) {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: '${_noHpController.text}@as.com',
            password: _sandiLamaController.text,
          );
          await userCredential.user!.updatePassword(_sandiController.text);
        }
        popUpBerhasilEditProfile(context);
      } else if (_sandiController.text.length >= 1 &&
          _sandiController.text.length < 8) {
        popUbahSandiError(context);
      } else {
        print('Dokumen tidak ditemukan.');
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      print('Terjadi kesalahan: $e');
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
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 130.0,
                      child: Image.asset('assets/icons/add_profile.png'),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          editState = !editState;
                        });
                      },
                      child: Text(
                        editState ? 'Edit' : 'Selesai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'ComicNeue',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Nama Pengguna',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _namaController,
                            readOnly: editState,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Nama Pengguna tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {});
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
                              hintText: '',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            readOnly: editState,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Email tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {});
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
                              hintText: '',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Nomor Hp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _noHpController,
                            readOnly: editState,
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
                              setState(() {});
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
                              hintText: '',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Kata Sandi Lama',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _sandiLamaController,
                            readOnly: editState,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Kata Sandi Lama tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {});
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
                              hintText: '',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Kata Sandi Baru',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _sandiController,
                            readOnly: editState,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ComicNeue',
                            ),
                            validator: (value) {
                              if (value == '') {
                                return "Kata Sandi Baru tidak boleh kosong";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {});
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
                              hintText: '',
                              hintStyle: TextStyle(
                                  color: Color(0xFF4B7491),
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2D846F),
                                    width: 2.0,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          SizedBox(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 30.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor: Color(0xFFD9D9D9),
                                  elevation: 0.0,
                                ),
                                onPressed: () {
                                  if (editState == false) {
                                    _simpan();
                                    print(editState);
                                  } else {
                                    null;
                                  }
                                },
                                child: Text(
                                  'Simpan',
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:alues_shrimp_app/pages/home_page/component/feedCalenderCard.dart';
import 'package:alues_shrimp_app/pages/home_page/component/indexPhCard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();

  String? displayName = '';
  String? waktu = '';

  void initState() {
    super.initState();

    _getDisplayName();
    _getDateTime();
  }

  void _getDateTime() {
    String dayName = DateFormat('EEEE', 'id_ID').format(now); // Nama hari
    String monthName = DateFormat('MMMM', 'id_ID').format(now); // Nama bulan
    int day = now.day;
    int year = now.year;

    waktu =
        '${dayName} / ${day.toString()} - ${monthName} - ${year.toString()}';
  }

  void _getDisplayName() {
    User? user = auth.currentUser;

    if (user != null) {
      // Mendapatkan display name dari user

      if (displayName != null) {
        displayName = user.displayName;

        // Jika displayName tidak null, cetak nilainya
        print('Display Name: $displayName');
      } else {
        print('Display Name tidak tersedia');
      }
    } else {
      print('Pengguna tidak masuk');
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
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Halo ${displayName}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: 'Inter'),
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${waktu}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Inter'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Indeks pH saat ini',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      )),
                  indexPhCard(),
                  SizedBox(
                    height: 68.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Kalender Pakan Saya',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 16.0),
                    ),
                  ),
                  FeedCalenderCard(),
                  SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/udang_hijau.png',
                        width: 18.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Pemberian Pakan selesai',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/udang_kuning.png',
                        width: 18.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Pemebrian Pakan sedang berlangsung',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/udang_merah.png',
                        width: 18.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Pemberian Pakan akan segera dilakukan',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14.0),
                      ),
                    ],
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

import 'package:alues_shrimp_app/pages/component/historyPhCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaterQualityPage extends StatefulWidget {
  const WaterQualityPage({super.key});

  @override
  State<WaterQualityPage> createState() => _WaterQualityPageState();
}

class _WaterQualityPageState extends State<WaterQualityPage> {
  final databaseReference = FirebaseDatabase.instance.ref('/');

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
                      height: 70.0,
                      child: Image.asset('assets/images/logo_app.png'),
                    ),
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StreamBuilder(
                          stream: databaseReference.child('index_ph').onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.snapshot.value != null) {
                              var data = snapshot.data!.snapshot.value;
                              String valuePh =
                                  (double.parse(data.toString())).toString();

                              return Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4882B8),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 20.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Indeks pH',
                                          style: TextStyle(
                                              color: Color(0xFFAFBEC5),
                                              fontSize: 15.0,
                                              fontFamily: 'Inter'),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          valuePh,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35.0,
                                            fontFamily: 'Inter',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Text(
                                'Loading ...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: 'Inter',
                                ),
                              );
                            }
                          }),
                      SizedBox(
                        height: 138.0,
                        child: Image.asset('assets/images/ph_img.png'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Riwayat pH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 190.0,
                    child: historyPhCard(
                      context,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Warna Indikator pH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  infopHCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

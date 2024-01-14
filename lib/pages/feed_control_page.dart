import 'package:alues_shrimp_app/pages/home_page/component/feedCalenderCard.dart';
import 'package:alues_shrimp_app/pages/home_page/component/feedingSettingCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedControlPage extends StatefulWidget {
  const FeedControlPage({super.key});

  @override
  State<FeedControlPage> createState() => _FeedControlPageState();
}

class _FeedControlPageState extends State<FeedControlPage> {
  DateTime now = DateTime.now();
  String waktu = '';

  void initState() {
    super.initState();

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
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 84.0,
                          child: Image.asset('assets/images/logo_app.png'),
                        ),
                      ),
                      SizedBox(
                        width: 29.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50.0,
                              child: Image.asset('assets/icons/ceklist_ic.png'),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Pemberian Pakan \n Sedang Berlangsung',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Inter',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  waktu,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontFamily: 'Inter',
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28.0,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Riwayat Pakan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: FeedCalenderCard(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  FeedingSettingCard(
                    jamMulai: now,
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

import 'package:alues_shrimp_app/pages/feed_control_page/feeding_setting_page.dart';
import 'package:alues_shrimp_app/pages/home_page/component/feedCalenderCard.dart';
import 'package:alues_shrimp_app/pages/feed_control_page/component/feedingSettingCard.dart';
import 'package:alues_shrimp_app/pages/home_page/home_page_navbar.dart';
import 'package:alues_shrimp_app/proses/get_data.dart';
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

  String pesanPemberianPakan = '';

  void initState() {
    super.initState();

    getStatusPemberianPakan();
    _getDateTime();
    Future.delayed(Duration(seconds: 1));
  }

  void _getDateTime() {
    String dayName = DateFormat('EEEE', 'id_ID').format(now); // Nama hari
    String monthName = DateFormat('MMMM', 'id_ID').format(now); // Nama bulan
    int day = now.day;
    int year = now.year;

    waktu =
        '${dayName} / ${day.toString()} - ${monthName} - ${year.toString()}';
  }

  Future fetchData() async {
    return await getDataAlarm();
  }

  void updateState() {
    setState(() {});
  }

  Future getStatusPemberianPakan() async {
    var dataFuture = getPengaturanPakan();
    var data = await dataFuture;

    return data;
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
                top: 50.0,
                right: 20.0,
                bottom: 6.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageNav(),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 70.0,
                            child: Image.asset('assets/images/logo_app.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 29.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
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
                                FutureBuilder(
                                    future: getStatusPemberianPakan(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Ketika data masih dimuat, tampilkan indikator loading
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // Ketika terjadi error dalam pengambilan data
                                        return Text(
                                            'Error: ${snapshot.hasError}');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data.isEmpty) {
                                        return Text(
                                          'Belum ada \n Pengaturan pakan',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            fontFamily: 'Inter',
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        var data = snapshot.data;
                                        if (data
                                            .toString()
                                            .contains('sedang berlangsung')) {
                                          return Text(
                                            'Pemberian pakan \n sedang berlangsung',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              fontFamily: 'Inter',
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return Text(
                                            'Pemberian pakan \n segera dilakukan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              fontFamily: 'Inter',
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      }
                                    }),
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
                  FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Ketika data masih dimuat, tampilkan indikator loading
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Ketika terjadi error dalam pengambilan data
                        return Text('Error: ${snapshot.hasError}');
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          "Belum ada ",
                          style: TextStyle(
                              fontFamily: 'Inria Sans',
                              fontSize: 14.0,
                              color: Color(0xFFBFBFBF)),
                        );
                      } else {
                        var data = snapshot.data;
                        return Column(
                          children: List.generate(
                            data.length,
                            (index) => Column(
                              children: [
                                FeedingSettingCard(
                                  updateParent: updateState,
                                  jamMulai: data[index]['jam_mulai'],
                                  data: data[index],
                                  isSwitched: data[index]['status_hidup'],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFD9D9D9),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FeedingSettingPage(
                updateParent: updateState,
              ),
            ),
          );
        },
        child: Icon(Icons.add), // Ikon di dalam Floating Action Button
      ),
    );
  }
}

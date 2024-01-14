import 'package:alues_shrimp_app/proses/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget historyPhCard(
  BuildContext context,
) {
  Future _fetchData() async {
    return await getDataIndexpH();
  }

  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF9CB3D9),
      borderRadius: BorderRadius.all(
        Radius.circular(
          10.0,
        ),
      ),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              "Belum ada riwayat indeks pH",
              style: TextStyle(
                  fontFamily: 'Inria Sans',
                  fontSize: 14.0,
                  color: Color(0xFF878585)),
            );
          } else {
            List items = snapshot.data!;
            List<FlSpot> spots = [];
            int index = 0;

            for (var data in items) {
              // Assuming 'value' is the field you want to use
              double value = double.parse(data['indeks_pH'].toString()) ?? 0.0;

              spots.add(FlSpot(index.toDouble(), value.toDouble()));
              index++;
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(items.length, (index) {
                    Timestamp timestamp = items[index]['jam'];

                    DateTime date = timestamp.toDate();
                    String jam = DateFormat.Hm().format(date);

                    String indekspH = items[index]['indeks_pH'].toString();

                    return oneTimeHistorypH(context, jam, indekspH);
                  }),
                ),
                Expanded(
                  child: SizedBox(
                    width: 67.0 * items.length,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 2.0, top: 25.0, bottom: 25.0),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              color: Colors.black,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    ),
  );
}

Widget oneTimeHistorypH(
  BuildContext context,
  String jam,
  String indekspH,
) {
  String imgpH = '';

  if (double.parse(indekspH) >= 0 && double.parse(indekspH) < 1) {
    imgpH = 'assets/icons/index_ph_0.png';
  } else if (double.parse(indekspH) >= 1 && double.parse(indekspH) < 2) {
    imgpH = 'assets/icons/index_ph_1.png';
  } else if (double.parse(indekspH) >= 2 && double.parse(indekspH) < 3) {
    imgpH = 'assets/icons/index_ph_2.png';
  } else if (double.parse(indekspH) >= 3 && double.parse(indekspH) < 4) {
    imgpH = 'assets/icons/index_ph_3.png';
  } else if (double.parse(indekspH) >= 4 && double.parse(indekspH) < 5) {
    imgpH = 'assets/icons/index_ph_4.png';
  } else if (double.parse(indekspH) >= 5 && double.parse(indekspH) < 6) {
    imgpH = 'assets/icons/index_ph_5.png';
  } else if (double.parse(indekspH) >= 6 && double.parse(indekspH) < 7) {
    imgpH = 'assets/icons/index_ph_6.png';
  } else if (double.parse(indekspH) >= 7 && double.parse(indekspH) < 8) {
    imgpH = 'assets/icons/index_ph_7.png';
  } else if (double.parse(indekspH) >= 8 && double.parse(indekspH) < 9) {
    imgpH = 'assets/icons/index_ph_8.png';
  } else if (double.parse(indekspH) >= 9 && double.parse(indekspH) < 10) {
    imgpH = 'assets/icons/index_ph_9.png';
  } else if (double.parse(indekspH) >= 10 && double.parse(indekspH) < 11) {
    imgpH = 'assets/icons/index_ph_10.png';
  } else if (double.parse(indekspH) >= 11 && double.parse(indekspH) < 12) {
    imgpH = 'assets/icons/index_ph_11.png';
  } else if (double.parse(indekspH) >= 12 && double.parse(indekspH) < 13) {
    imgpH = 'assets/icons/index_ph_12.png';
  } else if (double.parse(indekspH) >= 13 && double.parse(indekspH) < 14) {
    imgpH = 'assets/icons/index_ph_13.png';
  } else if (double.parse(indekspH) == 14) {
    imgpH = 'assets/icons/index_ph_14.png';
  }

  return SizedBox(
    height: 110.0,
    width: 80.0,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${jam} WIB',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            indekspH,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 35.0,
            child: Image.asset(
              imgpH,
            ),
          )
        ],
      ),
    ),
  );
}

Widget infopHCard() {
  return SizedBox(
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF9CB3D9),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 10.0,
          right: 10.0,
          bottom: 8.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_0.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_1.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_2.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_3.png'),
                    ),
                  ],
                ),
                Text(
                  'Sangat Asam',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Inter',
                  ),
                )
              ],
            ),
            SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_4.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_5.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_6.png'),
                    ),
                  ],
                ),
                Text(
                  'Asam',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_7.png'),
                    ),
                  ],
                ),
                Text(
                  'Netral',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_8.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_9.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_10.png'),
                    ),
                  ],
                ),
                Text(
                  'Basa',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_11.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_12.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_13.png'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 39.0,
                      child: Image.asset('assets/icons/index_ph_14.png'),
                    ),
                  ],
                ),
                Text(
                  'Sangat Asam',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

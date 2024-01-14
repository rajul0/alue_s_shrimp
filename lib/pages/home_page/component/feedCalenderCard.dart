import 'package:alues_shrimp_app/proses/get_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FeedCalenderCard extends StatefulWidget {
  const FeedCalenderCard({super.key});

  @override
  State<FeedCalenderCard> createState() => _FeedCalenderCardState();
}

class _FeedCalenderCardState extends State<FeedCalenderCard> {
  Future fetchData() async {
    return await getPengaturanPakan();
  }

  DateTime? parseTimeString(String timeString) {
    try {
      // Assuming the time is in the format "HH:mm"
      List<String> parts = timeString.split(':');

      if (parts.length == 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        DateTime parsedTime = DateTime(0, 1, 1, hour, minute);
        return parsedTime;
      } else {
        throw FormatException('Invalid time format');
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 60.0),
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (snapshot.hasError) {
            // Ketika terjadi error dalam pengambilan data
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              "Belum ada pengaturan jadwal pemberian Pakan",
              style: TextStyle(
                  fontFamily: 'Inria Sans',
                  fontSize: 14.0,
                  color: Color(0xFF878585)),
            );
          } else {
            List items = snapshot.data!;

            return Row(
              children: List.generate(items.length, (index) {
                // tanggal pemberian pakan
                Timestamp datePemberianPakan =
                    items[index]['tanggal_pemberian_pakan'];
                DateTime datePemberianPakanConvert =
                    datePemberianPakan.toDate();

                // waktu mulai pemberian pakan
                DateTime? timeMulai =
                    parseTimeString(items[index]['jam_mulai']);

                // waktu mulai pemberian pakan
                DateTime? timeSelesai =
                    parseTimeString(items[index]['jam_selesai']);

                //waktu pembelian pakan
                List feedingTime = [timeMulai, timeSelesai];

                var statusFeeding =
                    items[index]['status_pemberian']; // status pemeberian pakan

                var feedingPortion = items[index]
                    ['porsi_pakan']; // porsi pemberian pakan per menit

                return oneFeedTimeCard(context, datePemberianPakanConvert,
                    feedingTime, statusFeeding, feedingPortion);
              }),
            );
          }
        },
      ),
    );
  }

  Widget oneFeedTimeCard(BuildContext context, DateTime date, List feedingTime,
      statusFeeding, feedPortion) {
    var imgPath = '';

    if (statusFeeding == 'segera dilakukan') {
      imgPath = 'assets/images/udang_merah.png';
    } else if (statusFeeding == 'selesai') {
      imgPath = 'assets/images/udang_hijau.png';
    } else {
      imgPath = 'assets/images/udang_kuning.png';
    }

    DateFormat dateFormat = DateFormat.yMMMMd('id_ID'); // tanggal
    var tanggal = dateFormat.format(date); // tanggal

    DateFormat jamFormat = DateFormat('HH:mm'); // jam mulai

    var jamMulai = jamFormat.format(feedingTime[0]); // jam Mulai
    var jamSelesai = jamFormat.format(feedingTime[1]); // jam selesai

    return SizedBox(
      width: 91.0,
      child: Container(
        child: Column(children: [
          SizedBox(
            height: 48.0,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF6582B5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 5.0, bottom: 3.0, left: 5.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    tanggal,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Container(
                color: Color(0xFF3E5677),
                width: 1.0,
                height: 90.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imgPath, // Ganti dengan path gambar yang sesuai
                    width: 20.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '${jamMulai} WIB',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'CominNeue',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'CominNeue',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${jamSelesai} WIB',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontFamily: 'CominNeue',
                      fontSize: 13.0,
                    ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Text(
                    jamMulai,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 13.0,
                    ),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}

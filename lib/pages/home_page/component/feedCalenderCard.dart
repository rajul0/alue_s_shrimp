import 'package:flutter/material.dart';

class FeedCalenderCard extends StatefulWidget {
  const FeedCalenderCard({super.key});

  @override
  State<FeedCalenderCard> createState() => _FeedCalenderCardState();
}

class _FeedCalenderCardState extends State<FeedCalenderCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          oneFeedTimeCard(
              '1 Desember 2023', ['08:00', '09:00'], 'mendatang', '100'),
          oneFeedTimeCard(
              '1 Desember 2023', ['08:00', '09:00'], 'mendatang', '100'),
          oneFeedTimeCard('1 Mei 2023', ['08:00', '09:00'], 'mendatang', '100'),
          oneFeedTimeCard(
              '1 Desember 2023', ['08:00', '09:00'], 'mendatang', '100'),
          oneFeedTimeCard(
              '1 Desember 2023', ['08:00', '09:00'], 'mendatang', '100'),
        ],
      ),
    );
  }

  Widget oneFeedTimeCard(date, List feedingTime, statusFeeding, feedPortion) {
    var imgPath = '';

    if (statusFeeding == 'mendatang') {
      imgPath = 'assets/images/udang_merah.png';
    } else if (statusFeeding == 'selesai') {
      imgPath = 'assets/images/udang_hijau.png';
    } else {
      imgPath = 'assets/images/udang_kuning.png';
    }

    return SizedBox(
      width: 91.0,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF5377B4),
        ),
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
                    date,
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
                    '${feedingTime[0]} WIB',
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
                    '${feedingTime[1]} WIB',
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
                    feedingTime[0],
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

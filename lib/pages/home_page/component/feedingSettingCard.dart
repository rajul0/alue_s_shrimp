import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedingSettingCard extends StatefulWidget {
  final DateTime jamMulai;
  bool isSwitched = false;

  FeedingSettingCard({
    Key? key,
    required this.jamMulai,
  }) : super(key: key);

  @override
  State<FeedingSettingCard> createState() => _FeedingSettingCardState();
}

class _FeedingSettingCardState extends State<FeedingSettingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pemberian pakan pertama',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontFamily: 'Inter',
                  ),
                ),
                Switch(
                  value: widget.isSwitched,
                  onChanged: (value) {
                    setState(() {
                      widget.isSwitched = value;
                    });
                  },
                  inactiveTrackColor: Color(0xFF7A757F),
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: 7.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '08:00 WIB',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Mode pemberian pakan',
                style: TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
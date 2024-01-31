import 'package:alues_shrimp_app/pages/feed_control_page/feeding_setting_page.dart';
import 'package:alues_shrimp_app/proses/proses_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeedingSettingCard extends StatefulWidget {
  final updateParent;
  String jamMulai;
  Map data;
  bool isSwitched;

  FeedingSettingCard({
    Key? key,
    required this.updateParent,
    required this.jamMulai,
    required this.data,
    required this.isSwitched,
  }) : super(key: key);

  @override
  State<FeedingSettingCard> createState() => _FeedingSettingCardState();
}

class _FeedingSettingCardState extends State<FeedingSettingCard> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedingSettingPage(
              dataJadwal: widget.data,
              updateParent: widget.updateParent,
            ),
          ),
        );
      },
      child: Container(
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
                    widget.data['judul'].toString(),
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
                        if (widget.isSwitched == true) {
                          hidupkanJadwalPakan(widget.data, widget.updateParent);
                        } else {
                          matikanJadwalPakan(widget.data, widget.updateParent);
                        }
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
                    '${widget.jamMulai} WIB',
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardIndexPh extends StatefulWidget {
  const CardIndexPh({super.key});

  @override
  State<CardIndexPh> createState() => _CardIndexPhState();
}

class _CardIndexPhState extends State<CardIndexPh>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final databaseReference = FirebaseDatabase.instance.ref('/');

  double _currentValue = 0.5; // Nilai dari database

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller animasi
    _controller = AnimationController(
      duration: Duration(seconds: 14), // Durasi animasi
      vsync: this,
    );

    // Mulai animasi
    _controller.forward();
  }

  List<Color> phColor = [
    Color(0xFFF14A5E),
    Color(0xFFF57B54),
    Color(0xFFF8A44E),
    Color(0xFFFAD948),
    Color(0xFFC8E445),
    Color(0xFFB7DF44),
    Color(0xFF83CF4B),
    Color(0xFF78CB4B),
    Color(0xFF67C75F),
    Color(0xFF6BCA84),
    Color(0xFF75D2ED),
    Color(0xFF6281C9),
    Color(0xFF5857B0),
    Color(0xFF6A58B1)
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFC2DAF7),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: databaseReference.child('index_ph').onValue,
                  builder: (context, snapshot) {
                    if (mounted) {
                      if (snapshot.hasData &&
                          snapshot.data!.snapshot.value != null) {
                        var data = snapshot.data!.snapshot.value;

                        var title = data.toString();

                        return RotationTransition(
                          turns: Tween<double>(
                                  begin: 0.0, end: double.parse(title))
                              .animate(_controller),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            size: 48.0,
                            color: Colors.blue,
                          ),
                        );
                      } else {
                        print(snapshot.hasData);
                        return SizedBox(
                          height: 35.0,
                          child: Image.asset('assets/icons/arrow_down.png'),
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
              IntrinsicWidth(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: List.generate(14, (index) {
                              return phIndicator(context,
                                  (index + 1).toString(), phColor[index]);
                            }),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phIndicator(
    BuildContext context,
    String phNumber,
    Color color,
  ) {
    return SizedBox(
        child: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22.0,
          decoration: BoxDecoration(
            color: Color(0xFFC1EAEB),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              phNumber,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Inter',
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Container(
          width: 22.0,
          height: 65.0,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
      ],
    )));
  }
}

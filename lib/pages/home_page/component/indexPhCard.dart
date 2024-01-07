import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class indexPhCard extends StatefulWidget {
  const indexPhCard({super.key});

  @override
  State<indexPhCard> createState() => _indexPhCardState();
}

class _indexPhCardState extends State<indexPhCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final databaseReference = FirebaseDatabase.instance.ref('/');

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller animasi
    _controller = AnimationController(
      duration: Duration(seconds: 1), // Durasi animasi
      vsync: this,
    );
    final databaseReference = FirebaseDatabase.instance.ref('/');
    databaseReference.child('index_ph').onValue.listen((DatabaseEvent event) {
      double value = double.parse(event.snapshot.value.toString());
      // Sesuaikan rentang nilai berdasarkan kebutuhan Anda
      double normalizedValue = (value - 0.0) / (14.0 - 0.0);
      _controller.value =
          normalizedValue.clamp(0.0, 1.0); // Clamp nilai antara 0 dan 1
    });
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
    Color(0xFF6A58B1),
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: StreamBuilder(
                    stream: databaseReference.child('index_ph').onValue,
                    builder: (context, snapshot) {
                      if (mounted) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          var data = snapshot.data!.snapshot.value;
                          double valuePh = double.parse(data.toString());

                          var nilaiPhConvert = valuePh / 15.9;

                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(nilaiPhConvert, 0.0),
                              end: Offset(nilaiPhConvert, 0.0),
                            ).animate(_controller),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  height: 35.0,
                                  child: Image.asset(
                                      'assets/icons/arrow_down.png'),
                                )),
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
              ),
              IntrinsicWidth(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: List.generate(15, (index) {
                              return phIndicator(
                                  context, (index).toString(), phColor[index]);
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
          width: 21.0,
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
          width: 21.0,
          height: 65.0,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
      ],
    )));
  }
}

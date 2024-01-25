import "package:alues_shrimp_app/proses/proses_data.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// ignore: must_be_immutable
class FeedingSettingPage extends StatefulWidget {
  Map dataJadwal;
  bool isSwitched = false;

  FeedingSettingPage({
    Key? key,
    this.dataJadwal = const {},
  }) : super(key: key);

  @override
  _FeedingSettingPageState createState() => _FeedingSettingPageState();
}

class _FeedingSettingPageState extends State<FeedingSettingPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  // data pengaturan pakan
  String _judul = '';

  String _selectedHour = '00';
  String _selectedMinute = '00';

  String _jamMulai = '00';
  String _menitMulai = '00';

  String _jamSelesai = '00';
  String _menitSelesai = '00';

  String? _pilihWaktu;
  String? _atur;

  int _banyakPakanPerMenit = 0;

  Map<String, dynamic> data = {};

  List<Map<String, dynamic>> days = [
    {'day': 'senin', 'status': false, 'simbol': 'S'},
    {'day': 'selasa', 'status': false, 'simbol': 'S'},
    {'day': 'rabu', 'status': false, 'simbol': 'R'},
    {'day': 'kamis', 'status': false, 'simbol': 'K'},
    {'day': 'jumat', 'status': false, 'simbol': 'J'},
    {'day': 'sabtu', 'status': false, 'simbol': 'S'},
    {'day': 'minggu', 'status': false, 'simbol': 'M'},
  ];

  void setDayPakan(index) {
    days[index]['status'] = !days[index]['status']!;
  }

  void _selectTime(String? waktu, {jam = '00', menit = '00'}) {
    if (waktu == 'mulai') {
      if (_atur == 'jam') {
        _jamMulai = jam;
        _selectedHour = jam;
      } else if (_atur == 'menit') {
        _menitMulai = menit;
        _selectedMinute = menit;
      }
    } else if (waktu == 'selesai') {
      if (_atur == 'jam') {
        _jamSelesai = jam;
        _selectedHour = jam;
      } else if (_atur == 'menit') {
        _menitSelesai = menit;
        _selectedMinute = menit;
      }
    }
  }

  List<String> getSelectedDays(List<Map<String, dynamic>> days) {
    List<String> selectedDays = [];

    for (var day in days) {
      if (day['status']) {
        selectedDays.add(day['day']);
      }
    }

    return selectedDays;
  }

  void simpanData() async {
    if (widget.dataJadwal.isNotEmpty) {
      data['judul'] = _judul;
      data['jam_mulai'] = '$_jamMulai:$_menitMulai';
      data['jam_selesai'] = '$_jamSelesai:$_menitSelesai';
      data['porsi_pakan'] = _banyakPakanPerMenit;
      data['hari_pemberian_pakan'] = getSelectedDays(days);

      var info = await updateJadwalPakan(data, widget.dataJadwal['doc_id']);

      if (info == 'berhasil') {
        Navigator.pop(context);
      } else {}
    } else {
      if (_judul == '') {
        data['judul'] = 'Tidak ada judul';
      } else {
        data['judul'] = _judul;
      }
      data['jam_mulai'] = '$_jamMulai:$_menitMulai';
      data['jam_selesai'] = '$_jamSelesai:$_menitSelesai';
      data['porsi_pakan'] = _banyakPakanPerMenit;
      data['hari_pemberian_pakan'] = getSelectedDays(days);
      data['status_hidup'] = false;
      try {
        await firestore.collection('pengaturan_jadwal_pakan').add(data);

        Navigator.pop(context);
      } catch (e) {}
    }
  }

  void initState() {
    super.initState();
    if (widget.dataJadwal.isNotEmpty) {
      int colonIndex = widget.dataJadwal['jam_mulai'].toString().indexOf(':');
      _judul = widget.dataJadwal['judul'];
      _jamMulai =
          widget.dataJadwal['jam_mulai'].toString().substring(0, colonIndex);

      _menitMulai =
          widget.dataJadwal['jam_mulai'].toString().substring(colonIndex + 1);

      _jamSelesai =
          widget.dataJadwal['jam_selesai'].toString().substring(0, colonIndex);

      _menitSelesai =
          widget.dataJadwal['jam_mulai'].toString().substring(colonIndex + 1);

      _banyakPakanPerMenit = widget.dataJadwal['porsi_pakan'];

      for (String hari in widget.dataJadwal['hari_pemberian_pakan']) {
        for (int i = 0; i < days.length; i++) {
          if (hari == days[i]['day']) {
            days[i]['status'] = true;
          }
        }
      }
    }
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
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(0.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      top: 26.0,
                      right: 20.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dropdown untuk Jam
                        DropdownButton<String>(
                          value: _selectedHour,
                          onChanged: (String? newValue) {
                            setState(() {
                              _atur = 'jam';
                              _selectTime(_pilihWaktu, jam: newValue);
                            });
                          },
                          dropdownColor: Color(0xFF5479AF),
                          items: List.generate(24, (index) {
                            return DropdownMenuItem(
                              value: index.toString().padLeft(2, '0'),
                              child: Text(
                                index.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        // Dropdown untuk Menit
                        DropdownButton<String>(
                          value: _selectedMinute,
                          onChanged: (String? newValue) {
                            setState(() {
                              _atur = 'menit';
                              _selectTime(_pilihWaktu, menit: newValue);
                            });
                          },
                          dropdownColor: Color(0xFF5479AF),
                          items: List.generate(60, (index) {
                            return DropdownMenuItem(
                              value: index.toString().padLeft(2, '0'),
                              child: Text(
                                index.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 21.0,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF527AB0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Setiap Hari',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'ComicNeue'),
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(days.length, (index) {
                                var oneDay = days[index]['day'];
                                var simbol = days[index]['simbol'];
                                return daySelectButton(index, oneDay, simbol);
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _judul = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Judul',
                              hintStyle: TextStyle(
                                color: Color(0xFFC2C2C2),
                                fontSize: 16.0,
                                fontFamily: 'Inter',
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white), // underline color
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .white), // focused underline color
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Lamanya Pemberian Pakan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'ComicNeue',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 19.0,
                                child:
                                    Image.asset('assets/icons/calender_ic.png'),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _pilihWaktu = 'mulai';
                                    _selectedHour = _jamMulai;
                                    _selectedMinute = _menitMulai;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: _pilihWaktu == 'mulai'
                                      ? Color(0xFF707070).withOpacity(0.5)
                                      : null,
                                ),
                                child: Text(
                                  '${_jamMulai} : ${_menitMulai} WIB',
                                  style: TextStyle(
                                    color: Color(0xFFFFC107),
                                    fontSize: 16.0,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: Color(0xFFFFC107),
                                  fontSize: 16.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _pilihWaktu = 'selesai';
                                    _selectedHour = _jamSelesai;
                                    _selectedMinute = _menitSelesai;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: _pilihWaktu == 'selesai'
                                      ? Color(0xFF707070).withOpacity(0.5)
                                      : null,
                                ),
                                child: Text(
                                  ' ${_jamSelesai} : ${_menitSelesai} WIB',
                                  style: TextStyle(
                                    color: Color(0xFFFFC107),
                                    fontSize: 16.0,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Jeda Pemberian Pakan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'ComicNeue',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 19.0,
                                child:
                                    Image.asset('assets/icons/calender_ic.png'),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  popUpJedaPakan(
                                    context,
                                  );
                                },
                                child: Text(
                                  '${_banyakPakanPerMenit} gram/',
                                  style: TextStyle(
                                    color: Color(0xFFFFC107),
                                    fontSize: 16.0,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'menit',
                                style: TextStyle(
                                  color: Color(0xFFFFC107),
                                  fontSize: 16.0,
                                  fontFamily: 'ComicNeue',
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'ComicNeue',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      simpanData();
                    },
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'ComicNeue',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget daySelectButton(
    index,
    day,
    simbol,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          setDayPakan(index);
        });
      },
      child: Container(
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFFFFC107),
            width: 2.0,
            style:
                days[index]['status']! ? BorderStyle.solid : BorderStyle.none,
          ),
        ),
        child: Text(
          simbol,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'ComicNeue',
          ),
        ),
      ),
    );
  }

  Future popUpJedaPakan(
    context,
  ) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    int _beratPakan = 0;

    // void prosesJemput() {
    //   ubahStatusLaporan(idLaporan, 'proses', petugas: _dijemputOleh);
    //   Navigator.pop(context);
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: ((context) => LaporanPosPage()),
    //     ),
    //   );
    //   popUpProsesLaporan(context);
    // }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 28.0),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Berat pakan (gram)',
                        labelStyle: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 14.0,
                            fontFamily: 'ComicNeue'),
                        contentPadding: EdgeInsets.only(
                          top: 13.0,
                          bottom: 12.0,
                          left: 18.0,
                          right: 18.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Color(0xFF2D846F))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Color(0xFF2D846F)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Color(0xFF2D846F)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF000000),
                        fontFamily: 'ComicNeue',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Masukkan berat pakan per menit';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _beratPakan = int.parse(value!);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 6,
                            backgroundColor: Color(0xFFD90000),
                          ),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _banyakPakanPerMenit = _beratPakan;
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 6.0,
                            backgroundColor: Color(0xFF6859B8),
                          ),
                          child: Text(
                            'Selesai',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

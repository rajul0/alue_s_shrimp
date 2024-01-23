import 'package:cloud_firestore/cloud_firestore.dart';

void hidupkanJadwalPakan(dataJadwal) async {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  try {
    if (dataJadwal['hari_pemberian_pakan'].isNotEmpty) {
      // Map untuk simpan data
      Map<String, dynamic> dataForFirebase = {
        'doc_id_ref': '',
        'berulang': true,
        'data': {}
      };

      for (String data in dataJadwal['hari_pemberian_pakan']) {
        var dataSatuHari = {};
        dataSatuHari['jam_mulai'] = dataJadwal['jam_mulai'];
        dataSatuHari['jam_selesai'] = dataJadwal['jam_selesai'];
        dataSatuHari['porsi_pakan'] = dataJadwal['porsi_pakan'];
        dataSatuHari['status_pemberian'] = 'segera dilakukan';

        // tanggal pemberian pakan
        int timestampInt = getTanggalPakan(dataJadwal['jam_mulai'], hari: data);

        Timestamp timestamp =
            Timestamp.fromMillisecondsSinceEpoch(timestampInt);

        dataSatuHari['tanggal_pemberian_pakan'] = timestamp;
        // sampai sini

        // tanggal mengaktifkan jadwal pakan
        Timestamp timeCreate =
            Timestamp.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch);
        dataSatuHari['time_create'] = timeCreate;
        //sampai sini

        dataForFirebase['data'][data] = dataSatuHari;
      }
      dataForFirebase['doc_id_ref'] = dataJadwal['doc_id'];
      _db.collection('pengaturan_pakan').add(dataForFirebase);
    } else {
      Map<String, dynamic> dataForFirebase = {};
      dataForFirebase['jam_mulai'] = dataJadwal['jam_mulai'];
      dataForFirebase['jam_selesai'] = dataJadwal['jam_selesai'];
      dataForFirebase['porsi_pakan'] = dataJadwal['porsi_pakan'];
      dataForFirebase['status_pemberian'] = 'segera dilakukan';

      // tanggal pemberian pakan
      int timestampInt = getTanggalPakan(dataJadwal['jam_mulai']);
      Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(timestampInt);

      dataForFirebase['tanggal_pemberian_pakan'] = timestamp;
      // sampai sini

      Timestamp timeCreate =
          Timestamp.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch);
      dataForFirebase['time_create'] = timeCreate;
      //sampai sini

      dataForFirebase['doc_id_ref'] = dataJadwal['doc_id'];

      _db.collection('pengaturan_pakan').add(dataForFirebase);
    }

    // Dapatkan referensi ke dokumen yang ingin diperbarui
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('alarm_pakan')
        .doc(dataJadwal['doc_id']);

    // Lakukan pembaruan field
    await documentReference.update({
      'status_hidup': true,
    });

    print('Field berhasil diperbarui.');
  } catch (e) {
    // Tangani kesalahan jika ada
    print('Terjadi kesalahan: $e');
  }
}

int getTanggalPakan(dataJam, {hari = ''}) {
  // Fungsi mendapatkan tanggal pakan
  DateTime now = DateTime.now();

  Map<String, dynamic> daysEn = {
    'senin': DateTime.monday,
    'selasa': DateTime.tuesday,
    'rabu': DateTime.wednesday,
    'kamis': DateTime.thursday,
    'jumat': DateTime.friday,
    'sabtu': DateTime.saturday,
    'minggu': DateTime.sunday,
  };
  int timeStampDate;

  if (hari != '') {
    int currentDay = now.weekday;
    int differenceDays = daysEn[hari] - currentDay;

    if (differenceDays < 0) {
      differenceDays += 7;
    }
    int colonIndex = dataJam.toString().indexOf(':');

    var jam = dataJam.toString().substring(0, colonIndex);

    var menit = dataJam.toString().substring(colonIndex + 1);

    DateTime day = DateTime(
      now.year,
      now.month,
      now.day + differenceDays,
      int.parse(jam),
      int.parse(menit),
    );
    timeStampDate = day.millisecondsSinceEpoch;
  } else {
    int colonIndex = dataJam.toString().indexOf(':');

    var jam = dataJam.toString().substring(0, colonIndex);

    var menit = dataJam.toString().substring(colonIndex + 1);
    DateTime day = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(jam),
      int.parse(menit),
    );
    timeStampDate = day.millisecondsSinceEpoch;
  }
  return timeStampDate;
}

void matikanJadwalPakan(dataJadwal) async {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference collectionRef = _db.collection('pengaturan_pakan');

  // Buat query untuk mendapatkan dokumen dengan nilai field yang sesuai
  QuerySnapshot querySnapshot = await collectionRef
      .where('doc_id_ref', isEqualTo: dataJadwal['doc_id'])
      .get();
  querySnapshot.docs.forEach((DocumentSnapshot document) {
    document.reference.delete().then((value) {
      print('Dokumen berhasil dihapus.');
    }).catchError((error) {
      print('Error saat menghapus dokumen: $error');
    });
  });

  try {
    // Dapatkan referensi ke dokumen yang ingin diperbarui
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('alarm_pakan')
        .doc(dataJadwal['doc_id']);

    // Lakukan pembaruan field
    await documentReference.update({
      'status_hidup': false,
    });

    print('Field berhasil diperbarui.');
  } catch (error) {
    print('Error: $error');
  }
}

Future updateJadwalPakan(dataJadwal, docId) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('alarm_pakan').doc(docId);
    await documentReference.update(dataJadwal);
    return 'berhasil';
  } catch (e) {
    print(e);
  }
}

import "package:cloud_firestore/cloud_firestore.dart";

Future<List<Map<String, dynamic>>?> getPengaturanPakan() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jadwal_pakan')
        .orderBy('tanggal_pemberian_pakan')
        .get();
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('jadwal_pakan')
        .where('berulang', isEqualTo: true)
        .get();

    List<Map<String, dynamic>> jadwalBerulang = [];

    querySnapshot2.docs.forEach((doc) {
      for (String hari in doc['data'].keys) {
        var data1 = doc['data'];
        Map<String, dynamic> dataSatu = {};

        dataSatu['time_create'] = data1[hari]['time_create'];
        dataSatu['jam_mulai'] = data1[hari]['jam_mulai'];
        dataSatu['status_pemberian'] = data1[hari]['status_pemberian'];
        dataSatu['jam_selesai'] = data1[hari]['jam_selesai'];
        dataSatu['porsi_pakan'] = data1[hari]['porsi_pakan'];
        dataSatu['tanggal_pemberian_pakan'] =
            data1[hari]['tanggal_pemberian_pakan'];
        dataSatu['doc_id_ref'] = doc['doc_id_ref'];

        jadwalBerulang.add(dataSatu);
      }
    });

    List<Map<String, dynamic>> hasil = [...jadwalBerulang, ...data];

    hasil.sort((a, b) =>
        a['tanggal_pemberian_pakan'].compareTo(b['tanggal_pemberian_pakan']));
    return hasil;
  } catch (e) {
    return null;
  }
}

Future<List<Map<String, dynamic>>?> getDataIndexpH() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('riwayat_pH')
        .orderBy('jam')
        .get();
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return data;
  } catch (e) {
    return null;
  }
}

Future<List<Map<String, dynamic>>?> getDataUser(userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('akun')
        .where('uid', isEqualTo: userId)
        .get();
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return data;
  } catch (e) {
    return null;
  }
}

Future getDataAlarm() async {
  List hasil = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('pengaturan_jadwal_pakan')
        .get();
    querySnapshot.docs.forEach((doc) {
      var data = {};
      data['jam_mulai'] = doc['jam_mulai'];
      data['jam_selesai'] = doc['jam_selesai'];
      data['judul'] = doc['judul'];
      data['porsi_pakan'] = doc['porsi_pakan'];
      data['hari_pemberian_pakan'] = doc['hari_pemberian_pakan'];
      data['status_hidup'] = doc['status_hidup'];
      data['doc_id'] = doc.id;

      hasil.add(data);
    });

    return hasil;
  } catch (e) {
    return null;
  }
}

Future<String?> getDocId(collectionName, fieldName, docId) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .where(fieldName, isEqualTo: docId)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs[0].id;
  } else {
    return null;
  }
}

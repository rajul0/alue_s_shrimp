import "package:cloud_firestore/cloud_firestore.dart";

Future<List<Map<String, dynamic>>?> getPengaturanPakan() async {
  List dataa = [];
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('pengaturan_pakan')
        .orderBy('tanggal_pemberian_pakan')
        .get();
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('pengaturan_pakan')
        .where('berulang', isEqualTo: true)
        .get();
    querySnapshot2.docs.forEach((doc) {
      for (Map data1 in doc['data']) {
        print(doc);
        var dataSatu = {};

        dataSatu['jam_mulai'] = data1['jam_mulai'];
        dataSatu['jam_selesai'] = data1['jam_selesai'];
        dataSatu['judul'] = data1['judul'];
        dataSatu['porsi_pakan'] = data1['porsi_pakan'];
        dataSatu['hari_pemberian_pakan'] = data1['hari_pemberian_pakan'];
        dataSatu['status_hidup'] = data1['status_hidup'];
        dataSatu['doc_id_ref'] = doc['doc_id_ref'];

        dataa.add(data);
      }
    });
    print(dataa);
    return data;
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('alarm_pakan').get();
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

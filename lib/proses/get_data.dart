import "package:cloud_firestore/cloud_firestore.dart";

Future<List<Map<String, dynamic>>?> getPengaturanPakan() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('pengaturan_pakan')
        .orderBy('tanggal_pemberian_pakan')
        .get();
    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
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

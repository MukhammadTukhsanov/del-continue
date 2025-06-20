// void listenToOrders(userId) {
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .collection('orders')
//       .snapshots()
//       .listen((snapshot) {
//     for (var doc in snapshot.docs) {
//       print('Заказ ID: ${doc.id}, Данные: ${doc.data()}');
//       return doc.id;
//     }
//   });
// }

import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tranzaksiyalar"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TransactionItem(
              isSuccessful: true,
              data: "16 May 2024",
              price: "100 000 So`m",
            ),
            TransactionItem(
              isSuccessful: false,
              data: "16 May 2024",
              price: "100 000 So`m",
            )
          ],
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final bool isSuccessful;
  final String data;
  final String price;

  const TransactionItem({
    required this.isSuccessful,
    required this.data,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSuccessful ? Colors.green[400] : Colors.red,
        child: Icon(
          isSuccessful ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      ),
      title: Text(
        isSuccessful ? "Muvaffaqiyatli xarid" : "Bekor qilingan",
        style: TextStyle(color: Color(0xff3c486b), fontSize: 16),
      ),
      subtitle: Text(data, style: TextStyle(color: Color(0x903c486b))),
      trailing: Text(
        price,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

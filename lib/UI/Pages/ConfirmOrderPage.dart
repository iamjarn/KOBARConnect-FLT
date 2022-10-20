import 'package:flutter/material.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Models/Transaction.dart';
import 'package:kobar/UI/Pages/WebviewPage.dart';
import 'package:kobar/Utility/CurrencyFormat.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ConfirmOrderPage extends StatefulWidget {
  final Place place;
  final Transaction transaction;
  final String? payment_url;
  final String transport_name;

  const ConfirmOrderPage(
      {this.payment_url,
      required this.transaction,
      required this.place,
      required this.transport_name,
      Key? key})
      : super(key: key);

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Halaman'),
            content: Text('Apakah anda yakin ingin keluar halaman ini?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    var adult_total = int.parse(widget.transaction.adult_quantity) *
        widget.place.adult_prices;
    var child_total =
        int.parse(widget.transaction.child_quantity) * widget.place.kid_prices;
    var transport_total = widget.transaction.is_use_transport == '1'
        ? widget.place.transport_prices
        : 0;

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          backgroundColor: grey_color,
          appBar: AppBar(
            title: Text(
              widget.place.name!,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.orange,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Pemesanan",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Kunjungan"),
                      Text(
                        widget.transaction.visit_date,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Nama Pemesan"),
                      Text(
                        widget.transaction.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Jumlah Pengunjung"),
                      Text(
                        "${widget.transaction.adult_quantity} Dewasa",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.transaction.child_quantity} Anak",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Aksesibilitas Transportasi"),
                      Text(
                        widget.transport_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Detail Harga",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dewasa x ${widget.transaction.adult_quantity}"),
                          Text(
                            "${CurrencyFormat.convertToIdr(adult_total, 2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Anak x ${widget.transaction.child_quantity}"),
                          Text(
                            "${CurrencyFormat.convertToIdr(child_total, 2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.transport_name),
                          Text(
                            "${CurrencyFormat.convertToIdr(transport_total, 2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Harga"),
                          Text(
                            "${CurrencyFormat.convertToIdr((adult_total + child_total + transport_total), 2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if (widget.payment_url != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return WebviewPage(
                          url: widget.payment_url!,
                          title: "Payment Page",
                          is_show_notif: true,
                        );
                      }));
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Find Payment Method",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    bool result = await showExitPopup();
                    if (result) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Cancel Transaction",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          ))),
        ));
  }
}

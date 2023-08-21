import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobar/UI/Models/Place.dart';
import 'package:kobar/UI/Models/Transaction.dart';
import 'package:kobar/UI/Pages/ConfirmOrderPage.dart';
import 'package:kobar/Utility/Theme.dart';
import 'package:intl/intl.dart';
import 'package:kobar/bloc/order_bloc.dart';
import 'package:form_validator/form_validator.dart';

class OrderPage extends StatefulWidget {
  final Place place;

  const OrderPage({Key? key, required this.place}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _validate() {
    if (_form.currentState != null) {
      return _form.currentState!.validate();
    }
    return false;
  }

  String _dropDownValue = 'Pribadi';
  TextEditingController dateinput = TextEditingController();
  TextEditingController adult_quantity = TextEditingController();
  TextEditingController child_quantity = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController identity = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  Transaction? transaction;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey_color,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            widget.place.name!,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
            key: _form,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cari Waktu Pemesanan",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal Kunjungan",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(10)
                              .minLength(8)
                              .build(),
                          controller: dateinput,
                          decoration: new InputDecoration(
                              hintText: "Tanggal Kunjungan"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime
                                    .now(), //- not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jumlah Pengunjung",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(3)
                              .minLength(1)
                              .build(),
                          controller: adult_quantity,
                          decoration: new InputDecoration(hintText: "Dewasa"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(3)
                              .minLength(1)
                              .build(),
                          controller: child_quantity,
                          decoration: new InputDecoration(hintText: "Anak"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Aksesibilitas Kendaraan",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                            hint: _dropDownValue == null
                                ? Text('Dropdown')
                                : Text(
                                    _dropDownValue,
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            items: ['Pribadi', 'Transportasi Online'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(() {
                                _dropDownValue = val.toString();
                              });
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Identitas Pemesanan",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Lengkap",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(50)
                              .minLength(3)
                              .build(),
                          controller: name,
                          decoration:
                              new InputDecoration(hintText: "Nama Lengkap"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nomor Identitas",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(50)
                              .minLength(3)
                              .build(),
                          controller: identity,
                          decoration: new InputDecoration(
                              hintText: "NIK/ID SIM/NIM/dll"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Alamat Email",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .email()
                              .maxLength(50)
                              .minLength(3)
                              .build(),
                          controller: email,
                          decoration:
                              new InputDecoration(hintText: "Alamat Email"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nomor Whatsapp",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .phone()
                              .maxLength(15)
                              .minLength(8)
                              .build(),
                          controller: phone,
                          decoration:
                              new InputDecoration(hintText: "Nomor Whatsapp"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Domisili Saat Ini",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: ValidationBuilder()
                              .maxLength(50)
                              .minLength(3)
                              .build(),
                          controller: address,
                          decoration: new InputDecoration(
                              hintText: "Kota/Kabupaten Domisili"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Informasi mengenai tiket dan konfirmasi akan dikirimkan ke detail kontak yang telah diisi.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<OrderBloc, OrderState>(
                      listener: (context, state) {
                    if (state is OrderLoaded) {
                      var result = state.result;

                      if (result["status"]) {
                        if (this.transaction != null) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ConfirmOrderPage(
                              place: widget.place,
                              transaction: this.transaction!,
                              payment_url: result["data"],
                              transport_name: _dropDownValue,
                            );
                          }));
                        }
                      }
                    }
                  }, builder: (context, state) {
                    if (state is OrderUninitialized) {
                      return InkWell(
                        onTap: () {
                          if (_validate()) {
                            context.read<OrderBloc>().add(Order(
                                  data: createOrder(),
                                  id: widget.place.id,
                                ));
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Go To Transaction",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      );
                    } else if (state is OrderLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is OrderLoaded) {
                      return InkWell(
                        onTap: () {
                          if (_validate()) {
                            context.read<OrderBloc>().add(Order(
                                  data: createOrder(),
                                  id: widget.place.id,
                                ));
                          }
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Go To Transaction",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                ],
              ),
            ))));
  }

  Transaction createOrder() {
    String is_use_transport = '0';

    if (_dropDownValue == "Pribadi") {
      is_use_transport = '1';
    }

    Transaction transaction = Transaction(
        tour_id: widget.place.id.toString(),
        visit_date: dateinput.text,
        name: name.text,
        identity_number: identity.text,
        email: email.text,
        phone_number: phone.text,
        address: address.text,
        adult_quantity: adult_quantity.text,
        child_quantity: child_quantity.text,
        is_use_transport: is_use_transport);

    this.transaction = transaction;

    return transaction;
  }
}

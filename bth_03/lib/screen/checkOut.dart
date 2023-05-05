import 'package:bth_03/utils/ColorString.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class checkOutScreen extends StatefulWidget {
  @override
  State<checkOutScreen> createState() => _checkOutScreenState();
}

class _checkOutScreenState extends State<checkOutScreen> {
  TextEditingController couponController = TextEditingController();
  TextEditingController tenController = TextEditingController();

  List<String> idPhone = ['+94', '+84', '+83'];
  String selectedNum = '+94';

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      tenController.text = 'Thanh Pham';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Checkout')),
        backgroundColor: color_primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart Summary',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal (4 items)',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs 7,090.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Promtion Discounts',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs 300.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Add Coupon',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs 0.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Est. Total',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rs 6,790.00',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recipient Details',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: tenController,
                                decoration: InputDecoration(
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: DropdownButton<String>(
                              value: selectedNum,
                              elevation: 8,
                              // hint: Text('phone'),
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedNum = newValue!;
                                });
                              },
                              items: idPhone.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Information',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFF2ac700))),
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Home Delivery',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Color(0xFF2ac700)),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFbbdeb2)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Pick Up',
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: tenController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.location_on_outlined),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Date',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                              "${DateFormat('hh:mm dd/MM/yyyy').format(DateTime.now())}",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date of payment',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                              "${DateFormat('hh:mm dd/MM/yyyy').format(DateTime.now())}",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery date (expected)',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                              "${DateFormat('hh:mm dd/MM/yyyy').format(DateTime.now().add(Duration(days: 4)))}",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 25,),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Order',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

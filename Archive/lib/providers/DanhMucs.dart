import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/providers/DanhMuc.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class DanhMucs with ChangeNotifier {
  late String authToken;
  late int uid;
  late List<DanhMuc> _items = [];

  List<DanhMuc> get items => _items;
  set items(List<DanhMuc> value) {
    _items = value;
  }

  DanhMucs({required this.authToken, required this.uid, items});

  Future<void> getListDanhMuc(BuildContext context) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetListDanhMuc),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final responseData = json.decode(response.body);

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
        print("responseData ${responseData}");
        final List<DanhMuc> DanhMucs = [];
        extractedData.forEach((element) {
          DanhMuc newDanhMuc = new DanhMuc(
            nid: element['nid'].toString().toInt(),
            title: element['title'],
          );
          List<String>.from(element['list']).forEachIndexed((element2, index2) {
            newDanhMuc.listContent.add(element2);
          });
          DanhMucs.add(newDanhMuc);
        });
        _items = DanhMucs;
      }
      notifyListeners();
    }
    // on HttpException catch(error) {
    //   RFWidget.showErrorDialog(error.message, context);
    // }
    // catch(error){
    //   print(error.toString());
    //   RFWidget.showErrorDialog(error.toString(), context);
    //   throw error;
    // }
  }
}

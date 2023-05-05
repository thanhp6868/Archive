import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class PhieuTacNghieps with ChangeNotifier {
  late String authToken;
  late int uid;
  late List<PhieuTacNghiep> _items = [];

  List<PhieuTacNghiep> get items => _items;

  set items(List<PhieuTacNghiep> value) {
    _items = value;
  }

  PhieuTacNghieps({required this.authToken, required this.uid, items});

  Future<void> getListPhieuTacNghiep(BuildContext context) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetListPhieuTacNghiep),
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
        final List<PhieuTacNghiep> phieuTacNghieps = [];
        extractedData.forEach((element) {
          PhieuTacNghiep newPhieuTacNghiep = PhieuTacNghiep(
            caLamViec: element['field_ca_lam_viec'],
            ngayNhap: element['field_ngay_phieu'],
            xeCont: element['field_xe_nang_ha'],
            chiTietPhieuTacNghieps: []
          );
          newPhieuTacNghiep.nid = element['nid'].toString().toInt();
          newPhieuTacNghiep.title = element['title'];
          phieuTacNghieps.add(newPhieuTacNghiep);
        });
        _items = phieuTacNghieps;
        print("_items ${_items}" );
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghiep.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class ChiTietPhieuTacNghieps with ChangeNotifier {
  late String authToken;
  late int uid;
  late List<ChiTietPhieuTacNghiep> _items = [];

  List<ChiTietPhieuTacNghiep> get items => _items;

  set items(List<ChiTietPhieuTacNghiep> value) {
    _items = value;
  }

  ChiTietPhieuTacNghieps({required this.authToken, required this.uid, items});

  Future<void> getListChiTietPhieuTacNghiep(BuildContext context, int nidPhieu) async {
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetListChiTietPhieuTacNghiep),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'nidPhieu': nidPhieu
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      print("response.body ${response.body}");
      final responseData = json.decode(response.body);

      if (!responseData['success'])
        throw HttpException(responseData['content']);
      else {
        final extractedData = List<Map<String, dynamic>>.from(jsonDecode(response.body)['content']); //json.decode(response.body) as Map<String, dynamic>;
        final List<ChiTietPhieuTacNghiep> listChiTietPhieuTacNghieps = [];

        extractedData.forEach((element) {

          ChiTietPhieuTacNghiep chiTietPhieuTacNghiep = ChiTietPhieuTacNghiep(
              field_ghi_chu: element['field_ghi_chu'] == '' ? null : element['field_ghi_chu'],
              field_so_container: element['field_so_container'],
              field_hang_tau: element['field_hang_tau'] == '' ? null : element['field_hang_tau'],
              field_kich_co_container: element['field_kich_co_container'] == '' ? null : element['field_kich_co_container'],
              field_phieu_tac_nghiep: element['field_phieu_tac_nghiep'] == '' ? null : element['field_phieu_tac_nghiep'],
              field_trang_thai_rh: element['field_trang_thai_rh'] == '' ? null : element['field_trang_thai_rh'],
              field_tac_nghiep: element['field_tac_nghiep'] == '' ? null : element['field_tac_nghiep'],
              field_loi_so_container: element['field_loi_so_container']
          );
          chiTietPhieuTacNghiep.nid = element['nid'].toString().toInt();

          listChiTietPhieuTacNghieps.add(chiTietPhieuTacNghiep);
        });
        _items = listChiTietPhieuTacNghieps;
        print("_items ${_items}");
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
}
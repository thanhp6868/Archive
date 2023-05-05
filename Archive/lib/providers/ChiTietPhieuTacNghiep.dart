import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class ChiTietPhieuTacNghiep with ChangeNotifier {
  int _nid = 0;
  late int uid;
  late String authToken;
  late String field_so_container;
  late String? field_hang_tau;
  late String? field_trang_thai_rh;
  late String? field_kich_co_container	;
  late String? field_tac_nghiep	;
  late String? field_phieu_tac_nghiep	;
  late String? field_ghi_chu	;
  late bool field_loi_so_container = false;
  late bool deleting = false;

  ChiTietPhieuTacNghiep({
    this.uid = 0,
    this.authToken = '',
    this.field_ghi_chu,
    this.field_so_container = '',
    this.field_hang_tau,
    this.field_kich_co_container,
    this.field_phieu_tac_nghiep,
    this.field_trang_thai_rh,
    this.field_tac_nghiep,
    this.field_loi_so_container = false
  });

  int get nid => _nid;

  set nid(int value) {
    _nid = value;
  }

  Future<void> save(BuildContext context, Map<String, dynamic> data) async{
    print("data ${data}");
    _nid = 0;
    try
    {
      final response = await http.post(
          Uri.parse(RFSaveChiTietPhieuTacNghiep),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'data': data
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final responseData = json.decode(response.body);
      print('responseData ${responseData}');

      if(!responseData['success']){
        throw HttpException(responseData['content']);
      }
      else{
        final snackBar = SnackBar(
          padding: EdgeInsets.all(8),
          backgroundColor: getColorFromHex('#379237'),
          content: TextIcon(
            text: responseData['content'],
            prefix: Icon(Ionicons.checkmark_circle, color: Colors.white,),
            textStyle: TextStyle(color: Colors.white),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _nid = responseData['nid'].toString().toInt();
        print("responseData['field_loi_so_container'] ${responseData['field_loi_so_container']}");
        field_loi_so_container = responseData['field_loi_so_container'];
        print("responseData ${responseData}");
      }
      notifyListeners();
    }
    on HttpException catch(error) {
      RFWidget.showErrorDialog(error.message, context);
    }
    catch(error){
      print(error.toString());
      RFWidget.showErrorDialog(error.toString(), context);
      throw error;
    }
  }

  Future<void> delete(BuildContext context, int nid) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFDeleteChiTietPhieu),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'nid': nid
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );

      final responseData = json.decode(response.body);
      if(!responseData['success']){
        throw HttpException(responseData['content']);
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class CauHinh with ChangeNotifier {
  int? nid;
  final String authToken;
  final int uid;
  List<dynamic> _hangTau = [];
  List<dynamic> _tacNghiep = [];
  List<dynamic> _KichCoContainer = [];
  List<dynamic> _xeNang = [];
  List<dynamic> _caLamViec = [];
  List<dynamic> _ghiChu = [];
  List<dynamic> _trangThaiRH = [];


  List<dynamic> get KichCoContainer => _KichCoContainer;

  set KichCoContainer(List<dynamic> value) {
    _KichCoContainer = value;
  }

  List<dynamic> get trangThaiRH => _trangThaiRH;

  set trangThaiRH(List<dynamic> value) {
    _trangThaiRH = value;
  }

  List<dynamic> get ghiChu => _ghiChu;

  set ghiChu(List<dynamic> value) {
    _ghiChu = value;
  }

  List<dynamic> get hangTau => _hangTau;
  set hangTau(List<dynamic> value) {
    _hangTau = value;
  }
  CauHinh(this.authToken, this.uid, {this.nid});
  List<dynamic> get tacNghiep => _tacNghiep;
  set tacNghiep(List<dynamic> value) {
    _tacNghiep = value;
  }
  List<dynamic> get xeNang => _xeNang;
  set xeNang(List<dynamic> value) {
    _xeNang = value;
  }
  List<dynamic> get caLamViec => _caLamViec;
  set caLamViec(List<dynamic> value) {
    _caLamViec = value;
  }

  Future<void> getKhoiTaoForm(BuildContext context) async{
    // try
    {
      final response = await http.post(
          Uri.parse(RFGetDataKhoiTao),
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
        print("responseData['content'] ${responseData['content']}");
        _hangTau = responseData['content']['hangTau'];
        _tacNghiep = responseData['content']['tacNghiep'];
        _KichCoContainer = responseData['content']['KichCoContainer'];
        _xeNang = responseData['content']['xeNang'];
        _caLamViec = responseData['content']['caLamViec'];
        _ghiChu = responseData['content']['ghiChu'];
        _trangThaiRH = responseData['content']['trangThaiRH'];
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

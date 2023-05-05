import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghiep.dart';
import '../main.dart';
import '../utils/RFString.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class PhieuTacNghiep with ChangeNotifier {
  int _nid = 0;
  late String authToken;
  late int uid;
  late String ngayNhap;
  late String xeCont;
  late String caLamViec;
  late List<ChiTietPhieuTacNghiep> chiTietPhieuTacNghieps;
  String _linkTaiPDF = '';
  String _title = '';
  late bool deleting = false;

  String get linkTaiPDF => _linkTaiPDF;
  set linkTaiPDF(String value) {
    _linkTaiPDF = value;
  }
  late Map<String, dynamic> SanLuong;
  int get nid => _nid;
  set nid(int value) {
    _nid = value;
  }
  String get title => _title;
  set title(String value) {
    _title = value;
  }

  PhieuTacNghiep({
    nid = 0,
    title = '',
    this.uid = 0,
    this.authToken = '',
    this.caLamViec = '',
    this.ngayNhap = '',
    this.xeCont = '',
    required this.chiTietPhieuTacNghieps
  });

  Future<void> save(BuildContext context, Map<String, dynamic> data) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFSavePhieuTacNghiep),
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

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        print("responseData ${responseData}");
        _nid = responseData['content']['nid'].toString().toInt();
        _title = responseData['content']['maPhieu'];
      }
      print("data['insert'] ${data['insert']}");
      if(!data['insert']){
        final snackBar = SnackBar(
          padding: EdgeInsets.all(8),
          backgroundColor: getColorFromHex('#379237'),
          content: TextIcon(
            text: responseData['content']['message'],
            prefix: Icon(Ionicons.checkmark_circle, color: Colors.white,),
            textStyle: TextStyle(color: Colors.white),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future<void> downloadPDF(BuildContext context, int nid) async{
    try
    {
      final response = await http.post(
          Uri.parse(RFDownloadPDF),
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

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        _linkTaiPDF = responseData['content']['content'];
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

  Future<void> loadPhieu(BuildContext context, int nid) async{
    chiTietPhieuTacNghieps = [];
    // try
    {
      final response = await http.post(
          Uri.parse(RFLoadPhieu),
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

      if(!responseData['success'])
        throw HttpException(responseData['content']);
      else{
        print("responseData ${responseData}");
        _nid = responseData['content']['nid'].toString().toInt();
        _title = responseData['content']['title'];
        ngayNhap = responseData['content']['ngayNhap'];
        xeCont = responseData['content']['xeCont'];
        caLamViec = responseData['content']['caLamViec'];
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

  Future<void> deletePhieu(BuildContext context, int nid) async{
    // try
        {
      final response = await http.post(
          Uri.parse(RFDeletePhieu),
          body: json.encode({
            'uid': this.uid,
            'auth': this.authToken,
            'nidPhieu': nid
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
        print("responseData ${responseData}");
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

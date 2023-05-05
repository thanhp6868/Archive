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

class DanhMuc with ChangeNotifier {
  int nid = 0;
  late String authToken;
  late int uid;
  late String title;
  late bool deleting = false;
  late List<String> listContent = [];

  DanhMuc({
    this.nid = 0,
    this.title = '',
    this.uid = 0,
    this.authToken = '',
  });

}

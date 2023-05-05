import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:search_choices/search_choices.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/RFWidget.dart';

class FormTimKiemDonHang extends StatefulWidget {
  final Function(Map<String, dynamic>) callback;

  FormTimKiemDonHang({required this.callback});

  @override
  State<FormTimKiemDonHang> createState() => _FormTimKiemDonHangState();
}

class _FormTimKiemDonHangState extends State<FormTimKiemDonHang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Đang cập nhật'),
    );
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/utils/RFString.dart';
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

class Auth with ChangeNotifier{
  late String _token = '';
  late DateTime _expiryDate = DateTime.now();
  late String _userId = '';

  bool get isAuth {
    return token != '';
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String url, String email, String password) async{
    try
    {
      final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            'username': email,
            'password': password,
          }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        }
      );
      // print(object)
      final responseData = json.decode(response.body);
      if(!responseData['success'])
        throw HttpException(responseData['content']);

      _token = responseData['auth'];
      _userId = responseData['user']['uid'].toString();
      notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> _authenticateDangKy(
      String url,
      String hoTen,
      String dienThoai,
      String email,
      String matKhau,
      String nhapLaiMatKhau,
      ) async{
    try{
      final response = await http.post(
          Uri.parse(url),
          body: json.encode({
            'hoTen': hoTen,
            'dien_thoai': dienThoai,
            'email': email,
            'password': matKhau,
            'rePassword': nhapLaiMatKhau,
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
          }
      );
      final responseData = json.decode(response.body);
      print(responseData);

      if(!responseData['success'])
        throw HttpException(responseData['content']);

      _token = responseData['auth'];
      _userId = responseData['user']['uid'].toString();
      notifyListeners();
    }
    catch(error){
      throw error;
    }

  }

  Future<void> signup(
      String hoTen,
      String dienThoai,
      String email,
      String matKhau,
      String nhapLaiMatKhau,
      ) async {
    return _authenticateDangKy(
      RFBaseSignUp,
      hoTen,
      dienThoai,
      email,
      matKhau,
      nhapLaiMatKhau,
    );
  }
  Future<void> login(String email, String password, BuildContext context) async {
    const url = RFBaseLogin;
    return _authenticate(url, email, password);
  }
}
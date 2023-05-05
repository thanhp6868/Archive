import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/components/RFCommonAppComponent.dart';
import 'package:tancang/components/RFConformationDialog.dart';
import 'package:tancang/providers/auth.dart';
import 'package:tancang/screens/RFResetPasswordScreen.dart';
import 'package:tancang/utils/RFColors.dart';
import 'package:tancang/utils/RFString.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tancang/utils/RFWidget.dart' as RFWidget;

import '../models/http_exeption.dart';
import '../utils/RFWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'RFResetPasswordScreen.dart';

enum AuthMode { Signup, Login }

// ignore: must_be_immutable
class RFEmailSignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  bool showDialog;
  String contentAlert = '';
  bool clear=false;
  RFEmailSignInScreen({this.showDialog = false,this.clear=false});

  @override
  _RFEmailSignInScreenState createState() => _RFEmailSignInScreenState();
}

@HiveType(typeId: 1)
class Person {
  Person({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return '$username: $username';
  }
}


class _RFEmailSignInScreenState extends State<RFEmailSignInScreen> {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {'email': '', 'password': ''};
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  Timer? timer;
   late Box box1;

  @override
  void initState() {
    super.initState();
    // final Directory appDocDir = await getApplicationDocumentsDirectory();
    // Hive.init(appDocDir.path);
    initHive();
    init();
  }
  void clear() async{
    setState(() {
      box1.clear();
    });
  }

  void initHive() async{
    await Hive.initFlutter();
    box1 = await Hive.openBox('emailController');
    getData();
  }

  void getData() async {
    setState(() {
      if(box1.get('emailController')!=null){
        emailController.text=box1.get('emailController');
        isChecked==false;
      };
      if(box1.get('passwordController')!=null){
        passwordController.text=box1.get('passwordController');
        isChecked==false;
      };
      if(widget.clear==true){

        passwordController.text='';
        emailController.text='';
      }
      if(passwordController.text!=''&&emailController.text!=''){
        _submit();
      }
    });
  }
  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);

    widget.showDialog
        ? Timer.run(() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return Material(
              type: MaterialType.transparency,
              child: RFConformationDialog(widget.contentAlert));
        },
      );
    })
        : SizedBox();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _submit() async {
    if (isChecked) {
      box1.put('emailController', emailController.text);
      box1.put('passwordController', passwordController.text);
      box1.put('isChecked', true);
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .login(emailController.text, passwordController.text, context);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog('Thông báo', 'Đăng nhập thành công');
      // });
    } on HttpException catch (error) {
      RFWidget.showErrorDialog(error.message, context);
    } catch (error) {
      print(error);
      // showInDialog(context, barrierDismissible: true, builder: (context) {
      //   return RFCongratulatedDialog();
      // });
      RFWidget.showErrorDialog(error.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: RFAppName,
        subTitle: RFAppSubTitle,
        mainWidgetHeight: 230,
        subWidgetHeight: 190,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Đăng nhập', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: emailController,
              focus: emailFocusNode,
              nextFocus: passWordFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: "Tên đăng nhập",
                showLableText: true,
                // suffixIcon: Container(
                //   padding: EdgeInsets.all(2),
                //   decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                //   child: Icon(Icons.done, color: Colors.white, size: 14),
                // ),
              ),
            ),
            16.height,
            AppTextField(
              controller: passwordController,
              focus: passWordFocusNode,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'Mật khẩu',
                showLableText: true,
              ),

            ),
            4.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      isChecked = !isChecked;
                      setState(() {});
                    }),
                Text(
                  'Nhớ mật khẩu',

                ),

              ],
            ),
            4.height,
            if (_isLoading)
              CircularProgressIndicator()
            else
              AppButton(
                color: rf_primaryColor,
                child: Text('Đăng nhập', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  _submit();
                },
              ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  child: Text("Quên mật khẩu?", style: primaryTextStyle()),
                  onPressed: () {
                    RFResetPasswordScreen().launch(context);
                  }),
            ),
          ],
        ),
        subWidget: socialLoginWidget(context,
            title1: "Bạn chưa có tài khoản? ",
            title2: "Đăng ký ngay", callBack: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/sign-up', (route) => false);
            }),
      ),
    );
  }
}

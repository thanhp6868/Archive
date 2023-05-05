import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/common/constants.dart';
import 'package:tancang/components/RFCommonAppComponent.dart';
import 'package:tancang/components/RFCongratulatedDialog.dart';
import 'package:tancang/main.dart';
import 'package:tancang/models/http_exeption.dart';
import 'package:tancang/providers/auth.dart';
import 'package:tancang/screens/RFEmailSignInScreen.dart';
import 'package:tancang/utils/AppTheme.dart';
import 'package:tancang/utils/RFColors.dart';
import 'package:tancang/utils/RFWidget.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../utils/RFString.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RFSignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  _RFSignUpScreenState createState() => _RFSignUpScreenState();
}

class _RFSignUpScreenState extends State<RFSignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dienThoaiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userDateOfBirthController = TextEditingController();
  TextEditingController chieuCaoController = TextEditingController();
  TextEditingController canNangController = TextEditingController();
  TextEditingController tanSuatTheDucController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode dienThoaiFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode f4 = FocusNode();

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  String formatDate(String? dateTime, {String format = DATE_FORMAT_2, bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  Future<void> _submit() async{
    setState(() {
      _isLoading = true;
    });
    try{
      await Provider.of<Auth>(context, listen: false).signup(
          fullNameController.text,
          dienThoaiController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text
      );
      setState(() {
        _isLoading = false;
      });
      RFEmailSignInScreen rfEmailSignInScreen = new RFEmailSignInScreen();
      rfEmailSignInScreen.contentAlert = 'Đăng ký tài khoản thành công';
      rfEmailSignInScreen.showDialog = true;
      rfEmailSignInScreen.launch(context);
      // Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);

    }
    on HttpException catch(error){
      showErrorDialog(error.message, context);
    } catch (error){
      print(error);
      showErrorDialog(error.toString(), context);
      print(error.toString());
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
        mainWidgetHeight: 250,
        subWidgetHeight: 190,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tạo tài khoản', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: fullNameController,
              focus: fullNameFocusNode,
              nextFocus: dienThoaiFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Họ tên",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: dienThoaiController,
              focus: dienThoaiFocusNode,
              nextFocus: emailFocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: "Điện thoại",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: emailController,
              focus: emailFocusNode,
              nextFocus: passWordFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: "Email",
                showLableText: true,
                suffixIcon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: rf_rattingBgColor),
                  child: Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: passwordController,
              focus: passWordFocusNode,
              nextFocus: confirmPasswordFocusNode,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'Mật khẩu',
                showLableText: true,
              ),
            ),
            16.height,
            AppTextField(
              controller: confirmPasswordController,
              focus: confirmPasswordFocusNode,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                showLableText: true,
                lableText: 'Nhập lại mật khẩu',
              ),
            ),
            16.height,
            if(_isLoading)
              CircularProgressIndicator()
            else
              AppButton(
                color: rf_primaryColor,
                child: Text('Đăng ký', style: boldTextStyle(color: white)),
                width: context.width(),
                elevation: 0,
                onTap: () {
                  _submit();
                  // RFHomeScreen().launch(context);
                },
              ),
          ],
        ),
        subWidget: rfCommonRichText(title: "Bạn đã có tài khoản? ", subTitle: "Đăng nhập ngay").paddingAll(8).onTap(
              () {
            Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route)=>false);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/providers/CauHinh.dart';
import 'package:provider/provider.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghiep.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import 'package:tancang/widgets/ListSanLuong.dart';

import '../common/constants.dart';
import '../main.dart';
import '../utils/AppTheme.dart';
import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';
import 'RFHomeScreen.dart';

class FormTacNghiep extends StatefulWidget {
  int? nid = 0;
  String title = '';

  FormTacNghiep({
    required this.nid,
    required this.title,
  });

  @override
  State<FormTacNghiep> createState() => _FormTacNghiepState();
}

class _FormTacNghiepState extends State<FormTacNghiep> {
  PhieuTacNghiep phieuTacNghiep = new PhieuTacNghiep(chiTietPhieuTacNghieps: []);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController ngayNhapController = TextEditingController();
  String? selectedXeNang = null;
  String? selectedCaLamViec = null;
  Map<String, dynamic>? SanLuong = null;

  FocusNode ngayNhapFocusNode = FocusNode();
  FocusNode f4 = FocusNode();
  DateTime? selectedDate;

  List<dynamic> xeNang = [];
  List<dynamic> caLamViec = [];

  bool saving = false;
  bool loadingDataForm = false;

  Future<void> initData() async{
    setState(() {
      loadingDataForm = true;
    });
    CauHinh cauHinh = await Provider.of<CauHinh>(context, listen: false);
    cauHinh.getKhoiTaoForm(context).then((value){
      setState(() {
        xeNang = cauHinh.xeNang;
        caLamViec = cauHinh.caLamViec;
        loadingDataForm = false;
      });
    });

    if(widget.nid == 0 || widget.nid == null)
      setState(() {
        ngayNhapController.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    if(widget.nid != 0 && widget.nid != null){
      PhieuTacNghiep phieuTacNghiepProvider = await Provider.of<PhieuTacNghiep>(context, listen: false);
      phieuTacNghiepProvider.loadPhieu(context, widget.nid!).then((value){
        setState(() {
          this.phieuTacNghiep.nid = phieuTacNghiepProvider.nid;
          this.phieuTacNghiep.title = phieuTacNghiepProvider.title;
          this.selectedCaLamViec = phieuTacNghiepProvider.caLamViec;
          this.selectedXeNang = phieuTacNghiepProvider.xeCont;
          ngayNhapController.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
        });
      });
    }

  }

  Future<void> _submit(bool insert) async{
    setState(() {
      this.saving = true;
    });
    PhieuTacNghiep phieuTacNghiepProvider = await Provider.of<PhieuTacNghiep>(context, listen: false);
    phieuTacNghiepProvider.save(context, {
      'nid': widget.nid,
      'ngayNhap': ngayNhapController.text,
      'xeNang': selectedXeNang,
      'caLamViec': selectedCaLamViec,
      'sanLuong': SanLuong,
      'insert': insert
    }).then((value){
      setState(() {
        this.saving = false;
        print("phieuTacNghiepProvider.nid ${phieuTacNghiepProvider.nid}");
        setState(() {
          this.phieuTacNghiep.nid = phieuTacNghiepProvider.nid;
          this.phieuTacNghiep.title = phieuTacNghiepProvider.title;
          widget.nid = phieuTacNghiepProvider.nid;
        });
      });
    }).onError((error, stackTrace){
      setState(() {
        this.saving = false;
      });
    });
  }

  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormTacNghiep oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return BackButton(
        color: appStore.textPrimaryColor,
        onPressed: () {
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => RFHomeScreen(selectedIndex: 0,)), (route) => false);
        },
      );
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title, style: boldTextStyle(color: appStore.textPrimaryColor)),
              backgroundColor: Colors.white,
              leading: leadingWidget(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: <Widget>[
                            loadingDataForm ? Center(child: CircularProgressIndicator(),) : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(this.phieuTacNghiep.title == '' ? '[Mã phiếu tự sinh]' : "Mã phiếu: ${this.phieuTacNghiep.title}", style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red
                                    ),),
                                    saving ? Center(child: CircularProgressIndicator(),) : (
                                        widget.nid != 0 && widget.nid != null ? InkWell(
                                            onTap: (){
                                              _submit(false);
                                            },
                                            child: TextIcon(
                                              text: 'Cập nhật',
                                              textStyle: TextStyle(color: Color(0xFF379237), fontSize: 16),
                                              prefix: Icon(Ionicons.save, color: Color(0xFF379237), size: 16 ,),
                                            )
                                        ): SizedBox()
                                    )
                                  ],
                                ),
                                16.height,
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('Chọn xe', style: TextStyle(fontWeight: FontWeight.bold),),
                                              alignment: Alignment.topLeft,
                                            ),
                                            8.height,
                                            Container(
                                              decoration: boxDecorationWithRoundedCorners(
                                                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                                backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                              ),
                                              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                              child: DropdownButton<String>(
                                                value: selectedXeNang,
                                                elevation: 16,
                                                style: primaryTextStyle(),
                                                hint: Text('Xe nâng', style: primaryTextStyle()),
                                                isExpanded: true,
                                                underline: Container(
                                                  height: 0,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedXeNang = newValue;
                                                  });
                                                },
                                                items: xeNang.map<DropdownMenuItem<String>>((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    8.width,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text('Ngày thực hiện', style: TextStyle(fontWeight: FontWeight.bold),),
                                            alignment: Alignment.topLeft,
                                          ),
                                          8.height,
                                          TextFormField(
                                            controller: ngayNhapController,
                                            focusNode: ngayNhapFocusNode,
                                            readOnly: false,
                                            onTap: () {
                                              selectDateAndTime(context);
                                            },
                                            onFieldSubmitted: (v) {
                                              ngayNhapFocusNode.unfocus();
                                              FocusScope.of(context).requestFocus(f4);
                                            },
                                            decoration: inputDecoration(
                                              context,
                                              hintText: "Chọn ngày",
                                              suffixIcon: Icon(Icons.calendar_month_rounded, size: 16, color: appStore.isDarkModeOn ? white : gray),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                16.height,
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('Ca làm việc', style: TextStyle(fontWeight: FontWeight.bold),),
                                              alignment: Alignment.topLeft,
                                            ),
                                            8.height,
                                            Container(
                                              decoration: boxDecorationWithRoundedCorners(
                                                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                                                backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                                              ),
                                              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                              child: DropdownButton<String>(
                                                value: selectedCaLamViec,
                                                elevation: 16,
                                                style: primaryTextStyle(),
                                                hint: Text('Ca làm việc', style: primaryTextStyle()),
                                                isExpanded: true,
                                                underline: Container(
                                                  height: 0,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedCaLamViec = newValue;
                                                  });
                                                },
                                                items: caLamViec.map<DropdownMenuItem<String>>((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                16.height,
                                Container(
                                  child: Text('NHẬP SẢN LƯỢNG NÂNG HẠ CONT', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: getColorFromHex("#146C94")),
                                  ),
                                ),
                                16.height,
                              ],
                            ),

                            ListSanLuong(
                              nidPhieuTacNghiep: widget.nid,
                              saving: this.saving,
                              callback: (value){
                                if(value['type'] == 'savePhieuTacNghiep')
                                  _submit(false);
                              },
                              sua: widget.nid != 0 && widget.nid != null ? true : false,
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                  ),
                ],
              ),
            )
        ));
  }

  String formatDate(String? dateTime, {String format = DATE_FORMAT_2, bool isFromMicrosecondsSinceEpoch = false}) {
    if (isFromMicrosecondsSinceEpoch) {
      return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000));
    } else {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    }
  }

  void selectDateAndTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(3000),
      builder: (_, child) {
        return Theme(
          data: appStore.isDarkModeOn ? ThemeData.dark() : AppThemeData.lightTheme,
          child: child!,
        );
      },
    ).then((date) async {
      if (date != null) {
        selectedDate = date;
        ngayNhapController.text = "${formatDate(selectedDate.toString(), format: DATE_FORMAT_VN)}";
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

}

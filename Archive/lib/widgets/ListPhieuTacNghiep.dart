import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';

import '../main.dart';
import '../providers/PhieuTacNghieps.dart';
import '../screens/RFFormTacNghiep.dart';
import '../utils/RFColors.dart';
import 'AlertDialogTaiFile.dart';
import 'package:provider/provider.dart';

class ListViewPhieuTacNghiep extends StatefulWidget {
  List<PhieuTacNghiep> phieuTacNghieps = [];

  ListViewPhieuTacNghiep(this.phieuTacNghieps);

  @override
  State<ListViewPhieuTacNghiep> createState() => _ListViewPhieuTacNghiepState();
}

class _ListViewPhieuTacNghiepState extends State<ListViewPhieuTacNghiep> {

  bool loading = false;

  Future<void> _deletePhieu(BuildContext context, int index) async {
    setState(() {
      widget.phieuTacNghieps[index].deleting = true;
    });

    final provider = Provider.of<PhieuTacNghiep>(context, listen: false);

    provider.deletePhieu(context, widget.phieuTacNghieps[index].nid).then((value) {
      setState(() {
        widget.phieuTacNghieps.removeAt(index);
      });
    });
        // .onError((error, stackTrace){
      // setState(() {
      //   print(error.toString());
      //   widget.phieuTacNghieps.removeAt(index);
      //   widget.phieuTacNghieps[index].deleting = false;
      // });
    // }
    // );
  }

  void dangCapNhat(){
    final snackBar = SnackBar(
      padding: EdgeInsets.all(8),
      backgroundColor: getColorFromHex('#E86A33'),
      content: TextIcon(
        text: "Đang cập nhật",
        prefix: Icon(Ionicons.warning, color: Colors.white,),
        textStyle: TextStyle(color: Colors.white),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.phieuTacNghieps.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        PhieuTacNghiep phieu = widget.phieuTacNghieps[index];
        return Container(
          child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: appStore.textPrimaryColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Số phiếu: "),
                                Text("${phieu.title}", style: TextStyle(color: getColorFromHex('#ED2B2A'), fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Ngày lập: "),
                                Text("${phieu.ngayNhap}", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Ca làm việc: "),
                                Text("${phieu.caLamViec}", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Xe: "),
                                Text("${phieu.xeCont}", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        8.height,
                        Divider(
                          height: 1,
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: TextIcon(
                                text: 'Sửa',
                                textStyle: TextStyle(fontSize: 16, color: Color(0xFF19A7CE)),
                                prefix: Icon(Ionicons.create, size: 16, color: Color(0xFF19A7CE),),
                              ),
                              onTap: (){
                                Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => FormTacNghiep(
                                  nid: phieu.nid,
                                  title: 'Sửa tác nghiệp ${phieu.title}',
                                )
                                ), (route) => false);
                              },
                            ),
                            InkWell(
                              child: TextIcon(
                                text: 'PDF',
                                textStyle: TextStyle(fontSize: 16, color: Color(0xFF379237)),
                                prefix: Icon(Ionicons.download, size: 16, color: Color(0xFF379237),),
                                onTap: (){
                                  showDialog(
                                    // barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialogTaiFile(
                                        nid: phieu.nid,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            widget.phieuTacNghieps[index].deleting ? Center(child: CircularProgressIndicator(),) : InkWell(
                              child: TextIcon(
                                text: 'Xoá',
                                textStyle: TextStyle(fontSize: 16, color: Color(0xFFEB455F)),
                                prefix: Icon(Ionicons.trash, size: 16, color: Color(0xFFEB455F),),
                              ),
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: context.cardColor,
                                      title: Text("Thông báo", style: boldTextStyle(color: appStore.textPrimaryColor)),
                                      content: Text(
                                        "Bạn có chắc chắn muốn xoá dữ liệu này?",
                                        style: secondaryTextStyle(color: appStore.textSecondaryColor),
                                      ),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                              "Có",
                                              style: primaryTextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              _deletePhieu(context, index);
                                              // leteNhuCau(nhuCaus[index].nid.toInt()).then((value){
                                              Navigator.of(context).pop();
                                            }
                                        ),
                                        TextButton(
                                          child: Text("Không", style: primaryTextStyle(color: appColorPrimary)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    )
                ),
              )
          ),
          margin: EdgeInsets.only(bottom: 15),
        );
      },
    );
  }
}

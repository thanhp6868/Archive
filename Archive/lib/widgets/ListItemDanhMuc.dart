import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/RFColors.dart';

class ListItemDanhMuc extends StatefulWidget {
  List<String> listContent;

  ListItemDanhMuc({required this.listContent});

  @override
  State<ListItemDanhMuc> createState() => _ListItemDanhMucState();
}

class _ListItemDanhMucState extends State<ListItemDanhMuc> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: widget.listContent.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey,);
      },
      itemBuilder: (BuildContext context, int index) {
        String item = widget.listContent[index];
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Text(item, style: TextStyle(fontSize: 16)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: TextIcon(
                    text: 'Sửa',
                    textStyle: TextStyle(fontSize: 16, color: Color(0xFF19A7CE)),
                    prefix: Icon(Ionicons.create, size: 16, color: Color(0xFF19A7CE),),
                  ),
                  onTap: (){

                  },
                ),
                InkWell(
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
        );
      },
    );
  }
}

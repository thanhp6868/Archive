import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/PhieuTacNghiep.dart';
import '../utils/RFColors.dart';

class AlertDialogTaiFile extends StatefulWidget {
  int nid;

  AlertDialogTaiFile({
    required this.nid,
  });

  @override
  State<AlertDialogTaiFile> createState() => _AlertDialogTaiFileState();
}

class _AlertDialogTaiFileState extends State<AlertDialogTaiFile> {
  bool downloadingPdf = false;
  String linkPdf = '';

  Future<void> _downloadPDF(BuildContext context) async {
    setState(() {
      this.downloadingPdf = true;
    });
    final provider = Provider.of<PhieuTacNghiep>(context, listen: false);
    provider
        .downloadPDF(context, widget.nid)
        .then((value) {
      setState(() {
        this.downloadingPdf = false;
        this.linkPdf = provider.linkTaiPDF;
      });
    }).onError((error, stackTrace){
      setState(() {
        this.downloadingPdf = false;
        this.linkPdf = 'Lỗi không xác định';
      });
    });
  }

  @override
  void initState() {
    _downloadPDF(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.all(0.0),
      insetPadding: EdgeInsets.symmetric(horizontal: 100),
      content: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            this.downloadingPdf ? Column(
              children: [
                CircularProgressIndicator(color: appColorPrimary),
                SizedBox(height: 16),
                Text("Đang tải dữ liệu...", style: primaryTextStyle(color: appStore.textPrimaryColor))
              ],
            ) :
            InkWell(
                child: new TextIcon(
                  text: 'Tải báo cáo',
                  prefix: Icon(Ionicons.download, size: 28, color: Color(0xff3A98B9),),
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Color(0xff3A98B9)
                  ),
                ),
                onTap: () => launch(this.linkPdf)
            ),
          ],
        ),
      ),
    );
  }
}

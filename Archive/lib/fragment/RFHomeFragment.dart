import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/main.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import 'package:tancang/providers/PhieuTacNghieps.dart';
import 'package:tancang/screens/RFFormTacNghiep.dart';
import 'package:tancang/utils/RFColors.dart';
import 'package:provider/provider.dart';
import 'package:tancang/widgets/AlertDialogTaiFile.dart';
import 'package:tancang/widgets/ListPhieuTacNghiep.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/http_exeption.dart';
import '../screens/RFHomeScreen.dart';
import '../utils/RFWidget.dart';

class RFHomeFragment extends StatefulWidget {

  @override
  _RFHomeFragmentState createState() => _RFHomeFragmentState();
}

class _RFHomeFragmentState extends State<RFHomeFragment> {
  late List<PhieuTacNghiep> phieuTacNghieps = [];
  bool loading = false;

  Future<void> _reloadPhieuTacNghiep(BuildContext context) async {
    setState(() {
      this.loading = true;
    });

    final provider = Provider.of<PhieuTacNghieps>(context, listen: false);

    provider
        .getListPhieuTacNghiep(context)
        .then((value) {
      setState(() {
        this.phieuTacNghieps = provider.items;
        loading = false;
      });
    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    _reloadPhieuTacNghiep(context);
    super.initState();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tác nghiệp', style: boldTextStyle(color: appStore.textPrimaryColor)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            child: TextIcon(
              text: 'Thêm tác nghiệp',
              prefix: Icon(Ionicons.add_circle, color: rf_primaryColor),
              textStyle: TextStyle(color: rf_primaryColor, fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => FormTacNghiep(nid: null, title: 'Thêm tác nghiệp',)), (route) => false);
              //
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => FormTacNghiep(nid: null, title: 'Thêm tác nghiệp',)),
              // );
            },
          )

        ],
      ),
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 20, bottom: 30),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: context.height(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: loading ? Center(child: CircularProgressIndicator(),) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ListViewPhieuTacNghiep(this.phieuTacNghieps)
                        // Text("Danh sách khách hàng", style: boldTextStyle(size: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
      )
    );
  }
}

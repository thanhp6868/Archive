import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/main.dart';
import 'package:tancang/providers/DanhMucs.dart';
import 'package:tancang/screens/RFFormTacNghiep.dart';
import 'package:tancang/utils/RFColors.dart';
import 'package:provider/provider.dart';
import 'package:tancang/widgets/ListItemDanhMuc.dart';
import '../providers/DanhMuc.dart';

class DanhMucFragment extends StatefulWidget {

  @override
  _DanhMucFragmentState createState() => _DanhMucFragmentState();
}

class _DanhMucFragmentState extends State<DanhMucFragment> {
  late List<DanhMuc> danhMucs = [];
  bool loading = false;

  Future<void> _reloadDanhMuc(BuildContext context) async {
    setState(() {
      this.loading = true;
    });
    final provider =  Provider.of<DanhMucs>(context, listen: false);
    await provider.getListDanhMuc(context).then((value) {
      print("this.danhMucs.length ${this.danhMucs.length}");
      setState(() {
        this.danhMucs = provider.items;
        print(this.danhMucs.length);
        loading = false;
      });
    });
        // .onError((error, stackTrace){
      // print(error.toString());
      // setState(() {
      //   loading = false;
      // });
    // });
  }

  @override
  void initState() {
    _reloadDanhMuc(context);

    super.initState();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
        title: Text('Danh mục', style: boldTextStyle(color: appStore.textPrimaryColor)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            child: TextIcon(
              text: 'Thêm danh mục',
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
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: this.danhMucs.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            DanhMuc danhMuc = this.danhMucs[index];
                            return Column(
                              children: [
                                Container(
                                  child: Text(danhMuc.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  alignment: Alignment.topLeft,
                                ),
                                Container(
                                  child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor: appStore.textPrimaryColor,
                                            ),
                                            child: ListItemDanhMuc(listContent: danhMuc.listContent,)
                                        ),
                                      )
                                  ),
                                  margin: EdgeInsets.only(bottom: 15),
                                )
                              ],
                            );
                          },
                        )
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

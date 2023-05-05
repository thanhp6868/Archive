import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghiep.dart';
import 'package:provider/provider.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghieps.dart';

import '../main.dart';
import '../providers/CauHinh.dart';
import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';

class ListSanLuong extends StatefulWidget {
  final Function(Map<String, dynamic>) callback;
  bool saving = false;
  int? nidPhieuTacNghiep;
  bool sua = false;

  ListSanLuong({
    required this.nidPhieuTacNghiep,
    required this.callback,
    required this.saving,
    this.sua = false
  });

  @override
  State<ListSanLuong> createState() => _ListSanLuongState();
}

class _ListSanLuongState extends State<ListSanLuong> {
  List<ChiTietPhieuTacNghiep> chiTietPhieuTacNghieps = [];

  List<dynamic> hangTau = [];
  List<dynamic> tacNghiep = [];
  List<dynamic> KichCoContainer = [];
  List<dynamic> ghiChu = [];
  List<dynamic> trangThaiRH = [];

  List<TextEditingController> containerController = [];
  List<String?> selectedHangTau = [];
  List<String?> selectedSizeContainer = [];
  List<String?> selectedTrangThaiRH = [];
  List<String?> selectedTacNghiep = [];
  List<String?> selectedGhiChu = [];
  int soThuTu = 0;
  bool saving = false;
  List<int> nidChiTietPhieuTacNghiep = [];
  List<bool> field_loi_so_container = [];
  bool loading = false;
  int globalIndex = 0;

  Future<void> _submit(bool insert, int index, bool themDongMoi) async{
    print('insert ${insert}');
    setState(() {
      this.saving = true;
    });

    ChiTietPhieuTacNghiep chiTietPhieuTacNghiep = await Provider.of<ChiTietPhieuTacNghiep>(context, listen: false);
    chiTietPhieuTacNghiep.save(context, {
      'nid': insert ? null : nidChiTietPhieuTacNghiep[index],
      'field_so_container': containerController[index].text,
      'field_hang_tau': selectedHangTau[index],
      'field_kich_co_container': selectedSizeContainer[index],
      'field_tac_nghiep': selectedTacNghiep[index],
      'field_ghi_chu': selectedGhiChu[index],
      'field_trang_thai_rh': selectedTrangThaiRH[index],
      'field_phieu_tac_nghiep': widget.nidPhieuTacNghiep,
      'insert': insert
    }).then((value){
      print("2chiTietPhieuTacNghiep.nid ${chiTietPhieuTacNghiep.nid}");
      if(chiTietPhieuTacNghiep.nid != 0){
        setState(() {
          nidChiTietPhieuTacNghiep[index] = chiTietPhieuTacNghiep.nid;
          field_loi_so_container[index] = chiTietPhieuTacNghiep.field_loi_so_container;

        });
        if(themDongMoi){
          setState(() {
            print("chiTietPhieuTacNghiep.nid ${chiTietPhieuTacNghiep.nid}");

            containerController.add(new TextEditingController());
            selectedHangTau.add(null);
            selectedSizeContainer.add(null);
            selectedTrangThaiRH.add(null);
            selectedTacNghiep.add(null);
            selectedGhiChu.add(null);
            nidChiTietPhieuTacNghiep.add(0);
            field_loi_so_container.add(false);
            soThuTu++;

            print("nidChiTietPhieuTacNghiep ${nidChiTietPhieuTacNghiep}");

            ChiTietPhieuTacNghiep newChiTietPhieuTacNghiep = ChiTietPhieuTacNghiep();
            newChiTietPhieuTacNghiep.nid = chiTietPhieuTacNghiep.nid;
            chiTietPhieuTacNghieps.add(newChiTietPhieuTacNghiep);
          });
        }
      }

      setState(() {
        this.saving = false;
      });

    }).onError((error, stackTrace){
      setState(() {
        this.saving = false;
      });
    });
  }

  Future<void> _loadCauHinh() async{
    CauHinh cauHinh = await Provider.of<CauHinh>(context, listen: false);
    cauHinh.getKhoiTaoForm(context).then((value){
      setState(() {
        hangTau = cauHinh.hangTau;
        tacNghiep = cauHinh.tacNghiep;
        ghiChu = cauHinh.ghiChu;
        trangThaiRH = cauHinh.trangThaiRH;
        KichCoContainer = cauHinh.KichCoContainer;
      });
    });
  }

  Future<void> _loadListChiTietPhieu() async{
    ChiTietPhieuTacNghieps chiTietPhieuTacNghiepsProvider = await Provider.of<ChiTietPhieuTacNghieps>(context, listen: false);
    chiTietPhieuTacNghiepsProvider.getListChiTietPhieuTacNghiep(context, widget.nidPhieuTacNghiep!).then((value){
      setState(() {
        soThuTu = 0;
        chiTietPhieuTacNghiepsProvider.items.forEachIndexed((element, index) {
          containerController.add(new TextEditingController());
          containerController[index].text = element.field_so_container;
          selectedHangTau.add(element.field_hang_tau);
          selectedSizeContainer.add(element.field_kich_co_container);
          selectedTrangThaiRH.add(element.field_trang_thai_rh);
          selectedTacNghiep.add(element.field_tac_nghiep);
          selectedGhiChu.add(element.field_ghi_chu);
          nidChiTietPhieuTacNghiep.add(element.nid);
          field_loi_so_container.add(element.field_loi_so_container);
          soThuTu++;

          ChiTietPhieuTacNghiep chiTietPhieu = new ChiTietPhieuTacNghiep(
            field_trang_thai_rh: element.field_trang_thai_rh,
            field_tac_nghiep: element.field_tac_nghiep,
            field_ghi_chu: element.field_ghi_chu,
            field_kich_co_container: element.field_kich_co_container,
            field_so_container: element.field_so_container,
            field_hang_tau: element.field_hang_tau,
          );
          chiTietPhieu.nid = element.nid;

          chiTietPhieuTacNghieps.add(chiTietPhieu);

        });
        containerController.add(new TextEditingController());
        selectedHangTau.add(null);
        selectedSizeContainer.add(null);
        selectedTrangThaiRH.add(null);
        selectedTacNghiep.add(null);
        selectedGhiChu.add(null);
        field_loi_so_container.add(false);
        nidChiTietPhieuTacNghiep.add(0);
        soThuTu++;
      });
    });
  }

  Future<void> loadData() async{
    setState(() {
      loading = true;
    });
    _loadCauHinh();
    if(widget.sua)
      _loadListChiTietPhieu();

    setState(() {
      loading = false;
    });
  }

  Future<void> _deleteChiTietPhieu(BuildContext context, int index) async {
    setState(() {
      chiTietPhieuTacNghieps[index].deleting = true;
    });

    final provider = Provider.of<ChiTietPhieuTacNghiep>(context, listen: false);

    provider.delete(context, chiTietPhieuTacNghieps[index].nid).then((value) {
      setState(() {
        chiTietPhieuTacNghieps.removeAt(index);

        setState(() {
          containerController.removeAt(index);
          nidChiTietPhieuTacNghiep.removeAt(index);
          field_loi_so_container.removeAt(index);
          selectedHangTau.removeAt(index);
          selectedSizeContainer.removeAt(index);
          selectedTrangThaiRH.removeAt(index);
          selectedTacNghiep.removeAt(index);
          selectedGhiChu.removeAt(index);
        });
      });
    });
  }

  @override
  void initState() {
    loadData();
    if(!widget.sua){
      Timer.periodic(Duration(seconds: 1), (_) => {
        if((containerController.length == 0 && widget.nidPhieuTacNghiep != null && widget.nidPhieuTacNghiep != 0))
          {
            setState(() {
              containerController.add(new TextEditingController());
              selectedHangTau.add(null);
              selectedSizeContainer.add(null);
              selectedTrangThaiRH.add(null);
              selectedTacNghiep.add(null);
              selectedGhiChu.add(null);
              field_loi_so_container.add(false);
              nidChiTietPhieuTacNghiep.add(0);
            })
          }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading ? Center(child: Text('Đang tải dữ liệu...'),) :
        nidChiTietPhieuTacNghiep.length > 0 ? ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text('STT: ${(index + 1)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                        alignment: Alignment.topLeft,
                      ),
                      (nidChiTietPhieuTacNghiep[index] != null && nidChiTietPhieuTacNghiep[index] != 0) ? TextButton(
                        onPressed: (){
                          _submit(false, index, false);
                        },
                        child: TextIcon(
                          text: 'Cập nhật',
                          prefix: Icon(Ionicons.save, size: 16, color: Colors.blueAccent,),
                          textStyle: TextStyle(color: Colors.blueAccent),
                        )
                      ) : TextIcon(
                        text: 'Chưa lưu tác nghiệp',
                        prefix: Icon(Ionicons.warning, color: Colors.orange,),
                        textStyle: TextStyle(color: Colors.orange),
                      ),
                      (nidChiTietPhieuTacNghiep[index] != null && nidChiTietPhieuTacNghiep[index] != 0) ? (
                        chiTietPhieuTacNghieps[index].deleting ? Center(child: CircularProgressIndicator(),) :
                        TextButton(onPressed: (){
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
                                        _deleteChiTietPhieu(context, index);
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
                        }, child: TextIcon(
                          text: 'Xoá',
                          prefix: Icon(Ionicons.trash, size: 16, color: Colors.red,),
                          textStyle: TextStyle(color: Colors.red),
                        ))
                      ) : SizedBox(),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  8.height,
                  Row(
                    children: [
                      Expanded(child: AppTextField(
                        controller: containerController[index],
                        textCapitalization: TextCapitalization.characters,
                        textFieldType: TextFieldType.OTHER,
                        decoration: rfInputDecoration(
                          lableText: "Container",
                          showLableText: true,
                        ),
                      )),
                    ],
                  ),
                  Container(
                    child: field_loi_so_container[index] ? TextIcon(
                      textStyle: TextStyle(color: Colors.orange),
                      text: 'Số Container không hợp lệ',
                      prefix: Icon(Ionicons.warning, color: Colors.orange,),
                    ) : SizedBox(),
                    alignment: Alignment.topLeft,
                  ),
                  16.height,
                  Row(
                    children: [
                      Expanded(child:
                      Container(
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                        ),
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: DropdownButton<String>(
                          value: selectedHangTau[index],
                          elevation: 16,
                          style: primaryTextStyle(),
                          hint: Text('Hãng tàu', style: primaryTextStyle()),
                          isExpanded: true,
                          underline: Container(
                            height: 0,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedHangTau[index] = newValue!;
                            });
                          },
                          items: this.hangTau.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                      ),
                      8.width,
                      Expanded(child:
                        Container(
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                          backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                        ),
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: DropdownButton<String>(
                          value: selectedSizeContainer[index],
                          elevation: 16,
                          style: primaryTextStyle(),
                          hint: Text('Kích cỡ cont', style: primaryTextStyle()),
                          isExpanded: true,
                          underline: Container(
                            height: 0,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedSizeContainer[index] = newValue!;
                            });
                          },
                          items: this.KichCoContainer.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: boxDecorationWithRoundedCorners(
                              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                              backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                            ),
                            padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                            child: DropdownButton<String>(
                              value: selectedTrangThaiRH[index],
                              elevation: 16,
                              style: primaryTextStyle(),
                              hint: Text('Trạng thái R/H', style: primaryTextStyle()),
                              isExpanded: true,
                              underline: Container(
                                height: 0,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedTrangThaiRH[index] = newValue!;
                                });
                              },
                              items: this.trangThaiRH.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                      ),
                      8.width,
                      Expanded(child:
                        Container(
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                            backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                          ),
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),

                          child: DropdownButton<String>(
                            value: selectedTacNghiep[index],
                            elevation: 16,
                            style: primaryTextStyle(),
                            hint: Text('Tác nghiệp', style: primaryTextStyle()),
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedTacNghiep[index] = newValue!;
                              });
                            },
                            items: this.tacNghiep.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ),
                    ],
                  ),
                  16.height,
                  Container(
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                      backgroundColor: appStore.isDarkModeOn ? cardDarkColor : editTextBgColor,
                    ),
                    padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: DropdownButton<String>(
                      value: selectedGhiChu[index],
                      elevation: 16,
                      style: primaryTextStyle(),
                      hint: Text('Ghi chú', style: primaryTextStyle()),
                      isExpanded: true,
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedGhiChu[index] = newValue!;
                        });
                      },
                      items: this.ghiChu.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(color: Colors.grey, ),
              );
            },
            itemCount: containerController.length
        ) : SizedBox(),
        16.height,
        (this.saving || widget.saving) ? Center(child: CircularProgressIndicator(),) :
        MaterialButton(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
            onPressed: () {
              print("widget.nidPhieuTacNghiep ${widget.nidPhieuTacNghiep}");
              // Nếu số lượng container == 0 thì lưu phiếu trước
              if(widget.nidPhieuTacNghiep == null || widget.nidPhieuTacNghiep == 0){
                widget.callback({
                  'type': 'savePhieuTacNghiep'
                });
                // print("widget.nidPhieuTacNghiep ${widget.nidPhieuTacNghiep}");
                // if(containerController.length == 0 && widget.nidPhieuTacNghiep != null && widget.nidPhieuTacNghiep != 0){
                //   setState(() {
                //     containerController.add(new TextEditingController());
                //     selectedHangTau.add(null);
                //     selectedSizeContainer.add(null);
                //     selectedTrangThaiRH.add(null);
                //     selectedTacNghiep.add(null);
                //     selectedGhiChu.add(null);
                //   });
                // }
              }
              else{
                print("this.chiTietPhieuTacNghieps.length ${this.chiTietPhieuTacNghieps.length}");
                _submit(true, this.containerController.length - 1 , true); // lưu chi tiét mới nhất
              }
              print("widget.nidPhieuTacNghiep ${widget.nidPhieuTacNghiep}");
            },
            color: getColorFromHex('#19A7CE'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              // side: BorderSide(
              //   color: Colors.red,
              // )
            ),
            child: TextIcon(
              text: 'Lưu và thêm tác nghiệp',
              textStyle: TextStyle(color: Colors.white),
              prefix: Icon(Ionicons.add_circle, color: Colors.white,),
            )
        ),
      ],
    );
  }
}

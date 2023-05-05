import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/providers/CauHinh.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghiep.dart';
import 'package:tancang/providers/ChiTietPhieuTacNghieps.dart';
import 'package:tancang/providers/DanhMuc.dart';
import 'package:tancang/providers/DanhMucs.dart';
import 'package:tancang/providers/PhieuTacNghiep.dart';
import 'package:tancang/providers/PhieuTacNghieps.dart';
import 'package:tancang/providers/auth.dart';
import 'package:tancang/screens/RFEmailSignInScreen.dart';

import 'package:tancang/screens/RFHomeScreen.dart';
import 'package:tancang/screens/RFSignUpScreen.dart';
import 'package:tancang/screens/RFSplashScreen.dart';
import 'package:tancang/store/AppStore.dart';
import 'package:tancang/utils/AppTheme.dart';
import 'package:tancang/utils/RFConstant.dart';
import 'package:provider/provider.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) =>  Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, CauHinh>(
          create: (_) => CauHinh('', 0),
          update: (_, auth, previousSanPhams) {
            return CauHinh(
              auth.token,
              auth.userId.toInt()
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, PhieuTacNghiep>(
          create: (_) => PhieuTacNghiep(uid: 0, authToken: '', chiTietPhieuTacNghieps: []),
          update: (_, auth, previousSanPhams) {
            return PhieuTacNghiep(
              authToken: auth.token,
              uid: auth.userId.toInt(),
              chiTietPhieuTacNghieps: []
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, PhieuTacNghieps>(
          create: (_) => PhieuTacNghieps(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return PhieuTacNghieps(
              authToken: auth.token,
              uid: auth.userId.toInt(),
              items: []
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, ChiTietPhieuTacNghiep>(
          create: (_) => ChiTietPhieuTacNghiep(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return ChiTietPhieuTacNghiep(
              authToken: auth.token,
              uid: auth.userId.toInt()
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, ChiTietPhieuTacNghieps>(
          create: (_) => ChiTietPhieuTacNghieps(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return ChiTietPhieuTacNghieps(
              authToken: auth.token,
              uid: auth.userId.toInt()
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, DanhMuc>(
          create: (_) => DanhMuc(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return DanhMuc(
              authToken: auth.token,
              uid: auth.userId.toInt()
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, DanhMucs>(
          create: (_) => DanhMucs(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return DanhMucs(
                uid: auth.userId.toInt(),
              authToken: auth.token,
            );
          },
          // create: ,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          scrollBehavior: SBehavior(),
          navigatorKey: navigatorKey,
          title: 'Tác nghiệp Tân Cảng',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: auth.isAuth ? RFHomeScreen() :  RFSplashScreen(),
          routes: {
            RFHomeScreen.routeName: (ctx) => RFHomeScreen(),
            RFEmailSignInScreen.routeName: (ctx) => RFEmailSignInScreen(),
            RFSignUpScreen.routeName: (ctx) => RFSignUpScreen(),
          },
        ),
      ),
    );
  }
}

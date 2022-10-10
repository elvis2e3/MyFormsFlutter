import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforms/share_prefs/app_pref.dart';
import 'package:myforms/routes.dart';
import 'package:myforms/controllers/config_controller.dart';

void main() {
  final pref = AppPref();
  pref.initPrefs().then((value){
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pref = AppPref();
    final configCtrl = Get.put(ConfigController());
    if(pref.isDarkMode){
      configCtrl.theme.value = configCtrl.themeDark.value;
    }else{
      configCtrl.theme.value = configCtrl.themeLight.value;
    }

    return Obx((){
      return GetMaterialApp(
        title: 'My Forms',
        theme: configCtrl.theme.value,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        initialRoute: pref.rutaPage,
        getPages: getRoutes(),
      );
    });
  }
}

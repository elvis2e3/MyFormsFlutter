import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforms/widgets/text_file_custom.dart';
import 'package:myforms/common/enums.dart';
import 'package:myforms/api/client_api.dart';
import 'package:myforms/share_prefs/app_pref.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlUser = TextEditingController();
    TextEditingController ctrlPass = TextEditingController();
    TextEditingController ctrlUrl = TextEditingController();
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    AppPref pref = AppPref();
    if(pref.username != "" && pref.pass != ""){
      ctrlUser.text = pref.username;
      ctrlPass.text = pref.pass;
      ctrlUrl.text = pref.url;
    }
    Size size = Get.size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        width: size.width,
        height: size.height,
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              Center(
                child: Text(
                  "My Form",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextFileCustom(
                title: "Host",
                controller: ctrlUrl,
                validateText: ValidateText.text,
              ),
              SizedBox(height: 10,),
              TextFileCustom(
                title: "Usuario",
                controller: ctrlUser,
                validateText: ValidateText.email,
              ),
              SizedBox(height: 10,),
              TextFileCustom(
                title: "Contraseña",
                controller: ctrlPass,
                isPass: true,
              ),
              SizedBox(height: 10,),
              Container(
                width: size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(keyForm.currentState!.validate()){
                      final reponse = await ApiClient().authAdmin(
                        ctrlUrl.text,
                        ctrlUser.text,
                        ctrlPass.text
                      );
                      if(reponse.status){
                        pref.username = ctrlUser.text;
                        pref.pass = ctrlPass.text;
                        pref.url = ctrlUrl.text;
                        Get.toNamed('/dashboard/');
                      }else{
                        Get.defaultDialog(
                          title: "Error",
                          content: Text("Datos Incorrectos!!")
                        );
                      }
                    }
                  },
                  child: const Text("Entrar")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


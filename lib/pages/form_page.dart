import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:myforms/controllers/data_controller.dart';
import 'package:myforms/api/client_api.dart';
import 'package:myforms/widgets/text_file_custom.dart';
import 'package:myforms/common/enums.dart';


class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.put(DataController());
    CollectionModel data = dataController.collections[dataController.menu];
    List fields = data.schema;
    Size size = Get.size;
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    List<TextEditingController> ctrls = _getCtrls(fields);
    List<Widget> listFiels = _getFields(fields, ctrls);
    return Scaffold(
      appBar: AppBar(
        title: Text("Form ${data.name}"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        width: size.width,
        height: size.height,
        child: Form(
          key: keyForm,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "New Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ...listFiels,
              _createButton(size, keyForm)
            ],
          ),
        ),
      ),
    );
  }

  Widget _createButton(Size size, GlobalKey<FormState> keyForm){
    return Container(
      width: size.width,
      height: 40,
      child: ElevatedButton(
        onPressed: () async {
          if(keyForm.currentState!.validate()){
          //   final reponse = await ApiClient().authAdmin(ctrlUser.text, ctrlPass.text);
          //   if(reponse.status){
          //     pref.username = ctrlUser.text;
          //     pref.pass = ctrlPass.text;
          //     Get.toNamed('/dashboard/');
          //   }else{
          //     Get.defaultDialog(
          //       title: "Error",
          //       content: Text("Datos Incorrectos!!")
          //     );
          //   }
          }
        },
        child: const Text("Crear")
      ),
    );
  }

  List<TextEditingController> _getCtrls(List fields){
    List<TextEditingController> res = [];
    int index = 0;
    fields.forEach((element) {
      if(element.name != "id"){
        res.add(TextEditingController());
        index++;
      }
    });
    return res;
  }

  List<Widget> _getFields(List fields, List<TextEditingController> ctrls){
    List<Widget> res = [];
    int index = 0;
    ValidateText type = ValidateText.text;
    fields.forEach((element) {
      if(element.name != "id"){
        res.add(
          TextFileCustom(
            title: element.name,
            controller: ctrls[index],
            validateText: type,
          )
        );
        res.add(SizedBox(height: 10,));
        index++;
      }
    });
    return res;
  }

}

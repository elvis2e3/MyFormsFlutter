import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforms/widgets/drawer_custom.dart';
import 'package:myforms/api/client_api.dart';
import 'package:myforms/controllers/data_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.put(DataController());
    return Scaffold(
      appBar: AppBar(
      ),
      drawer: DrawerCustom(),
      body: dataController.collections.isEmpty?StreamBuilder(
        stream: ApiClient().getCollections().asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.status){
              List items = snapshot.data.data;
              items.forEach((element) {
                dataController.collections.value[element.id] = element;
              });
              return _getCollections(dataController);
            }
          }
          return Container();
        },
      ):_getCollections(dataController),
    );
  }

  Widget _getCollections(DataController dataController){
    Map data = dataController.collections;
    List<Widget> schema = [];
    data.forEach((key, value) {
        schema.add(
          ListTile(
            title: Text(value.name),
          )
        );
    });
    return ListView(
      children: schema,
    );
  }

}

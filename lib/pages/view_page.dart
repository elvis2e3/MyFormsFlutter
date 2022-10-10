import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myforms/widgets/drawer_custom.dart';
import 'package:myforms/controllers/data_controller.dart';
import 'package:myforms/api/client_api.dart';
import 'package:pocketbase/pocketbase.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.put(DataController());
    CollectionModel data = dataController.collections[dataController.menu];
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
        actions: [
          IconButton(onPressed: ()async{
            final listData = await ApiClient().getListData(data.name);
            if(listData.status){
              dataController.records.value[data.name] = listData.data;
              setState(() {

              });
            }
          }, icon: Icon(Icons.change_circle))
        ],
      ),
      drawer: DrawerCustom(),
      body: dataController.records[data.name] == null?StreamBuilder(
        stream: ApiClient().getListData(data.name).asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.status){
              return _getListData(snapshot.data.data, dataController, data);
            }
          }
          return Center(child: Text("Cargando..."),);
        },
      ): _getListData(dataController.records[data.name], dataController, data),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed("/form/");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _getListData(
    List data_collection,
    DataController dataController,
    CollectionModel data){
    List<Widget> listData = [];
    List fields = data.schema;
    Size size = Get.size;
    dataController.records.value[data.name] = data_collection;
    data_collection.forEach((element) {
      List<Widget> itemData = [];
      fields.forEach((field) {
        if(field.name != "id"){
          itemData.add(
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(children: [
                Text(
                  "${field.name}:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${element.data[field.name]}")
              ],),
            )
          );
          itemData.add(
            SizedBox(height: 1,),
          );
        }
      });
      listData.add(
        Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: itemData,
            ),
          ),
        )
      );
    });
    return ListView(
      children: listData,
    );
  }

}

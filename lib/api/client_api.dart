import 'package:pocketbase/pocketbase.dart';
import 'package:myforms/share_prefs/app_pref.dart';


class ApiClient{

  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();
  PocketBase _client = PocketBase("");
  late AdminAuth? userAdmin = null;

  Future<CustomResponse> authAdmin(String url, String email, String pass) async {
    try{
      _client = PocketBase(url);
      final response = await _client.admins.authViaEmail(email, pass);
      userAdmin = response;
      return CustomResponse(true, response);
    } on ClientException catch(e){
      return CustomResponse(false, e.response);
    }
  }

  Future<CustomResponse> getMenu() async {
    try{
      final response = await _client.records.getFullList('pb_menu', batch: 200, sort: '-created');
      return CustomResponse(true, response);
    } on ClientException catch(e){
      return CustomResponse(false, e.response);
    }
  }

  Future<CustomResponse> getListData(String menu) async {
    try{
      final response = await _client.records.getFullList(menu, batch: 200, sort: '-created');
      return CustomResponse(true, response);
    } on ClientException catch(e){
      return CustomResponse(false, e.response);
    }
  }

  Future<CustomResponse> getCollections() async {
    try{
      final response = await _client.collections.getFullList(batch: 200, sort: '-created');
      return CustomResponse(true, response);
    } on ClientException catch(e){
      return CustomResponse(false, e.response);
    }
  }

}

class CustomResponse{
  final _data;
  final bool _status;

  CustomResponse(this._status, this._data);

  get data{
    return _data;
  }
  bool get status{
    return _status;
  }
}

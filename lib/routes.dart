import 'package:get/get.dart';
import 'package:myforms/pages/login_page.dart';
import 'package:myforms/pages/dashboard_page.dart';
import 'package:myforms/pages/view_page.dart';
import 'package:myforms/pages/form_page.dart';


List<GetPage>getRoutes() {
  return [
     GetPage(name: "/", page: () => LoginPage()),
     GetPage(name: "/dashboard/", page: () => DashboardPage()),
     GetPage(name: "/view/", page: () => ViewPage()),
     GetPage(name: "/form/", page: () => FormPage()),
  ];
}

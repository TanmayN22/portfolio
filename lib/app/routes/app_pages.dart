import 'package:get/get.dart';
import 'package:porfolio/app/modules/home/view/home_view.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.HOME;

  static final routes = [
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
  ];
}

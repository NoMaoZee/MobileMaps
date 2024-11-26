import 'package:get/get.dart';
import '../bindings/location_binding.dart';
import '../views/location_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.location,
      page: () => LocationView(),
      binding: LocationBinding(),
    ),
  ];
}

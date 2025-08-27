import 'package:get/get.dart';

class HomeController extends GetxController {
  var product = List.generate(
    5,
    (index) => {
      'id': ' # ${index + 1}',
      'name': 'Product ke ${index + 1}',
      'desc': DateTime.now().toString(),
    },
  );
}

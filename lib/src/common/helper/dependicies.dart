import 'package:get/get.dart';

import '../services/storage_services.dart';

@override
void initState() {
  Get.put(StorageServices());
}

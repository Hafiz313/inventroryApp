import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';

import 'login_repository.dart';


class InventoryResultsController extends GetxController {
  var isLoading = false.obs;
  List<InventoryResultModel> inventoryResultsList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      inventoryResultsList= await Repository.getInventoryResluts();
      isLoading(true);
      print("===========inventoryResultsList: ${inventoryResultsList}========$isLoading======");
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}
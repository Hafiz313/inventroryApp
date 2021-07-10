import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';

import '../core/datamodels/LocationModels.dart';
import 'login_repository.dart';


class BrandController extends GetxController {
  var isLoading = false.obs;
  List<BrandModels> brandList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      brandList= await Repository.getBrandList();
      isLoading(true);
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}
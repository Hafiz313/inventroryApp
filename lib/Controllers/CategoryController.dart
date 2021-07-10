import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';

import 'login_repository.dart';


class CategoryController extends GetxController {
  var isLoading = false.obs;
  List<CategoryModels> categoryList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      categoryList= await Repository.getCategoryList();
      isLoading(true);
      print("===========categoryList: ${categoryList}========$isLoading======");
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}
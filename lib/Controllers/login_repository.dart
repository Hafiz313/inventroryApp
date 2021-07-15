import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/core/datamodels/SubcategoryModel.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "http://cserp.southeastasia.cloudapp.azure.com:55080/api/";

class Repository {

  static var isBrand=false.obs;
  static var isCategory=false.obs;
  static var isSubCategory=false.obs;

  //--------------get student account list------------
  static Future<bool>  getLogin(String userName,String password,String location,String fYear) async {

    isBrand(false);
    isCategory(false);
    isSubCategory(false);

  var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Login?username=$userName&Password=$password&Location=$location&Fyear=$fYear");
   //var url = Uri.parse(baseUrl + "Login");
    try{
      final response = await http.post(
        url,
        body: {
         /* 'username': "$userName",
          'Password': "$password",
          'Location': "$location",
          'Fyear': "$fYear",*/
        },
      );
    //  print(response.body);
  //    print("===${response.statusCode }====userName:$userName=======password:$password======location:$location====fYear:$fYear====response.body:${response.body}=====");
      if (response.statusCode == 200) {


        getBrandList();
        getCategoryList();
        getSubcategoryList();
        return true;
      } else {
        print('Failed');
        return false;
      }
    } catch(e){
      print('error $e');
      return false;
    }
  }



  static Future< List<LocationModels>>  getLocationList() async {

     var url = Uri.parse(baseUrl + "Locations");
    // var url = Uri.parse(baseUrl + "Locations");
    try{
      final response = await http.get(url);
       var body = json.decode(response.body);
      //  print(response.body);


      if (response.statusCode == 200) {
        return  locationModelsFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }
  static Future< List<BrandModels>>  getBrandList() async {

    var url = Uri.parse(baseUrl + "InventoryBrand");
    try{
      final response = await http.get(url);
      var body = json.decode(response.body);


      if (response.statusCode == 200) {
        PreferenceUtils.setString(kShareBrandList,response.body);
        isBrand(true);
        return  brandModelsFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }

  static Future< List<CategoryModels>>  getCategoryList() async {

    var url = Uri.parse(baseUrl + "InventoryType");
    try{
      final response = await http.get(url);

      var body = json.decode(response.body);


      print("========getCategoryList:$body============");

      //  print(response.body);


      if (response.statusCode == 200) {
        PreferenceUtils.setString(kShareCateGoryList,response.body);
        isCategory(true);
        return  categoryModelsFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }
  static Future< List<SubcategoryModels>>  getSubcategoryList() async {

    var url = Uri.parse(baseUrl + "InventoryStyle");
    try{
      final response = await http.get(url);

      var body = json.decode(response.body);
      print("========getSubcategoryList:$body============");

      //  print(response.body);


      if (response.statusCode == 200) {
        PreferenceUtils.setString(kShareSubCategoryList,response.body);
        isSubCategory(true);

        return  subcategoryModelsFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }
  static Future< List<InventoryResultModel>>  getInventoryResluts(String brandCode,String categoryCode,String subCategoryCode,String itemText) async {

    var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Inventory?Brand&Category&SubCategory&ItemName&Fyear=2019&pagesize=50&pageno=1");
    try{
      final response = await http.get(url);

      var body = json.decode(response.body);
      print("========getInventoryResluts:$body============");

      //  print(response.body);


      if (response.statusCode == 200) {
        return  inventoryResultModelFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }
  static Future< List<FyearModels>>  getFyearList() async {
    var url = Uri.parse(baseUrl + "Fyear");
    try{
      final response = await http.get(url);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        return  fyearModelsFromJson(body);
      } else {
        print('Failed');
      }
    } catch(e){
      print('error $e');

    }
  }
  //--------------log out student account ------------
  static logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
   //m Get.offAllNamed("/SignIn");
  }
}



import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "http://cserp.southeastasia.cloudapp.azure.com:55080/api/";

class Repository {

  static bool isLocationLoading=false;

  //--------------get student account list------------
  static Future<bool>  getLogin(String userName,String password,String location,String fYear) async {

    var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Login?username=admin&Password=12354&Location=01&Fyear=2019");
   // var url = Uri.parse(baseUrl + "Login");
    try{
      final response = await http.post(
        url,
        body: {
          /*'username': "$userName",
          'Password': "$password",
          'Location': "$location",
          'Fyear': "$fYear",*/
          'username': "admin",
          'Password': "12354",
          'Location': "01",
          'Fyear': "2019",
        },
      );
    //  print(response.body);
      print("===${response.statusCode }==========response.body:${response.body}=====");
      if (response.statusCode == 200) {

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
      //  print(response.body);


      if (response.statusCode == 200) {
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
        return  categoryModelsFromJson(body);

      } else {
        print('Failed');

      }
    } catch(e){
      print('error $e');

    }
  }
  static Future< List<InventoryResultModel>>  getInventoryResluts() async {

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
    Get.offAllNamed("/SignIn");
  }
}


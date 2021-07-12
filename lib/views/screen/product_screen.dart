import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/Controllers/BrandController.dart';
import 'package:inventory_app/Controllers/CategoryController.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/Controllers/SubCategoryController.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/core/datamodels/SubcategoryModel.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/utils/preference_utils.dart';
import 'package:inventory_app/views/screen/item_select_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  GlobalKey<FormState> productForm = GlobalKey<FormState>();
  static final TextEditingController _itemNameController = new TextEditingController();
  final CategoryController _categoryController = Get.put(CategoryController());
  final BrandController _brandController = Get.put(BrandController());
  final SubCategoryController _subCategoryController = Get.put(SubCategoryController());
  InventoryResultsController _inventoryResultsController;
  ProgressDialog pr;

 List<int> matchListIndex=[];

  BrandModels selectBrandValue;
 CategoryModels selectCategoryValue;
  SubcategoryModels selectSubcategoryValue;
  String selectSubcategoryStr= "Please select Items";
  String selectSubcategoryCode= "";
  bool isSubcategoryView=false;
  void dispose() {
    // TODO: implement dispose
    _itemNameController.clear();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    //print("======= PreferenceUtils:${ PreferenceUtils.getString(kShareLoginLocation)}====${  PreferenceUtils.getString(kShareLoginFyear)}===");
  //  getList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
      backgroundColor: Colors.white,
      progressWidget: Container(
          width: double.infinity,
          child: Center(child: SpinKitFadingCircle(color: Colors.black))),
    );
    AppSizes().init(context);
    return BaseScaffold(
      body: Obx(() {return SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: AppSizes.appVerticalLg * 0.6
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 50,),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text("Search Product",style: simpleText(fontSize: 20,color: kAppPrimaryColor),))),

              SizedBox(height: 100,),
              Form(
                key: productForm,
                child: Center(
                  child: Column(


                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Brand",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                      SizedBox(height: AppSizes.appVerticalLg *.1,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: kAppPrimaryColor),
                        ),
                        child:!_brandController.isLoading.value? SearchableDropdown(
                          items: _brandController.brandList.map((item) {
                            return new DropdownMenuItem<BrandModels>(
                                child: Text(item.name)
                                , value: item);
                          }).toList(),
                          isExpanded: true,
                          value: selectBrandValue,
                          isCaseSensitiveSearch: true,
                          searchHint: new Text(
                            'Select ',
                            style: new TextStyle(fontSize: 20,color: Colors.blue),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectBrandValue = value;
                              print("=======selectedValue :$selectBrandValue===");
                            });
                          },
                        ):Container(
                          height: 50,
                          child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //   Text("$selectLocation",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                        //   Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                        // ],),
                      ),


                     /* MyTextFormField(
                        hintText: "Enter Username",
                        validator: (value) => value.isEmpty ? "Empty"
                            : null,
                        isPassword: false,
                        isPhone: false,
                        isEmail: true,
                        autoFocus: false,
                        controller: _userNameController,
                      ),*/
                      SizedBox(height: AppSizes.appVerticalLg *.2,),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Category",style: simpleText(fontSize: 15,color:kAppPrimaryColor),)),
                      SizedBox(height: AppSizes.appVerticalLg *.1,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: kAppPrimaryColor),
                        ),
                        child:!_categoryController.isLoading.value? SearchableDropdown(
                          items: _categoryController.categoryList.map((item) {
                            return new DropdownMenuItem<CategoryModels>(
                                child: Text(item.name)
                                , value: item);
                          }).toList(),
                          isExpanded: true,
                          value: selectCategoryValue,
                          isCaseSensitiveSearch: true,
                          searchHint: new Text(
                            'Select ',
                            style: new TextStyle(fontSize: 20,color: Colors.blue),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectCategoryValue = value;
                              print("=============${selectCategoryValue.code.toString()}===============");
                            });
                            for(int i=0; i <=_categoryController.categoryList.length; i++){
                              if(_subCategoryController.list[i].type==selectCategoryValue.code.toString()){
                                matchListIndex.add(i);
                                //matchList.add(i);
                                print("========selectCategoryValue :${_subCategoryController.list[i].name}========");
                              }
                            }
                          },
                        ):Container(
                          height: 50,
                          child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //   Text("$selectLocation",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                        //   Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                        // ],),
                      ),
                      SizedBox(height: AppSizes.appVerticalLg *.2,),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Sub Category",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                      SizedBox(height: AppSizes.appVerticalLg *.1,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isSubcategoryView = !isSubcategoryView;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1,color: kAppPrimaryColor),
                          ),
                          child:
                 /*       SearchableDropdown(
                            items: _subCategoryController.list.map((item) {
                              return new DropdownMenuItem<SubcategoryModels>(
                                  child: Text(item.name)
                                  , value: item);
                            }).toList(),
                            isExpanded: true,
                            value: selectSubcategoryValue,
                            isCaseSensitiveSearch: true,
                            searchHint: new Text(
                              'Select ',
                              style: new TextStyle(fontSize: 20,color: Colors.blue),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectSubcategoryValue = value;
                                print("=======selectedValue :${selectSubcategoryValue.code}===");
                              });
                            },
                          )*/
                          //     :Container(
                          //   height: 50,
                          //   child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("$selectSubcategoryStr",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                              isSubcategoryView? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                          ],),
                        ),
                      ),
                      isSubcategoryView? Container(
                        height: 300,
                          margin: const EdgeInsets.only(
                              bottom: 0, left: 25, right: 25, top: 25),
                          child: matchListIndex.isNotEmpty?

                          Obx(() {
                            if (_subCategoryController.isLoading.value) {
                              return Container(
                                height: 50,
                                child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                              );
                            }
                            return ListView.builder(
                              itemCount: matchListIndex.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSubcategoryView = !isSubcategoryView;
                                        selectSubcategoryStr= _subCategoryController.list[matchListIndex[index]].name;
                                        selectSubcategoryCode= _subCategoryController.list[matchListIndex[index]].code;
                                      });
                                    },
                                    child: ListTile(
                                      title:
                                      Text(_subCategoryController.list[matchListIndex[index]].name),
                                    ));
                              },
                            );
                          }):Container(child: Center(child: Text("No Data")),)):Container(),
                      SizedBox(height: AppSizes.appVerticalLg *.2,),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Item Name",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                      SizedBox(height: AppSizes.appVerticalLg *.1,),
                      MyTextFormField(
                        hintText: "Enter item name",
                        validator: (value) => value.isEmpty ? "Empty"
                            : null,
                        isPassword: false,
                        isPhone: false,
                        isEmail: true,
                        autoFocus: false,
                        controller: _itemNameController,
                      ),
                      SizedBox(height: AppSizes.appVerticalLg *.4,),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.appHorizontalLg * 1
                        ),
                        width: double.infinity,
                        child:roundRectangleBtn(txt: "Search",textColor: kPrimaryTextColor,bgColor: kAppPrimaryColor,onPressed: () async {
                          pr.show();

                          var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Inventory?Brand=${selectBrandValue.code.toString()}&Category=${selectCategoryValue.code.toString()}&SubCategory=$selectSubcategoryCode&ItemName=${_itemNameController.text.toString()}&Fyear=${ PreferenceUtils.getString(kShareLoginFyear)}&pagesize=50&pageno=1");
                 //         var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Inventory?Brand=&Category=&SubCategory=&ItemName=&Fyear=2020&pagesize=50&pageno=1");
                          try{
                            final response = await http.get(url);

                            var body = json.decode(response.body);
                            print("===body:$body=====${selectBrandValue.code.toString()} ${selectCategoryValue.code.toString()} $selectSubcategoryCode ${_itemNameController.text.toString()}===========");

                            //  print(response.body);


                            if (response.statusCode == 200) {
                              pr.hide();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemSelectScreen(
                                        inventoryResultsList:inventoryResultModelFromJson(body),
                                      )));


                            } else {


                            }
                          } catch(e){
                            print('error $e');

                          }


                          // _inventoryResultsController = Get.put(InventoryResultsController());


                        }),
                      ),

                    ],
                  ),
                ),

              ),

            ],
          ),
        ),
      );}
    )
    );}

  openSpokenAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 5.0),
            content: Container(
                height: 330.00,
                width: 300.00,
                margin: const EdgeInsets.only(
                    bottom: 0, left: 25, right: 25, top: 25),
                child: Obx(() {
                  if (_subCategoryController.isLoading.value) {
                    return Container(
                      height: 50,
                      child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                    );
                  }
                  return ListView.builder(
                    itemCount: _subCategoryController.list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            title:
                            Text(_subCategoryController.list[index].name),
                          ));
                    },
                  );
                })),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {});
                      Navigator.of(context).pop();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {});
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }
}



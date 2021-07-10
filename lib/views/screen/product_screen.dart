import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/BrandController.dart';
import 'package:inventory_app/Controllers/CategoryController.dart';
import 'package:inventory_app/Controllers/FYearController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/core/veiwmodels/auth_viewmodel.dart';
import 'package:inventory_app/Controllers/login_repository.dart';
import 'package:inventory_app/views/screen/YourPage.dart';
import 'package:inventory_app/views/screen/item_select_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/utils/volidators.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:inventory_app/views/widgets/text_field.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';


class ProductScreen extends StatefulWidget {
  static const id="sign_in_page";
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  GlobalKey<FormState> productForm = GlobalKey<FormState>();
  bool _isVisible = false;
  static final TextEditingController _userNameController = new TextEditingController();
  static final TextEditingController _passwordController = new TextEditingController();
  final CategoryController _categoryController = Get.put(CategoryController());
  final BrandController _brandController = Get.put(BrandController());

 final LocationController _loginLocationController = Get.put(LocationController());

  BrandModels selectBrandValue;
  CategoryModels selectCategoryValue;
  LocationModels selectedLocationValue;
  FyearModels selectedFYearValue;
  void dispose() {
    // TODO: implement dispose
    _userNameController.clear();
    _passwordController.clear();
    super.dispose();
  }
      showProcessBar(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor:Color(0x01000000) ,
        contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
        content: Container(
          height: 50,
          child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),



        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // final _notifier = Provider.of<AuthViewModel>(context);
        return alert;
        // return Provider.value(value: _notifier, child: alert);;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
  //  getList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                      SizedBox(height: AppSizes.appVerticalLg *.2,),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Sub Category",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                      SizedBox(height: AppSizes.appVerticalLg *.1,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: kAppPrimaryColor),
                        ),
                        child:!_loginLocationController.isLoading.value? SearchableDropdown(
                          items: _loginLocationController.locationList.map((item) {
                            return new DropdownMenuItem<LocationModels>(
                                child: Text(item.name)
                                , value: item);
                          }).toList(),
                          isExpanded: true,
                          value: selectedLocationValue,
                          isCaseSensitiveSearch: true,
                          searchHint: new Text(
                            'Select ',
                            style: new TextStyle(fontSize: 20,color: Colors.blue),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedLocationValue = value;
                              print("=======selectedValue :$selectedLocationValue===");
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
                        controller: _userNameController,
                      ),
                      SizedBox(height: AppSizes.appVerticalLg *.4,),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.appHorizontalLg * 1
                        ),
                        width: double.infinity,
                        child:roundRectangleBtn(txt: "Search",textColor: kPrimaryTextColor,bgColor: kAppPrimaryColor,onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemSelectScreen(
                                  )));

                          // if(productForm.currentState.validate()){
                          //
                          //   showProcessBar(context);
                          //   bool isLogin = await Repository.getLogin(
                          //       "${_userNameController.value}",
                          //     "${_passwordController.value}",
                          //     "${selectedLocationValue.code}",
                          //         "$selectedFYearValue");
                          //
                          //   if(isLogin){
                          //     Navigator.pop(context);
                          //     Fluttertoast.showToast(msg: "Login", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                          //   }
                          //   else{
                          //     print("----------------not ok------------------");
                          //     Navigator.pop(context);
                          //     Fluttertoast.showToast(msg: "NOt", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
                          //     );
                          //   }
                          // }

                        //  signInForm.currentState.validate();
                        //  print("----------------not ok------------------");
                          //showProcessBar(context);
                         // openSpokenAlert();


                         // LocationModels locatonModels;
                         // locatonModels=await LoginController.getLocationList();
                         // List<FyearModels> fyerList;
                         // fyerList= LoginController.getFyearList();
                       //  print("======${fyerList[0].code}========");

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
                  if (_loginLocationController.isLoading.value) {
                    return Container(
                      height: 50,
                      child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                    );
                  }
                  return ListView.builder(
                    itemCount: _loginLocationController.locationList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            title:
                            Text(_loginLocationController.locationList[index].name),
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



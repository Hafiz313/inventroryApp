import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/screen/item_result_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';


class ItemSelectScreen extends StatefulWidget {
  static const id="sign_in_page";
  @override
  _ItemSelectScreenState createState() => _ItemSelectScreenState();
}

class _ItemSelectScreenState extends State<ItemSelectScreen> {

  GlobalKey<FormState> productForm = GlobalKey<FormState>();
  bool _isVisible = false;
  static final TextEditingController _userNameController = new TextEditingController();
  static final TextEditingController _passwordController = new TextEditingController();
  final InventoryResultsController _inventoryResultsController = Get.put(InventoryResultsController());
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
      body: Obx(() {

        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
                alignment: Alignment.centerLeft,
                child: Center(child: Text("Please Select Items",style: simpleText(fontSize: 20,color: kAppPrimaryColor),))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: MyTextFormField(
                hintText: "Search",
                validator: (value) => value.isEmpty ? "Empty"
                    : null,
                isPassword: false,
                isPhone: false,
                isEmail: true,
                autoFocus: false,
                controller: _userNameController,
              ),
            ),
            Expanded(
              child: _inventoryResultsController.isLoading.value?  Container(
        height: 50,
        child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
        ):ListView.builder(
                itemCount: _inventoryResultsController.inventoryResultsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemResultScreen(
                                  inventoryResultModel: _inventoryResultsController.inventoryResultsList[index],
                                )));
                      },
                      child: ListTile(
                        title:
                        Text(_inventoryResultsController.inventoryResultsList[index].name),
                      ));
                },
              ),
            ),
          ],
        );
      }));}

}



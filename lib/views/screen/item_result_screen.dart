import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/BrandController.dart';
import 'package:inventory_app/Controllers/FYearController.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/core/veiwmodels/auth_viewmodel.dart';
import 'package:inventory_app/Controllers/login_repository.dart';
import 'package:inventory_app/views/screen/YourPage.dart';
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


class ItemResultScreen extends StatefulWidget {

  final InventoryResultModel inventoryResultModel;

  const ItemResultScreen({Key key, this.inventoryResultModel}) : super(key: key);
  @override
  _ItemResultScreenState createState() => _ItemResultScreenState();
}

class _ItemResultScreenState extends State<ItemResultScreen> {

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return BaseScaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                alignment: Alignment.centerLeft,
                child: Center(child: Text("${widget.inventoryResultModel.name}",style: simpleText(fontSize: 20,color: kAppPrimaryColor),textAlign: TextAlign.center,))),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child: Table(
                border: TableBorder.all(
                    color: kAppPrimaryColor,
                    style: BorderStyle.solid,
                    width: 2),
                children: [
                  TableRow(
                      children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Text('SM Rate', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.smRate}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                  ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Wholesale', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.wholeSale}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Group Fix', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.groupFix}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Company Fix', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.companyFix}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Lock Rate', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.lockRate}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Commission', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.commission}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),




              ],),

            ),
            SizedBox(height: 30,),
            widget.inventoryResultModel.stock.length >0?  Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child:Table(

                border: TableBorder.all(
                    color: kAppPrimaryColor,
                    style: BorderStyle.solid,
                    width: 2),
                children:
                List.generate(widget.inventoryResultModel.stock.length,(index){
    return TableRow(children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.stock[index].locationName}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.stock[index].stock}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                      ]);}
                ,),
            )
            ):Container()],
        ),
      ))

    ;}

}



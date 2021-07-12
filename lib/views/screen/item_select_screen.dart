import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/screen/item_result_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';


class ItemSelectScreen extends StatefulWidget {
  final  List<InventoryResultModel> inventoryResultsList;

  const ItemSelectScreen({Key key, this.inventoryResultsList}) : super(key: key);


  @override
  _ItemSelectScreenState createState() => _ItemSelectScreenState();
}

class _ItemSelectScreenState extends State<ItemSelectScreen> {

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return BaseScaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: widget.inventoryResultsList.length >1 ? ListView.builder(
          itemCount: widget.inventoryResultsList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemResultScreen(
                            inventoryResultModel: widget.inventoryResultsList[index],
                          )));
                },
                child: ListTile(
                  title:
                  Text(widget.inventoryResultsList[index].name),
                ));
          },
        ):Container(child: Center(child: Text("No Data found")),),
      )

    );}

}



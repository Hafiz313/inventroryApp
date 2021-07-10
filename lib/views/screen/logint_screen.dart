import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/FYearController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';
import 'demo.dart';

/*List<dynamic> subjectDuplicateItems = [];
List<dynamic> gradeDuplicateItems = [];*/
List<dynamic> subjectItems;
//var gradeItems = [];

class LoginScreen extends StatefulWidget {
  static const id="sign_in_page";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> signInForm = GlobalKey<FormState>();
  bool _isVisible = false;
  static final TextEditingController _userNameController = new TextEditingController();
  static final TextEditingController _passwordController = new TextEditingController();
  final LocationController _loginLocationController = Get.put(LocationController());
  final FYearController _fYearController =Get.put(FYearController());
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
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: AppSizes.appVerticalLg *1.5,),
              Container(
                height: AppSizes.appVerticalLg * 2,
                width: AppSizes.appHorizontalLg * 3,
                child: Image(
                  image: AssetImage("images/logo.png"),
                ),
              ),
              Form(
                key: signInForm,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Username",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),

                 /*   DropdownButton<LocationModels>(
                        items: locationList.map((item) {
                      return new DropdownMenuItem<LocationModels>(
                          child: Text(item.name)
                          , value: item);
                    }).toList(),
    onChanged: (value) {
       setState(() {
    selectedValue = value;
          print(selectedValue);
        });
      },
                    ),*/
                    MyTextFormField(
                      hintText: "Enter Username",
                      validator: (value) => value.isEmpty ? "Empty"
                          : null,
                      isPassword: false,
                      isPhone: false,
                      isEmail: true,
                      autoFocus: false,
                      controller: _userNameController,
                    ),
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(kPassword,style: simpleText(fontSize: 15,color:kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),
                    MyTextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 4) {
                          return 'Length should be greater than 4';
                        }

                        return null;
                      },
                      isPhone: false,
                      icon: IconButton(
                        icon: Icon(
                          _isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kAppPrimaryColor,

                        ),
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                      ),
                      hintText: "Enter Password",
                      isPassword: !_isVisible,
                      isEmail: false,
                      autoFocus: false,
                      controller: _passwordController,

                    ),
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Location",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),
                /*    Container(
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
                    ),*/
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Year",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1,color: kAppPrimaryColor),
                      ),
                      child:!_fYearController.isLoading.value? SearchableDropdown(
                        items: _fYearController.fYearList.map((item) {
                          return new DropdownMenuItem<FyearModels>(
                              child: Text(item.code)
                              , value: item);
                        }).toList(),
                        isExpanded: true,
                        value: selectedFYearValue,
                        isCaseSensitiveSearch: true,
                        searchHint: new Text(
                          'Select ',
                          style: new TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedFYearValue = value;
                            print("=======selectedFYearValue :${selectedFYearValue.code}===");
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
                    SizedBox(height: AppSizes.appVerticalLg *.4,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appHorizontalLg * 1
                      ),
                      width: double.infinity,
                      child:roundRectangleBtn(txt: kLogIn,textColor: kPrimaryTextColor,bgColor: kAppPrimaryColor,onPressed: () async {
                        Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                    )));

                        //  open(context);
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                )));*/
                        // if(signInForm.currentState.validate() && selectedLocationValue.code.toString().isNotEmpty && selectedFYearValue.toString().isNotEmpty){
                        //
                        //
                        //   showProcessBar(context);
                        //    bool isLogin = await Repository.getLogin(
                        //       "${_userNameController.value.text.toString()}",
                        //     "${_passwordController.value.text.toString()}",
                        //     "${selectedLocationValue.code.toString()}",
                        //         "${selectedFYearValue.code.toString()}");
                        //
                        //   if(isLogin){
                        //     Navigator.pop(context);
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => ProductScreen(
                        //             )));
                        //     Fluttertoast.showToast(msg: "Login Successfully $isLogin", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,);
                        //
                        //   }
                        //   else{
                        //     print("----------------not ok------------------");
                        //     Navigator.pop(context);
                        //     Fluttertoast.showToast(msg: "Login Error", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
                        //     );
                        //   }
                        // }
                        // else{
                        //   Fluttertoast.showToast(msg: "Fill all inputs", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
                        //   );
                        // }



                      }),
                    ),

                  ],
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


  open(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                contentPadding: EdgeInsets.only(top: 5.0),
                content: SingleChildScrollView(child: SearchInSubject()),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: kRedColor),
                        ),
                        onPressed: () {
                          setState(() {});
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              );
            },
          );
        });
  }
}
class SearchInSubject extends StatefulWidget {


  @override
  _SearchInSubjectState createState() => _SearchInSubjectState();
}

class _SearchInSubjectState extends State<SearchInSubject> {
  final LocationController _loginLocationController = Get.put(LocationController());
  static final TextEditingController _subjectController =
  TextEditingController();
  @override
  void initState() {
    subjectItems =_loginLocationController.locationList;
    print(subjectItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: _subjectController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subjectItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  //  print(subjectItems[index]);
                    print(subjectItems.length);
                    setState(() {});
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListTile(
                    title: Text('${subjectItems[index]}'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    print(query);
    print(subjectItems);
    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(subjectItems);
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        subjectItems.clear();
        subjectItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        subjectItems.clear();
        subjectItems.addAll(subjectItems);
      });
    }
  }
}




import 'dart:io';

import 'package:checker_app/components/my_text_field.dart';
import 'package:checker_app/components/take_picture_screen.dart';
import 'package:checker_app/main.dart';
import 'package:checker_app/presentation/bloc/guest_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:nfc_manager/nfc_manager.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String droptext = "Nam";
  List<String> options = <String>['Nam', 'Nữ', 'Khác'];
  String nfcID = '';
  File? image;

  final ScrollController listviewController = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // handle scanNfc
  Future<void> scanNFC() async {
    try {
      var tag = await FlutterNfcKit.poll();
      setState(() {
        nfcID = tag.id;
      });
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  // handle takePhoto
  Future<void> _navigatorAndTakePicture(BuildContext context) async {
    final imageFile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TakePictureScreen(),
      ),
    );
    if (imageFile != null) {
      setState(() => image = (imageFile));
    }

    print(imageFile);
  }

  // check full information
  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        nameController.text != " " &&
        phoneController.text.isNotEmpty &&
        phoneController.text != " " &&
        nfcID.isNotEmpty &&
        image != null;
  }

  // handle saveData
  Future<void> saveGuest(
    String name,
    String phone,
    String sex,
    String imageFile,
    String uid,
  ) async {
    final guestCubit = context.read<GuestCubit>();
    guestCubit.addData(name, phone, sex, imageFile, uid);
    setState(() {
      nameController.clear();
      phoneController.clear();
      nfcID = "";
      image = null;
    });
    Navigator.pushNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        children: [
          Container(
            padding: paddingScreen,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [bgwhite, bgblue, bgpurper],
              ),
            ),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(height: screenW * 0.2),
                Padding(
                  padding: paddingSmall,
                  child: Text(
                    "Điền thông tin khách ",
                    style: heading2,
                  ),
                ),

                // infor
                MyTextField(
                  screenW: screenW,
                  inputType: TextInputType.text,
                  textController: nameController,
                  hinttext: 'Tên đăng nhập',
                  icon: CupertinoIcons.person_crop_circle,
                ),
                MyTextField(
                  screenW: screenW,
                  inputType: TextInputType.number,
                  textController: phoneController,
                  hinttext: 'Số điện thoại',
                  icon: CupertinoIcons.phone_circle,
                ),

                // Sex
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenW,
                    padding:
                        const EdgeInsets.only(left: 10, right: 5, bottom: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: DropdownButton(
                      // menuWidth: screenW,
                      borderRadius: BorderRadius.circular(25),
                      value: droptext,
                      items:
                          options.map<DropdownMenuItem<String>>((String sex) {
                        return DropdownMenuItem(
                            value: sex, child: Center(child: Text(sex)));
                      }).toList(),
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: body1,
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onChanged: (String? sex) {
                        setState(() {
                          droptext = sex!;
                        });
                      },
                    ),
                  ),
                ),

                // Nfc scan
                Padding(
                  padding: paddingSmall,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        splashFactory:
                            InkSparkle.constantTurbulenceSeedSplashFactory,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            scanNFC();
                            // startNfc();

                            return Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      colors: [bgwhite, bgblue, bgpurper])),
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: "Mời quét thẻ: ",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: bold,
                                              color: Colors.blue),
                                          children: [],
                                        ),
                                      ),
                                      nfcID == ""
                                          ? const CircularProgressIndicator()
                                          : Text.rich(
                                              TextSpan(
                                                text: nfcID,
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.nfc_rounded,
                        color: Colors.green,
                      ),
                      label: nfcID == ""
                          ? Text(
                              "Quét thẻ khách để nhập UID",
                              overflow: TextOverflow.visible,
                              softWrap: false,
                              style: body2,
                            )
                          : Text(
                              "Đã nhận UID",
                              overflow: TextOverflow.visible,
                              softWrap: false,
                              style: body2,
                            ),
                    ),
                  ),
                ),

                // Take picture
                Padding(
                  padding: paddingScreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Hero(
                        tag: "CameraTag",
                        child: Container(
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          child: IconButton(
                            onPressed: () {
                              _navigatorAndTakePicture(context);
                            },
                            icon: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.camera,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                image == null
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: screenW,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(image!))),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Visibility(
            visible: isFormValid,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 28.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100),
                  onPressed: () =>
                      // Save Data
                      saveGuest(
                    nameController.text,
                    phoneController.text,
                    droptext,
                    image!.path,
                    nfcID,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "LƯU THÔNG TIN",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
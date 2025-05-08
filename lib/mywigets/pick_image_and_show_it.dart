import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/screens/sign_up.dart';
import 'package:wms/static_classes/user_informations.dart';

// ignore: must_be_immutable
class PickImageAndShowIt extends StatefulWidget {
  PickImageAndShowIt({super.key, this.scaffoldState});
  GlobalKey<ScaffoldState>? scaffoldState;
  @override
  State<PickImageAndShowIt> createState() => _PickImageAndShowItState();
}

class _PickImageAndShowItState extends State<PickImageAndShowIt> {
  File? _image;
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  Future<void> _takeAPhoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double diameter = size.width / 4;
    return InkWell(
      onTap: () async {
        scaffoldState.currentState!.showBottomSheet(
          showDragHandle: true,
          backgroundColor: Colors.grey,
          (context) => Container(
            width: double.infinity,
            height: size.height / 2,

            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: ConstantColors.backgroundColorTabBarIndicatorSelected,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  onPressed: () async {
                    await _pickImageFromGallery();
                    Navigator.pop(context);
                    if (_image != null) {
                      UserInformations.image = _image;
                    }
                    setState(() {});
                  },
                  child: Text(
                    'pick image from gallery',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: size.width / 18,
                    ),
                  ),
                ),
                MaterialButton(
                  color: ConstantColors.backgroundColorTabBarIndicatorSelected,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  onPressed: () async {
                    await _takeAPhoto();
                    Navigator.pop(context);
                    if (_image != null) {
                      UserInformations.image = _image;
                    }
                    setState(() {});
                  },
                  child: Text(
                    'take a photo',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: size.width / 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ConstantColors.backgroundColorTabBarIndicatorSelected,
        ),
        width: diameter,
        height: diameter,
        child:
            (_image != null)
                ? ClipOval(child: Image.file(_image!, fit: BoxFit.cover))
                : const FittedBox(
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'add Image\nrequired',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
      ),
    );
  }
}

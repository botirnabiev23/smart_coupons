import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_coupons/theme/colors.dart';

void showImagePickerOptions(
    BuildContext context,
    Function(ImageSource) pickImage,
    ) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text('Add a Coupon`s Photo'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            pickImage(ImageSource.camera);
          },
          child: Text(
            'Take a Photo',
            style: TextStyle(color: primaryColor, fontSize: 17),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            pickImage(ImageSource.gallery);
          },
          child: Text(
            'Choose from Gallery',
            style: TextStyle(color: primaryColor, fontSize: 17),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
        child: Text(
          'Cancel',
          style: TextStyle(color: primaryColor, fontSize: 17),
        ),
      ),
    ),
  );
}
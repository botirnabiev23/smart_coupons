import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupons_edit_page.dart';
import 'package:smart_coupons/theme/colors.dart';

void showAddLinkDialog(
  BuildContext context,
  TextEditingController linkController,
  Function updateUI,
) {
  TextEditingController tempController =
      TextEditingController(text: linkController.text);

  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text('Add Link'),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CupertinoTextField(
          controller: tempController,
          placeholder: 'www.site.com...',
          keyboardType: TextInputType.url,
          autofocus: true,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel', style: TextStyle(color: primaryColor)),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text(
            'Done',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            if (tempController.text.isNotEmpty) {
              linkController.text = tempController.text;
              updateUI();
            }
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

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

void showCouponBottomSheet(BuildContext context) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => const CouponsAddWidget(),
  );
}

void showCouponEditBottomSheet(
    BuildContext context, String title, String image) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => CouponsEditWidget(
      title: title,
      image: image,
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:smart_coupons/pages/coupons/coupons_add_page.dart';
import 'package:smart_coupons/theme/colors.dart';

void showAddLinkDialog(BuildContext context, TextEditingController controller) {
  showCupertinoDialog(
    context: context,
    builder:
        (context) => CupertinoAlertDialog(
          title: Text('Add Link'),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CupertinoTextField(
              controller: controller,
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}

void showImagePickerOptions(BuildContext context, Future<void> _pickImage) {
  showCupertinoModalPopup(
    context: context,
    builder:
        (context) => CupertinoActionSheet(
      title: Text('Add a Coupon`s Photo'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _pickImage;
          },
          child: Text(
            'Take a Photo',
            style: TextStyle(color: Color(0xff6600E4), fontSize: 17),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _pickImage;
          },
          child: Text(
            'Choose from Gallery',
            style: TextStyle(color: Color(0xff6600E4), fontSize: 17),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
        child: Text(
          'Cancel',
          style: TextStyle(color: Color(0xff6600E4), fontSize: 17),
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
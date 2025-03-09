import 'package:flutter/cupertino.dart';
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
          child: Text(
            'Cancel',
            style: TextStyle(color: primaryColor),
          ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/home/bloc/category_bloc.dart';
import 'package:smart_coupons/pages/home/widgets/edit_category_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';

void showCategoryOptions(BuildContext context, String id, String title) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text('Edit Category'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            showEditCategoryDialog(context, id, title);
          },
          child: Text(
            'Rename Category',
            style: TextStyle(color: primaryColor, fontSize: 17),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            context.read<CategoryBloc>().add(CategoryDeleteEvent(id));
          },
          child: Text(
            'Delete Category',
            style: TextStyle(color: Colors.red, fontSize: 17),
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


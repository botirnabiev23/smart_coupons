import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/db/app_database.dart';
import 'package:smart_coupons/model/categories_model.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'package:smart_coupons/theme/colors.dart';

import 'show_category_dialog.dart';

void showCategoryOptions(
  BuildContext context,
  Category couponCategory,
) {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<CategoryBloc>(),
      child: CupertinoActionSheet(
        title: Text('Edit Category'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              showAddOrEditCategoryDialog(
                context: context,
                title: couponCategory.title,
                categoryId: couponCategory.id,
                action: DialogAction.edit,
              );
            },
            child: Text(
              'Rename Category',
              style: TextStyle(color: primaryColor, fontSize: 17),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              context.read<CategoryBloc>().add(
                    CategoryDeleteEvent(
                      couponCategory.id,
                    ),
                  );
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
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'add_or_edit_category_dialog.dart';

enum DialogAction {
  add,
  edit,
}

void showAddOrEditCategoryDialog({
  required BuildContext context,
  required DialogAction action,
  String? title,
  String? categoryId,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<CategoryBloc>(),
        child: AddOrEditCategoryDialog(
          action: action,
          title: title,
          categoryId: categoryId,
        ),
      );
    },
  );
}

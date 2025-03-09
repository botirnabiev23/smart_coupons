import 'dart:ui';

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
  showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) => BlocProvider.value(
      value: context.read<CategoryBloc>(),
      child: AddOrEditCategoryDialog(
        action: action,
        title: title,
        categoryId: categoryId,
      ),
    ),
    transitionBuilder: (ctx, anim1, anim2, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: Tween<double>(begin: 0, end: 20).evaluate(anim1),
          sigmaY: Tween<double>(begin: 0, end: 20).evaluate(anim1),
        ),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      );
    },
  );
}

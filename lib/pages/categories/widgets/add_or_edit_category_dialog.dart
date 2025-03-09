import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'package:smart_coupons/pages/categories/widgets/show_category_dialog.dart';
import 'package:smart_coupons/theme/colors.dart';
import 'package:smart_coupons/widget/button_style_widget.dart';

class AddOrEditCategoryDialog extends StatelessWidget {
  final DialogAction action;
  final String? title;
  final String? categoryId;

  const AddOrEditCategoryDialog({
    super.key,
    required this.action,
    this.title,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 343,
        ),
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: AddOrEditCategoryView(
          action: action,
          title: title,
          categoryId: categoryId,
        ),
      ),
    );
  }
}

class AddOrEditCategoryView extends StatefulWidget {
  final DialogAction action;
  final String? title;
  final String? categoryId;

  const AddOrEditCategoryView({
    super.key,
    required this.action,
    this.categoryId,
    this.title,
  });

  @override
  State<AddOrEditCategoryView> createState() => _AddOrEditCategoryViewState();
}

class _AddOrEditCategoryViewState extends State<AddOrEditCategoryView> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.action == DialogAction.edit ? 'Edit Category' : 'New Category',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          controller: _controller,
          onChanged: (text) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
        SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 36,
                child: ButtonStyleWidget(
                  title: 'Cancel',
                  radius: 8,
                  function: () => Navigator.pop(context),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: _controller.text.trim().isNotEmpty
                      ? () {
                          final String title = _controller.text.trim();
                          if (widget.action == DialogAction.add) {
                            context
                                .read<CategoryBloc>()
                                .add(CategoryAddEvent(title));
                          } else {
                            context.read<CategoryBloc>().add(CategoryEditEvent(
                                  id: widget.categoryId ?? '',
                                  updatedTitle: title,
                                ));
                          }

                          Navigator.pop(context);
                        }
                      : null,
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        return Colors.white;
                      },
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Color(0xff6600E4).withOpacity(0.5);
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return Color(0xff6600E4).withOpacity(0.7);
                        }

                        return Color(0xff6600E4);
                      },
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                  ),
                  child: Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

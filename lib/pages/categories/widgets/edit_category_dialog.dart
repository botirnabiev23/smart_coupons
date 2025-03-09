import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/categories/bloc/category_bloc.dart';
import 'package:smart_coupons/theme/colors.dart';

void showEditCategoryDialog(BuildContext context, String id, String oldTitle) {
  TextEditingController categoryController =
  TextEditingController(text: oldTitle);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isActive = categoryController.text.trim().isNotEmpty;

          return Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.white.withOpacity(0.2)),
                ),
              ),
              Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 343),
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit Category',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: categoryController,
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
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0),
                                foregroundColor:
                                WidgetStateProperty.all(primaryColor),
                                backgroundColor: WidgetStateProperty.all(
                                    primaryColor.withOpacity(0.05)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              child: Text('Cancel'),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isActive
                                  ? () {
                                String newCategory =
                                categoryController.text.trim();
                                if (newCategory.isNotEmpty) {
                                  context.read<CategoryBloc>().add(
                                    CategoryEditEvent(
                                        id, newCategory),
                                  );
                                  Navigator.pop(context);
                                }
                              }
                                  : null,
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(0),
                                foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                                backgroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                    if (states.contains(WidgetState.disabled)) {
                                      return Color(0xff6600E4).withOpacity(0.5);
                                    }
                                    return Color(0xff6600E4);
                                  },
                                ),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'package:smart_coupons/pages/coupons/bloc/coupon_bloc.dart';
import 'package:smart_coupons/pages/coupons/widgets/add_link_dialog.dart';
import 'package:smart_coupons/pages/coupons/widgets/custom_box_widget.dart';
import 'package:smart_coupons/pages/coupons/widgets/image_picker_option.dart';
import 'package:smart_coupons/theme/colors.dart';
import 'package:smart_coupons/widget/show_date_widget.dart';
import 'package:smart_coupons/widget/text_field_widget.dart';

class CouponsAddWidget extends StatefulWidget {
  const CouponsAddWidget({super.key});

  @override
  State<CouponsAddWidget> createState() => _CouponsAddWidgetState();
}

class _CouponsAddWidgetState extends State<CouponsAddWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController controller = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  void addNewCoupon(BuildContext context, String name) {
    String? imagePath = _image?.path;

    String extractImageUrl(String url) {
      Uri uri = Uri.parse(url);
      return uri.queryParameters['imgurl'] ?? url;
    }

    if (imagePath?.isEmpty ?? true) {
      String? extractedUrl = linkController.text.isNotEmpty
          ? extractImageUrl(linkController.text)
          : null;
      imagePath = extractedUrl;
    }

    final newCoupon = Coupon(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      image: imagePath,
      date: DateTime.now(),
    );

    context.read<CouponBloc>().add(AddCoupon(newCoupon));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          previousPageTitle: 'Quit',
          middle: Text('New Coupon'),
          trailing: TextButton(
              onPressed: () => addNewCoupon(context, controller.text),
              child: Text('Save')),
        ),
        child: Material(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    child: Column(
                      children: [
                        const Gap(8),
                        TextFieldWidget(
                          controller: controller,
                          hintText: 'Name',
                        ),
                        if (linkController.text.isEmpty) ...[
                          const Gap(16),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () => showImagePickerOptions(
                              context,
                              _pickImage,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            child: _image == null
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/add_image_icon.svg',
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Add Image',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        child: Image.file(
                                          _image!,
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: CustomBox(
                                          onPressed: () {
                                            setState(() {
                                              _image = null;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                        if (_image == null) ...[
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: ColoredBox(
                                  color: Colors.grey.shade300,
                                  child: SizedBox(height: 1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  'Or',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ColoredBox(
                                  color: Colors.grey.shade300,
                                  child: SizedBox(height: 1),
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () =>
                                showAddLinkDialog(context, linkController, () {
                              setState(() {});
                            }),
                            borderRadius: BorderRadius.circular(24),
                            child: linkController.text.isEmpty
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/link_icon.svg',
                                        ),
                                        const Gap(8),
                                        Text(
                                          'Add Link',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : TextField(
                                    controller: linkController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                        const Gap(24),
                        ShowDateWidget(
                          dateTime: DateTime.now(),
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

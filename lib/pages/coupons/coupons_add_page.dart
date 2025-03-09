import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_coupons/model/coupon_model.dart';
import 'package:smart_coupons/model/image_source_model.dart';
import 'package:smart_coupons/pages/coupons/widgets/add_link_dialog.dart';
import 'package:smart_coupons/pages/coupons/widgets/custom_box_widget.dart';
import 'package:smart_coupons/pages/coupons/widgets/image_picker_option.dart';
import 'package:smart_coupons/theme/colors.dart';
import 'package:smart_coupons/widget/show_date_widget.dart';
import 'package:smart_coupons/widget/text_field_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class CouponsAddWidget extends StatefulWidget {
  const CouponsAddWidget({
    super.key,
  });

  @override
  State<CouponsAddWidget> createState() => _CouponsAddWidgetState();
}

class _CouponsAddWidgetState extends State<CouponsAddWidget> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _couponNameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  File? _image;
  bool isActive = true;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    String imagePath = pickedFile.path;
    setState(() {
      _image = File(imagePath);
    });
  }

  Future<Coupon?> _openAddCouponSheet(
    BuildContext context,
    String name,
  ) async {
    final imageUrl = _imageUrlController.text.trim();
    if (_image == null && imageUrl.isEmpty) {
      return null;
    }

    late ImageSourceModel imageSource;

    if (_image != null) {
      final appDir = await getApplicationDocumentsDirectory();

      final String fileName = path.basename(_image!.path);

      final savedImage = await _image!.copy('${appDir.path}/$fileName');

      imageSource = ImageSourceModel.local(savedImage.path);
    } else if (imageUrl.isNotEmpty) {
      imageSource = ImageSourceModel.network(imageUrl);
    } else {
      return null;
    }

    final newCoupon = Coupon(
      id: Uuid().v4(),
      name: name,
      imageSource: imageSource,
      date: DateTime.now(),
    );
    return newCoupon;
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
            onPressed: () async {
              final coupon = await _openAddCouponSheet(
                context,
                _couponNameController.text.trim(),
              );
              Navigator.pop(context, coupon);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color:
                    isActive ? primaryColor : Color.fromRGBO(220, 220, 221, 1),
              ),
            ),
          ),
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
                          controller: _couponNameController,
                          hintText: 'Name',
                        ),
                        const Gap(24),
                        if (_imageUrlController.text.isEmpty &&
                            _image == null) ...[
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: () => showImagePickerOptions(
                              context,
                              _pickImage,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
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
                            ),
                          ),
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
                            onTap: () => showAddLinkDialog(
                              context,
                              _imageUrlController,
                              () {
                                setState(() {});
                              },
                            ),
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
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
                            ),
                          ),
                        ],
                        if (_imageUrlController.text.isNotEmpty) ...[
                          TextField(
                            controller: _imageUrlController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: primaryColor),
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
                        ],
                        if (_image != null) ...[
                          Stack(
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

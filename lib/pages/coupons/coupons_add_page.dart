import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_coupons/pages/coupons/widgets/coupons_bottom_sheet_widgets.dart';
import 'package:smart_coupons/pages/coupons/widgets/coustom_box_widget.dart';
import 'package:smart_coupons/theme/colors.dart';

class CouponsAddWidget extends StatefulWidget {
  const CouponsAddWidget({super.key});

  @override
  State<CouponsAddWidget> createState() => _CouponsAddWidgetState();
}

class _CouponsAddWidgetState extends State<CouponsAddWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController controller = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    print("Picking image from $source...");
    final pickedFile = await _picker.pickImage(source: source);
    print("Picked file: $pickedFile");
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("Image selected: ${_image?.path}");
      });
    }
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
          trailing: TextButton(onPressed: () {}, child: Text('Save')),
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
                        TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Name',
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
                        const Gap(16),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap:
                              () => showImagePickerOptions(
                                context,
                                _pickImage,
                              ),
                          borderRadius: BorderRadius.circular(24),
                          child:
                              _image == null
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
                            onTap: () => showAddLinkDialog(context, controller),
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
                        const Gap(24),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff000000).withOpacity(0.03),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Use Before',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Feb 28, 2025',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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


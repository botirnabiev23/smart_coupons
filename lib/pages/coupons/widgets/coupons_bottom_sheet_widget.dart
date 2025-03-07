import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_coupons/theme/colors.dart';

void showCouponBottomSheet(BuildContext context) {
  showCupertinoSheet(
    context: context,
    pageBuilder: (BuildContext context) => const ImagePickerWidget(),
  );
}

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => CupertinoActionSheet(
            title: Text('Add a Coupon`s Photo'),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                child: Text(
                  'Take a Photo',
                  style: TextStyle(color: Color(0xff6600E4), fontSize: 17),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                child: Text(
                  'Choose from Gallery',
                  style: TextStyle(color: Color(0xff6600E4), fontSize: 17),
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

  void showAddLinkDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text('Add Link'),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CupertinoTextField(
                controller: _controller,
                placeholder: 'www.site.com...',
                keyboardType: TextInputType.url,
                autofocus: true,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Cancel', style: TextStyle(color: primaryColor)),
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
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
                              borderSide: BorderSide(color: Color(0xff6600E4)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xff6600E4),
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
                          onTap: _showImagePickerOptions,
                          borderRadius: BorderRadius.circular(24),
                          child:
                              _image == null
                                  ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(
                                        0xff6600E4,
                                      ).withOpacity(0.05),
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
                                            color: Color(0xff6600E4),
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
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            onTap: () => showAddLinkDialog(context),
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff6600E4).withOpacity(0.05),
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
                                      color: Color(0xff6600E4),
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
                                    color: Color(0xff6600E4).withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Feb 28, 2025',
                                    style: TextStyle(
                                      color: Color(0xff6600E4),
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

class CustomBox extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBox({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            child: const Center(
              child: Icon(Icons.close, size: 24, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

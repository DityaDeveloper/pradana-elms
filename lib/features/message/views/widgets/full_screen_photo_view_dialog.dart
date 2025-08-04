import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FullScreenPhotoViewDialog extends StatelessWidget {
  final String? image;

  const FullScreenPhotoViewDialog({
    super.key,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100.r),
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          Gap(30.h),
          image!.contains('http')
              ? Image.network(
                  image!,
                  fit: BoxFit.contain,
                )
              : Image.file(
                  File(image!),
                  fit: BoxFit.contain,
                ),
          Gap(30.h),
        ],
      ),
    );
  }
}

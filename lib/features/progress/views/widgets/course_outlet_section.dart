import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/progress/logic/certificate_download_controller.dart';
import 'package:lms/features/progress/logic/providers.dart';
import 'package:lms/features/progress/models/progress_model/course.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseOutlet extends ConsumerStatefulWidget {
  const CourseOutlet({
    super.key,
    required this.subjectList,
    required this.isCertificateAvailable,
  });

  final List<Course> subjectList;
  final bool isCertificateAvailable;

  @override
  ConsumerState<CourseOutlet> createState() => _CourseOutletState();
}

class _CourseOutletState extends ConsumerState<CourseOutlet> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  String filePath = '';

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getDownloadPath() async {
    Directory? directory;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        directory = await getApplicationDocumentsDirectory(); // Private storage
      } else {
        directory = Directory('/storage/emulated/0/Download'); // Public storage
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory.path;
  }

  Future<bool> _checkIfFileExists(String fileName) async {
    final directoryPath = await _getDownloadPath();
    filePath = '$directoryPath/$fileName'; // Dynamic filename
    return File(filePath).exists();
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      int sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        // Android 13+ does NOT allow WRITE_EXTERNAL_STORAGE
        // You must use private storage OR request "Manage External Storage" permission
        return true;
      }

      final storageStatus = await Permission.storage.request();
      if (storageStatus.isDenied) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
                content:
                    Text('Storage permission is required to download files.')),
          );
        return false;
      }

      if (storageStatus.isPermanentlyDenied) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: const Text(
                  'Storage permission is permanently denied. Enable it in settings.'),
              action: SnackBarAction(
                label: 'Open Settings',
                onPressed: () {
                  openAppSettings();
                },
              ),
            ),
          );
        return false;
      }

      if (sdkInt >= 29) {
        final manageStatus = await Permission.manageExternalStorage.request();
        if (manageStatus.isDenied || manageStatus.isPermanentlyDenied) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    const Text('Manage external storage permission required.'),
                action: SnackBarAction(
                  label: 'Open Settings',
                  onPressed: () {
                    openAppSettings();
                  },
                ),
              ),
            );
          return false;
        }
      }
    }
    return true;
  }

  Future<void> _downloadFile(String url) async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) return;
    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    try {
      final uri = Uri.parse(url);
      final fileName = uri.pathSegments.last;
      final directoryPath = await _getDownloadPath();
      filePath = '$directoryPath/$fileName';

      if (await File(filePath).exists()) {
        _openDownloadedFile(filePath);
        return;
      }

      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          setState(() {
            downloadProgress = received / total;
          });
        },
      );

      if (await File(filePath).exists()) {
        setState(() {
          isDownloading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download completed! File: $fileName')),
        );

        _openDownloadedFile(filePath);
      } else {
        throw Exception("Download failed, file not found.");
      }
    } catch (e) {
      setState(() {
        isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download error: ${e.toString()}')),
      );
    }
  }

  Future<void> _openDownloadedFile(String path) async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) return;

    final file = File(path);

    if (await file.exists()) {
      // OpenFile.open(path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(filePath: path),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File not found: $path")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, authBox, child) {
          int studentId = 0;
          final isAuth =
              authBox.get(AppConstants.authToken, defaultValue: null) == null
                  ? false
                  : true;

          if (isAuth) {
            studentId =
                authBox.get(AppConstants.userData, defaultValue: 0)?['id'];
          }
          return widget.isCertificateAvailable == true
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    widget.isCertificateAvailable == true
                        ? Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              // color: context.isDarkMode
                              //     ? context.chipsColor
                              //     : const Color(0xffF0F8FF),
                              color: context.cardColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Assets.pngs.certificate.image(),
                                  Gap(12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).congratulations,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Gap(4.h),
                                        Text(
                                          S.of(context).yourCertificate,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff2E2E2E),
                                          ),
                                        ),
                                        Gap(6.h),
                                        ref
                                            .watch(
                                                certificateDownloadControllerProvider(
                                              studentId: studentId,
                                              semesterId: ref
                                                      .read(
                                                          selectedProgressSemesterProvider)
                                                      ?.id ??
                                                  0,
                                            ))
                                            .when(
                                              data: (url) {
                                                final uri =
                                                    Uri.parse(url ?? '');
                                                final fileName =
                                                    uri.pathSegments.last;

                                                return FutureBuilder<bool>(
                                                  future: _checkIfFileExists(
                                                      fileName),
                                                  builder: (context, snapshot) {
                                                    final fileExists =
                                                        snapshot.data ?? false;

                                                    return InkWell(
                                                      onTap: () async {
                                                        if (fileExists) {
                                                          _openDownloadedFile(
                                                              filePath);
                                                        } else {
                                                          await _downloadFile(
                                                              url!);
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            isDownloading
                                                                ? S
                                                                    .of(context)
                                                                    .downloading
                                                                : fileExists
                                                                    ? S
                                                                        .of(
                                                                            context)
                                                                        .openFile
                                                                    : S
                                                                        .of(context)
                                                                        .tapToDownload,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          if (isDownloading)
                                                            const SizedBox(
                                                              height: 16,
                                                              width: 16,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                              ),
                                                            )
                                                          else
                                                            Icon(
                                                              fileExists
                                                                  ? Icons
                                                                      .open_in_new
                                                                  : Icons
                                                                      .download,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              error: (error, stack) =>
                                                  Text('Error: $error'),
                                              loading: () => const SizedBox(),
                                            )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Positioned.fill(
                      top: 110,
                      child: subjects(context),
                    )
                  ],
                )
              : subjects(context);
        });
  }

  Container subjects(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            context.isDarkMode ? context.chipsColor : const Color(0xffF0F8FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: widget.subjectList.isEmpty
          ? Center(
              child: Text(S.of(context).noCourseFound),
            )
          : GridView.custom(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.r,
                mainAxisSpacing: 12.r,
                mainAxisExtent: 190.h,
              ),
              padding: EdgeInsets.all(16.r).copyWith(bottom: 100.h),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: widget.subjectList.length,
                (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                        Routes.subjectBasedTeacher,
                        extra: {
                          'subjectId': widget.subjectList[index].id,
                          'subjectName': widget.subjectList[index].title,
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 56.r,
                                width: 56.r,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      widget.subjectList[index].thumbnail ?? '',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const Spacer(),
                              Transform(
                                alignment: Alignment.center,
                                transform: Localizations.localeOf(context)
                                            .languageCode ==
                                        'ar'
                                    ? Matrix4.rotationY(math.pi)
                                    : Matrix4.identity(),
                                child: SvgPicture.asset(Assets.svgs.arrowNext),
                              ),
                            ],
                          ),
                          Gap(5.h),
                          Text(
                            widget.subjectList[index].title ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              // color: const Color.fromARGB(255, 8, 14, 17),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Text(
                            S.of(context).lesson,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          _AnimationProgressBar(
                            progressValue: (widget.subjectList[index]
                                        .courseProgressPercentage ??
                                    0) /
                                100,
                            progressActiveColor: AppColors.primaryColor,
                          ),
                          Gap(4.h),
                          Text(
                            S.of(context).exam,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          _AnimationProgressBar(
                            progressValue: (widget.subjectList[index]
                                        .examProgressPercentage ??
                                    0) /
                                100,
                            progressActiveColor: const Color(0xff05C7B0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _AnimationProgressBar extends ConsumerStatefulWidget {
  const _AnimationProgressBar(
      {this.progressValue = 0.1, required this.progressActiveColor});

  final double progressValue;
  final Color progressActiveColor;

  @override
  ConsumerState<_AnimationProgressBar> createState() =>
      _AnimationProgressBarState();
}

class _AnimationProgressBarState extends ConsumerState<_AnimationProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: (widget.progressValue * 1000).toInt()));
    _animation =
        Tween(begin: 0.0, end: widget.progressValue).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: context.chipsColor,
                valueColor: AlwaysStoppedAnimation(widget.progressActiveColor),
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 7.h,
              ),
            ),
            Gap(8.w),
            Text(
              "${(_animation.value * 100).toInt()}%",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PdfViewerPage extends StatefulWidget {
  final String filePath;

  const PdfViewerPage({super.key, required this.filePath});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).certificate,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<bool>(
        future: File(widget.filePath).exists(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.data!) {
            return const Center(child: Text("File not found!"));
          }
          return SfPdfViewer.file(
            File(widget.filePath),
            onDocumentLoadFailed: (details) {
              setState(() {
                errorMessage = details.description;
              });
            },
          );
        },
      ),
    );
  }
}

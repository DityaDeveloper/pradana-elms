import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/features/progress/views/widgets/course_outlet_section.dart';
import 'package:lms/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyCourses extends ConsumerStatefulWidget {
  const MyCourses({super.key});

  @override
  ConsumerState<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends ConsumerState<MyCourses> {
  final Map<int, bool> _downloadingMap = {};
  final Map<int, double> _downloadProgressMap = {};
  final Map<int, Color> _itemColors = {};
  final Map<int, String> _filePaths = {};
  // Function to generate a random color
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // Fully opaque
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  Color _getItemColor(int courseId) {
    if (_itemColors[courseId] == null) {
      _itemColors[courseId] = getRandomColor().withOpacity(0.2);
    }
    return _itemColors[courseId]!;
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

  Future<bool> _checkIfFileExists(String fileName, int courseId) async {
    final directoryPath = await _getDownloadPath();
    final courseFilePath = '$directoryPath/$fileName';

    // Store path in map
    _filePaths[courseId] = courseFilePath;

    return File(courseFilePath).exists();
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

  Future<void> _downloadFile(String url, int courseId) async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) return;

    setState(() {
      _downloadingMap[courseId] = true;
      _downloadProgressMap[courseId] = 0.0;
    });

    try {
      final uri = Uri.parse(url);
      final fileName = uri.pathSegments.last;
      final directoryPath = await _getDownloadPath();
      final courseFilePath = '$directoryPath/$fileName';

      _filePaths[courseId] = courseFilePath; // Store path for this course

      if (await File(courseFilePath).exists()) {
        _openDownloadedFile(
            courseId); // FIXED: Pass courseId instead of file path
        return;
      }

      await Dio().download(
        url,
        courseFilePath,
        onReceiveProgress: (received, total) {
          setState(() {
            _downloadProgressMap[courseId] = received / total;
          });
        },
      );

      if (await File(courseFilePath).exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download completed! File: $fileName')),
        );
        _openDownloadedFile(
            courseId); // FIXED: Pass courseId instead of file path
      } else {
        throw Exception("Download failed, file not found.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download error: $e')),
      );
    } finally {
      setState(() {
        _downloadingMap[courseId] = false;
      });
    }
  }

  Future<void> _openDownloadedFile(int courseId) async {
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) return;

    final path = _filePaths[courseId];

    print("Opening file for courseId: $courseId, Path: $path");

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File path not found!")),
      );
      return;
    }

    final file = File(path);
    if (await file.exists()) {
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
          return Scaffold(
            backgroundColor:
                context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
            body: Column(
              children: [
                _headerSection(context),
                Gap(10.h),
                ref.watch(myCoursesProvider(studentId: studentId)).when(
                      data: (data) {
                        return Expanded(
                          child: data.isEmpty
                              ? Center(
                                  child: Text(S.of(context).noCoursePurchase),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final courseId = data[index].id ?? 0;
                                    final isDownloading =
                                        _downloadingMap[courseId] ?? false;
                                    return InkWell(
                                      onTap: () {
                                        // navigate to subject based teacher screen
                                        context.push(
                                          Routes.subjectBasedTeacher,
                                          extra: {
                                            'subjectId': data[index].id,
                                            'subjectName': data[index].title,
                                          },
                                        );
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: 1.sw,
                                        padding: const EdgeInsets.all(16).r,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 5.r),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: _getItemColor(courseId),
                                          border: Border.all(
                                            color: context.isDarkMode
                                                ? AppColors.darkPrimaryColor
                                                : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 56.r,
                                              width: 56.r,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    data[index].thumbnail ?? '',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Gap(16.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data[index].title ?? '',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data[index].videoCount ?? 0} ${S.of(context).videos}",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Gap(8.w),
                                            data[index].isSpecial == true &&
                                                    data[index]
                                                            .certificateAvailable ==
                                                        true
                                                ? ref
                                                    .watch(
                                                        downloadCourseCertificateControllerProvider(
                                                            courseId:
                                                                data[index]
                                                                        .id ??
                                                                    0,
                                                            studentId:
                                                                studentId))
                                                    .when(
                                                      data: (url) {
                                                        final uri = Uri.parse(
                                                            url ?? '');
                                                        final fileName = uri
                                                            .pathSegments.last;
                                                        return FutureBuilder<
                                                            bool>(
                                                          future:
                                                              _checkIfFileExists(
                                                                  fileName,
                                                                  courseId),
                                                          builder: (context,
                                                              snapshot) {
                                                            final fileExists =
                                                                snapshot.data ??
                                                                    false;

                                                            print(
                                                                "File Exists: $fileExists ${snapshot.data}");

                                                            return InkWell(
                                                              onTap: () async {
                                                                if (fileExists) {
                                                                  _openDownloadedFile(
                                                                      courseId);
                                                                  return;
                                                                } else {
                                                                  final result =
                                                                      await showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false,
                                                                    barrierColor: context
                                                                            .isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.3)
                                                                        : Colors
                                                                            .black
                                                                            .withOpacity(0.5),
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                      backgroundColor: context.isDarkMode
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                      insetPadding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              20),
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                      content:
                                                                          const _DownloadCertificateDialog(),
                                                                    ),
                                                                  );

                                                                  if (result ==
                                                                      true) {
                                                                    await _downloadFile(
                                                                        url!,
                                                                        courseId);
                                                                  } else {
                                                                    print(
                                                                        "Don't Download Certificate");
                                                                  }
                                                                }
                                                              },
                                                              child: isDownloading
                                                                  ? Text(
                                                                      "Downloading...",
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .sp,
                                                                          color: AppColors
                                                                              .primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    )
                                                                  : fileExists
                                                                      ? Text(
                                                                          S.of(context).openFile,
                                                                          style: const TextStyle(
                                                                              color: AppColors.primaryColor,
                                                                              fontWeight: FontWeight.w600),
                                                                        )
                                                                      : Image.asset(
                                                                          height:
                                                                              24.r,
                                                                          width:
                                                                              24.r,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          "assets/pngs/receive-square.png",
                                                                        ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      loading: () =>
                                                          const CircularProgressIndicator(),
                                                      error:
                                                          (error, stackTrace) =>
                                                              IconButton(
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Error: $error')),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.download,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                        child: Text('Error: $error'),
                      ),
                    ),
              ],
            ),
          );
        });
  }

  _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).myCourses,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadCertificateDialog extends ConsumerWidget {
  const _DownloadCertificateDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(60.h),
              Text(
                S.of(context).areYouSureToDownload,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: context.isDarkMode
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(25.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffF6F6F6),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        // border color
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppColors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(54).r,
                        ),
                      ),
                      child: Text(
                        S.of(context).No,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                      ),
                      child: Text(
                        S.of(context).yes,
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10.h),
            ],
          ),
          Positioned(
            top: -35.h,
            child: Container(
              padding: const EdgeInsets.all(20).r,
              margin: const EdgeInsets.only(right: 14).r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // box shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset("assets/pngs/receive-square (1).png"),
            ),
          )
        ],
      ),
    );
  }
}

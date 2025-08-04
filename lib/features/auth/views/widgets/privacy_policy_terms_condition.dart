import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyTermsCondition extends ConsumerWidget {
  const PrivacyPolicyTermsCondition(
      {super.key, required this.title, this.isPrivacyPolicy = true});
  final String title;
  final bool isPrivacyPolicy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleLarge!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          Gap(20.sp),
          isPrivacyPolicy == true
              ? Expanded(
                  child: ref.watch(privacyTermsProvider).when(
                        data: (data) {
                          // var doc = parse(data?.data?.content ?? "");
                          // return SingleChildScrollView(
                          //   child: Text(
                          //     doc.body?.text ?? '',
                          //     style: context.textTheme.bodyLarge!.copyWith(),
                          //   ),
                          // );
                          return SingleChildScrollView(
                            child: HtmlWidget(
                              data?.data?.content ?? "",
                              textStyle:
                                  context.textTheme.bodyLarge!.copyWith(),
                              onTapUrl: (url) async {
                                final parsedUrl = Uri.parse(url);
                                if (await canLaunchUrl(parsedUrl)) {
                                  await launchUrl(parsedUrl);
                                  return true;
                                } else {
                                  throw 'Could not launch $parsedUrl';
                                }
                              },
                            ),
                          );
                        },
                        error: (e, s) {
                          return Text("Error: $e");
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                )
              : Expanded(
                  child: ref.watch(termsConditonProvider).when(
                        data: (data) {
                          return SingleChildScrollView(
                            child: HtmlWidget(
                              data?.data?.content ?? "",
                              textStyle:
                                  context.textTheme.bodyLarge!.copyWith(),
                              onTapUrl: (url) async {
                                final parsedUrl = Uri.parse(url);
                                if (await canLaunchUrl(parsedUrl)) {
                                  await launchUrl(parsedUrl);
                                  return true;
                                } else {
                                  throw 'Could not launch $parsedUrl';
                                }
                              },
                            ),
                          );
                        },
                        error: (e, s) {
                          return Text("Error: $e");
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                ),
          Gap(12.sp),
          CustomButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            title: "Ok",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

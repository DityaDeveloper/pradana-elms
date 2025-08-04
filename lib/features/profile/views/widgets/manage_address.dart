import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../../generated/l10n.dart';

class ManageAddressScreen extends ConsumerWidget {
  const ManageAddressScreen({super.key});
  String addressFormat(AddressModel address) {
    return [
      address.street,
      address.block,
      address.house,
      address.avenue,
      address.addressLine1,
      address.addressLine2,
      // address.stateName,
      // address.cityName,
      // address.countryName
    ].whereType<String>().join(", ");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          ref.watch(addressListProvider).when(
                data: (addressList) {
                  return addressList == null || addressList.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(S.of(context).pleaseAddYourAddress),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                addressList.length,
                                (index) {
                                  final address = addressList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 16)
                                        .r,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 16.r),
                                        Container(
                                          padding: const EdgeInsets.all(16).r,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12).r,
                                            color: context.cardColor,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          Assets.svgs.map),
                                                      Gap(8.w),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical: 4)
                                                                .r,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                      .circular(
                                                                          12)
                                                                  .r,
                                                        ),
                                                        child: Text(
                                                          (address.type ?? '')
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      context.push(
                                                          Routes
                                                              .addOrUpdateAddress,
                                                          extra: {
                                                            'addressModel':
                                                                address,
                                                            'isUpdate': true,
                                                          });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4)
                                                          .r,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            context.chipsColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                    .circular(
                                                                        12)
                                                                .r,
                                                      ),
                                                      child: Text(
                                                        S.of(context).edit,
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xff0B9AEC),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(16.h),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: context.chipsColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12)
                                                          .r,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      address.name ?? '',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Gap(8.h),
                                                    Text(
                                                      address.phone ?? '',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Gap(8.h),
                                                    Text(
                                                      addressFormat(address),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              )
        ],
      ),
      bottomNavigationBar: Container(
        height: 90.h,
        padding: const EdgeInsets.all(16).r,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: context.cardColor,
            foregroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(54.r),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
            minimumSize: Size(double.infinity, 60.h),
          ),
          onPressed: () {
            context.push(Routes.addOrUpdateAddress, extra: {
              'addressModel': null,
              'isUpdate': false,
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svgs.plus),
              Text(
                S.of(context).newAddress,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CommonAppbarWithBg _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).manageAddress,
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

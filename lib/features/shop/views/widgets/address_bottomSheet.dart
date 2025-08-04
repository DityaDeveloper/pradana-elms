import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/features/shop/logic/cart_controller.dart';
import 'package:lms/features/shop/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class AddressBottomSheet extends ConsumerWidget {
  const AddressBottomSheet({super.key});

  String addressFormat(AddressModel address) {
    return [
      address.street,
      address.block,
      address.house,
      address.avenue,
      address.addressLine1,
      address.stateName,
      address.cityName,
      address.countryName
    ].whereType<String>().join(", ");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddress = ref.watch(selectedAddressModelProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 6.h,
              width: 75.w,
              margin: const EdgeInsets.symmetric(vertical: 8).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: Colors.black,
              ),
            ),
          ),
          Gap(30.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).selectAddress,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ref.watch(addressListProvider).when(
                        data: (addressList) {
                          return addressList == null || addressList.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Text(
                                        S.of(context).pleaseAddYourAddress),
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
                                              horizontal: 0,
                                            ).r,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 16.r),
                                                Material(
                                                  color: Colors.transparent,
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  12)
                                                              .r,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .borderColor,
                                                      ),
                                                      color: context.cardColor,
                                                    ),
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                                  12)
                                                              .r,
                                                      onTap: () async {
                                                        ref
                                                            .read(
                                                                selectedAddressModelProvider
                                                                    .notifier)
                                                            .state = address;

                                                        ref
                                                            .read(
                                                                cartController)
                                                            .removeDeliveryCharge();

                                                        // set delivery charge
                                                        ref
                                                            .read(
                                                                cartController)
                                                            .setDeliveryCharge(
                                                              address.deliveryCharge ??
                                                                  0,
                                                            );

                                                        await Future.delayed(
                                                          const Duration(
                                                            milliseconds: 200,
                                                          ),
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(16)
                                                                .r,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                      .circular(
                                                                          12)
                                                                  .r,
                                                          border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .borderColor,
                                                          ),
                                                          // color:
                                                          //     context.cardColor,
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
                                                                    SvgPicture
                                                                        .asset(
                                                                      Assets
                                                                          .svgs
                                                                          .location,
                                                                    ),
                                                                    Gap(8.w),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 4)
                                                                          .r,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius:
                                                                            BorderRadius.circular(12).r,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        (address.type ??
                                                                                '')
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Gap(8.w),
                                                                    address.isDefault ==
                                                                            true
                                                                        ? Text(
                                                                            S.of(context).defaultAddress,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  height: 18.r,
                                                                  width: 18.r,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                              2)
                                                                          .r,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: selectedAddress ==
                                                                              address
                                                                          ? const Color(
                                                                              0xff0B9AEC)
                                                                          : AppColors
                                                                              .borderColor,
                                                                    ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        14.r,
                                                                    width: 14.r,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: selectedAddress ==
                                                                              address
                                                                          ? const Color(
                                                                              0xff0B9AEC)
                                                                          : AppColors
                                                                              .borderColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Gap(16.h),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              width: double
                                                                  .infinity,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Wrap(
                                                                    children: [
                                                                      Text(
                                                                        "${address.name ?? ''} - ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        address.phone ??
                                                                            '',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Gap(8.h),
                                                                  Text(
                                                                    addressFormat(
                                                                        address),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
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
            ),
          ),
          Gap(20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(54.r),
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                minimumSize: Size(double.infinity, 60.h),
              ),
              onPressed: () {
                context.push(Routes.addOrUpdateAddress, extra: {
                  'addressModel': null,
                  'isUpdate': false,
                });
              },
              child: Text(
                S.of(context).addNew,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}

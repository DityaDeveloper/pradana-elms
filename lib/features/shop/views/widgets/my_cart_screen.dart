import 'package:dotted_border/dotted_border.dart';
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
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/shop/logic/cart_controller.dart';
import 'package:lms/features/shop/logic/providers.dart';
import 'package:lms/features/shop/logic/shop_controller.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/features/shop/views/widgets/address_bottomSheet.dart';
import 'package:lms/features/shop/views/widgets/cart_list_section.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class MyCartScreen extends ConsumerWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, child) {
          final isAuth =
              box.get(AppConstants.authToken, defaultValue: null) == null
                  ? false
                  : true;
          return Scaffold(
            backgroundColor:
                context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
            body: Column(
              children: [
                _headerSection(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(16.h),
                        const CartListSection(),
                        Gap(16.h),
                        isAuth ? const _AddressSection() : const SizedBox(),
                        Gap(16.h),
                        const _OrderSummary(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: 105.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ).r,
              decoration: BoxDecoration(
                color: context.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: isAuth
                  ? Consumer(builder: (context, ref, child) {
                      final storeLoading = ref.watch(orderStoreProvider);
                      return storeLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.w, vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(54.r),
                                ),
                                minimumSize: Size(double.infinity, 60.h),
                              ),
                              onPressed: () {
                                if (ref.watch(cartController).totalAmount > 0) {
                                  if (ref.watch(selectedAddressModelProvider) !=
                                      null) {
                                    ref
                                        .read(orderStoreProvider.notifier)
                                        .storeOrder(
                                          Hive.box<HiveCartModel>(
                                                  AppConstants.cartBox)
                                              .values
                                              .toList(),
                                        )
                                        .then((value) {
                                      if (value) {
                                        GlobalFunction.showCustomSnackbar(
                                            message: S
                                                .of(context)
                                                .orderPlaceSuccessFully,
                                            isSuccess: true);
                                        context.pop();
                                      } else {
                                        GlobalFunction.showCustomSnackbar(
                                            message: S
                                                .of(context)
                                                .somethingWentWrong,
                                            isSuccess: false);
                                      }
                                    });
                                  } else {
                                    GlobalFunction.showCustomSnackbar(
                                        message: S.of(context).pleaseAddAddress,
                                        isSuccess: false);
                                  }
                                } else {
                                  GlobalFunction.showCustomSnackbar(
                                      message: S.of(context).pleaseAddItemCart,
                                      isSuccess: false);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).pay,
                                    style:
                                        context.textTheme.bodySmall!.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  Gap(5.w),
                                  CurrencyWidget(
                                    color: AppColors.whiteColor,
                                    amount: ref
                                        .watch(cartController)
                                        .totalAmount
                                        .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            );
                    })
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54.r),
                        ),
                        minimumSize: Size(double.infinity, 60.h),
                      ),
                      onPressed: () {
                        context.go(Routes.login);
                      },
                      child: Text(
                        S.of(context).login,
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
            ),
          );
        });
  }

  CommonAppbarWithBg _headerSection() {
    return CommonAppbarWithBg(
      child: ValueListenableBuilder(
          valueListenable:
              Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
          builder: (context, box, _) {
            return Row(
              children: [
                Text(
                  box.values.isEmpty
                      ? S.of(context).myCart
                      : "${S.of(context).myCart} (${box.values.length})",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _OrderSummary extends ConsumerWidget {
  const _OrderSummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(12),
          right: Radius.circular(12),
        ).r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).orderSummary,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12).r,
            child: Column(
              children: [
                _textInfo(
                  title: S.of(context).subTotal,
                  value: ref
                      .watch(cartController)
                      .subTotalAmount
                      .toStringAsFixed(2),
                  context: context,
                ),
                Gap(12.h),
                _textInfo(
                  title: S.of(context).discount,
                  value: ref.watch(cartController).discount.toStringAsFixed(2),
                  isDiscount: true,
                  context: context,
                ),
                Gap(12.h),
                _textInfo(
                  title: S.of(context).deliveryCharge,
                  context: context,
                  value: ref
                      .watch(cartController)
                      .deliveryCharge
                      .toStringAsFixed(2),
                ),
                Gap(10.sp),
                const DottedLine(),
                Gap(10.sp),
                _textInfo(
                  title: S.of(context).payableAmount,
                  isTotalTextBold: true,
                  value:
                      ref.watch(cartController).totalAmount.toStringAsFixed(2),
                  isSummery: true,
                  context: context,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _textInfo({
    required String title,
    required String value,
    bool isDiscount = false,
    bool isSummery = false,
    bool isTotalTextBold = false,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isTotalTextBold ? FontWeight.w600 : FontWeight.w500),
        ),
        const Spacer(),
        CurrencyWidget(
          amount: value.toString(),
          color: context.textTheme.bodyLarge!.color!,
          fontSize: isSummery ? 18.sp : 16.sp,
          fontWeight: isSummery ? FontWeight.w600 : FontWeight.w500,
          isDiscount: isDiscount,
        )
      ],
    );
  }
}

class _AddressSection extends ConsumerWidget {
  const _AddressSection();

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
    final address = ref.watch(selectedAddressModelProvider);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ).r,
      // padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(12),
          right: Radius.circular(12),
        ).r,
      ),
      child: ref.watch(selectedAddressModelProvider) == null
          ? Row(
              children: [
                SvgPicture.asset(Assets.svgs.location),
                Gap(12.w),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        // isDismissible: false,
                        // enableDrag: false,
                        backgroundColor: context.isDarkMode
                            ? AppColors.darkScaffoldColor
                            : Colors.white,
                        builder: (context) => const AddressBottomSheet(),
                      );
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(48).r,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16)
                          .r,
                      color: const Color(0xff0B9AEC),
                      dashPattern: const [8, 4],
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).addYourLocation,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff0B9AEC),
                              ),
                            ),
                            Gap(8.w),
                            const Icon(
                              Icons.add,
                              color: Color(0xff0B9AEC),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  border: Border.all(
                    width: 1,
                    color: AppColors.borderColor,
                  ),
                  color: context.cardColor,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12).r,
                  onTap: () async {},
                  child: Container(
                    padding: const EdgeInsets.all(16).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).r,
                      border: Border.all(
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                      // color:
                      //     context.cardColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svgs.location,
                                ),
                                Gap(8.w),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4)
                                      .r,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12).r,
                                  ),
                                  child: Text(
                                    (address?.type ?? '').toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      const AddressBottomSheet(),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).change,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(8.w),
                                  SvgPicture.asset(Assets.svgs.refresh),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(16.h),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.chipsColor,
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address?.name ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                address?.phone ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(8.h),
                              Text(
                                address == null ? "" : addressFormat(address),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
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
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xffD1D1D1)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 5, startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(),
      size: const Size(double.infinity, 0.001),
    );
  }
}

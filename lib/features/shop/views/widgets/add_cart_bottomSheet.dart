import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/shop/data/cart_repo.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/features/shop/models/product_model.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class AddCartBottomSheet extends ConsumerWidget {
  const AddCartBottomSheet({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
        builder: (context, box, _) {
          int productQuantity = 0;
          late int index;
          double price = 0.0;
          final cartItems = box.values.toList();
          for (int i = 0; i < cartItems.length; i++) {
            final cartProduct = cartItems[i];
            if (cartProduct.id == productModel.id) {
              productQuantity = cartProduct.productsQTY;
              price = cartProduct.price;
              index = i;
              break;
            }
          }
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).addtoCart,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(24.h),
                      Row(
                        children: [
                          Container(
                            height: 56.r,
                            width: 56.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12).r,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: productModel.image ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productModel.name ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(8.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          productQuantity.toString(),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Gap(6.w),
                                        Text(
                                          "X",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Gap(6.w),
                                        CurrencyWidget(
                                          amount: productModel.price.toString(),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerRight,
                                        child: CurrencyWidget(
                                          amount: (productQuantity * price)
                                              .toStringAsFixed(2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color(0xffE7E7E7),
                      ),
                      Gap(24.h),
                      Text(
                        S.of(context).selectQty,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(12.h),
                      Container(
                        padding: const EdgeInsets.all(4).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: context.isDarkMode
                              ? AppColors.darkScaffoldColor
                              : const Color(0xffF6F6F6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Minus Button
                            InkWell(
                              onTap: () {
                                if (productQuantity == 1) {
                                  ref.read(cartRepo).decrementProductQuantity(
                                        productId: productModel.id ?? 0,
                                        cartBox: box,
                                        index: index,
                                      );
                                  Navigator.pop(context);
                                } else {
                                  ref.read(cartRepo).decrementProductQuantity(
                                        productId: productModel.id ?? 0,
                                        cartBox: box,
                                        index: index,
                                      );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: context.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                child: SvgPicture.asset(Assets.svgs.minus),
                              ),
                            ),
                            Text(
                              productQuantity.toString(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // Plus Button
                            InkWell(
                              onTap: () {
                                ref.read(cartRepo).incrementProductQuantity(
                                      productId: productModel.id ?? 0,
                                      box: box,
                                      index: index,
                                    );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: context.isDarkMode
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                child: SvgPicture.asset(Assets.svgs.plus),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(24.h),
                      CustomButton(
                        title: S.of(context).confirm,
                        onPressed: () {
                          context.push(Routes.myCart);
                          context.pop();
                        },
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

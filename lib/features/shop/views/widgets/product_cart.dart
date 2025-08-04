import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/features/shop/models/product_model.dart';
import 'package:lms/features/shop/views/widgets/add_cart_bottomSheet.dart';
import 'package:lms/gen/assets.gen.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
        builder: (context, box, _) {
          bool inCart = false;
          late int productQuantity;
          late int index;
          double price = 0.0;
          final cartItems = box.values.toList();
          for (int i = 0; i < cartItems.length; i++) {
            final cartProduct = cartItems[i];
            if (cartProduct.id == productModel.id) {
              inCart = true;
              productQuantity = cartProduct.productsQTY;
              price = cartProduct.price;
              index = i;
              break;
            }
          }
          return Container(
            padding: const EdgeInsets.all(10).r,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: context.isDarkMode
                  ? AppColors.darkScaffoldColor
                  : Colors.white,
              border: Border.all(
                color: !context.isDarkMode
                    ? AppColors.darkScaffoldColor.withOpacity(0.1)
                    : Colors.white,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 115.h,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.grey,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(8.h),
                Text(
                  productModel.name ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    productModel.discountAmount != 0.0
                        ? Column(
                            children: [
                              CurrencyWidget(
                                amount: productModel.price.toString(),
                                isDelete: true,
                                fontSize: 14.sp,
                              ),
                              Gap(4.h),
                              CurrencyWidget(
                                amount: productModel.payableAmount.toString(),
                                fontSize: 16.sp,
                              ),
                            ],
                          )
                        : CurrencyWidget(
                            amount: productModel.payableAmount.toString(),
                            fontSize: 16.sp,
                          ),
                    const Spacer(),
                    !inCart
                        ? InkWell(
                            onTap: () async {
                              final cartBox =
                                  Hive.box<HiveCartModel>(AppConstants.cartBox);

                              HiveCartModel cartModel = HiveCartModel(
                                id: productModel.id!,
                                name: productModel.name!,
                                thumbnail: productModel.image!,
                                price: productModel.price ?? 0,
                                productsQTY: 1,
                                discountAmount:
                                    productModel.discountAmount ?? 0,
                                payableAmount: productModel.payableAmount ?? 0,
                              );

                              await cartBox.add(cartModel);

                              showModalBottomSheet(
                                context: context,
                                // isDismissible: false,
                                // enableDrag: false,
                                backgroundColor: context.isDarkMode
                                    ? AppColors.darkScaffoldColor
                                    : Colors.white,
                                builder: (context) => AddCartBottomSheet(
                                  productModel: productModel,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4).r,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SvgPicture.asset(
                                Assets.svgs.add,
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    // isDismissible: false,
                                    // enableDrag: false,
                                    backgroundColor: context.isDarkMode
                                        ? AppColors.darkScaffoldColor
                                        : Colors.white,
                                    builder: (context) => AddCartBottomSheet(
                                      productModel: productModel,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4).r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffB9E2FE),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.svgs.tick,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 1,
                                child: Text(
                                  productQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                )
              ],
            ),
          );
        });
  }
}

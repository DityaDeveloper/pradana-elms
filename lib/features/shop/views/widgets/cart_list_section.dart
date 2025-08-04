import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/shop/logic/cart_controller.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/features/shop/models/product_model.dart';
import 'package:lms/gen/assets.gen.dart';

class CartListSection extends ConsumerWidget {
  const CartListSection({
    super.key,
  });
  List<ProductModel> getProducts(List<HiveCartModel> cartItems) {
    List<ProductModel> products = [];
    for (var item in cartItems) {
      ProductModel product = ProductModel(
        id: item.id,
        image: item.thumbnail,
        name: item.name,
        price: item.price,
        discountAmount: item.discountAmount,
        payableAmount: item.payableAmount,
      );
      products.add(product);
    }
    return products;
  }

  List<int> getQuantiry(List<HiveCartModel> cartItems) {
    List<int> quantity = [];
    for (var item in cartItems) {
      quantity.add(item.productsQTY);
    }
    return quantity;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
      builder: (context, box, _) {
        final productsList = getProducts(box.values.toList());
        final quantityList = getQuantiry(box.values.toList());
        ref.read(cartController).calculateSubTotal(box.values.toList());
        return productsList.isEmpty
            ? const Center(
                child: Text("No Item Found"),
              )
            : Column(
                children: List.generate(
                  productsList.length,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ).r,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.darkScaffoldColor
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: index == 0
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                          topRight: index == 0
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                          bottomLeft: index == productsList.length - 1
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                          bottomRight: index == productsList.length - 1
                              ? const Radius.circular(12)
                              : const Radius.circular(0),
                        ).r,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12).r,
                            child: Row(
                              children: [
                                Container(
                                  height: 72.h,
                                  width: 72.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12).r,
                                    color: Colors.grey,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: productsList[index].image ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Gap(16.w),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              productsList[index].name ?? '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Gap(8.w),
                                          InkWell(
                                            onTap: () {
                                              box.deleteAt(index);
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svgs.trash,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(16.h),
                                      Row(
                                        children: [
                                          CurrencyWidget(
                                              amount:
                                                  ((productsList[index].price ??
                                                              0) *
                                                          quantityList[index])
                                                      .toString(),
                                              fontSize: 14.sp),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 8)
                                                .r,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8).r,
                                              color: context.isDarkMode
                                                  ? AppColors.darkScaffoldColor
                                                  : const Color(0xffF6F6F6),
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${quantityList[index].toString()} psc",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Gap(4.w),
                                                SizedBox(
                                                  height: 12.r,
                                                  width: 12.r,
                                                  child: SvgPicture.asset(
                                                    Assets.svgs.arrowDown,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          index == productsList.length - 1
                              ? const SizedBox()
                              : const Divider(
                                  color: Color(0xffE7E7E7),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

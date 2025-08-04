import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/shop/logic/providers.dart';
import 'package:lms/features/shop/logic/shop_controller.dart';
import 'package:lms/features/shop/views/widgets/product_cart.dart';
import 'package:lms/features/shop/views/widgets/shop_appbar.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
      body: Column(
        children: [
          const ShopAppbar(),
          Expanded(
            child: ref
                .watch(productListProvider(
                    categoryId: ref.watch(selectedCategoryIdProvider) ?? 0))
                .when(
                  data: (list) {
                    return list == null || list.isEmpty
                        ? const Center(
                            child: Text("No Product Found"),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(16.r),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.r,
                              crossAxisSpacing: 10.r,
                              mainAxisExtent: 245.r,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ProductCart(
                                productModel: list[index],
                              );
                            },
                          );
                  },
                  error: (error, stack) => Text("Error: $error"),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
          ),
        ],
      ),
    );
  }
}

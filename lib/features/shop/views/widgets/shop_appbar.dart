import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/shop_appBar_with_BG.dart';
import 'package:lms/features/shop/logic/providers.dart';
import 'package:lms/features/shop/logic/shop_controller.dart';

import '../../../../generated/l10n.dart';

class ShopAppbar extends ConsumerWidget {
  const ShopAppbar({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
    return ShopAppbarWithBg(
      title: S.of(context).shop,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ref.watch(categoryListProvider).when(
              data: (list) {
                return list == null
                    ? const Center(
                        child: Text("No Data Found"),
                      )
                    : Row(
                        children: List.generate(
                          list.length,
                          (index) => Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(selectedCategoryIdProvider.notifier)
                                      .state = list[index].id;
                                },
                                child: Container(
                                  // margin: const EdgeInsets.symmetric(horizontal: 5).r,
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10)
                                      .r,
                                  decoration: BoxDecoration(
                                    color: list[index].id == selectedCategoryId
                                        ? context.isDarkMode
                                            ? AppColors.darkScaffoldColor
                                            : Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(32).r,
                                  ),
                                  child: Text(
                                    list[index].name ?? '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          list[index].id == selectedCategoryId
                                              ? AppColors.primaryLightColor
                                              : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
              error: (error, stack) {
                print(error);
                print(stack);
                return Text("Error: $error");
              },
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }
}

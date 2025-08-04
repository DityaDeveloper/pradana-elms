import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/order_history_with_appbar.dart';
import 'package:lms/features/profile/logic/providers.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/shop/logic/shop_controller.dart';
import 'package:lms/generated/l10n.dart';

class OrderHistory extends ConsumerWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
      body: Column(
        children: [
          _OrderAppBar(),
          Expanded(
            child: ref.watch(orderHistoryListProvider).when(
                  data: (list) {
                    return list.isEmpty
                        ?  Center(
                            child: Text(S.of(context).orderNotFound),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(16.r),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.push(
                                    Routes.orderDetails,
                                    extra: list[index],
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.r),
                                  margin: EdgeInsets.only(bottom: 16.r),
                                  decoration: BoxDecoration(
                                    color: context.isDarkMode
                                        ? AppColors.darkScaffoldColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16).r,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: const Offset(1, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${S.of(context).orderId}: ${list[index].code}",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.r,
                                              vertical: 4.r,
                                            ),
                                            decoration: BoxDecoration(
                                              color: GlobalFunction.orderStatus(
                                                      list[index].status ?? '')
                                                  .bgColor,
                                              borderRadius:
                                                  BorderRadius.circular(16).r,
                                            ),
                                            child: Text(
                                              GlobalFunction.orderStatus(
                                                      list[index].status ?? '')
                                                  .text,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.r, vertical: 4.r),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF6F6F6),
                                          borderRadius:
                                              BorderRadius.circular(8).r,
                                        ),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).totalItems,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(4.h),
                                                    Text(
                                                      list[index]
                                                          .totalItems
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const VerticalDivider(
                                                color: Color(0xffE7E7E7),
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).amount,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(4.h),
                                                    CurrencyWidget(
                                                      amount: list[index]
                                                          .grandTotal
                                                          .toString(),
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const VerticalDivider(
                                                color: Color(0xffE7E7E7),
                                                thickness: 1,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).date,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff6D6D6D),
                                                      ),
                                                    ),
                                                    Gap(4.h),
                                                    Text(
                                                      list[index]
                                                              .createdAt
                                                              ?.split(' ')[0] ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/pngs/location.png'),
                                          Gap(6.w),
                                          Expanded(
                                            child: Text(
                                              list[index].fullAddress ?? '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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

class _OrderAppBar extends ConsumerWidget {
  List<String> list = ['All', 'Pending', 'Delivered', 'Cancelled'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOrderHistory = ref.watch(selectedOrderHistoryProvider);
    return OrderAppbarWithBg(
      title: S.of(context).orderHistory,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            list.length,
            (index) => Row(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(selectedOrderHistoryProvider.notifier).state =
                        list[index];
                    if (list[index] == 'All') {
                      ref.read(orderHistoryListProvider.notifier).allOrders();
                    } else if (list[index] == 'Pending') {
                      ref
                          .read(orderHistoryListProvider.notifier)
                          .pendingOrders();
                    } else if (list[index] == 'Delivered') {
                      ref
                          .read(orderHistoryListProvider.notifier)
                          .deliveredOrders();
                    } else if (list[index] == 'Cancelled') {
                      ref
                          .read(orderHistoryListProvider.notifier)
                          .cancelledOrders();
                    }
                  },
                  child: Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 5).r,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                            .r,
                    decoration: BoxDecoration(
                      color: list[index] == selectedOrderHistory
                          ? context.isDarkMode
                              ? AppColors.darkScaffoldColor
                              : Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(32).r,
                    ),
                    child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: list[index] == selectedOrderHistory
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
                    color: AppColors.primaryLightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

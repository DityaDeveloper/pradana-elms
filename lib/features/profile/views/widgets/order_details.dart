import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/profile/models/order_model/order_model.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/generated/l10n.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
      body: Column(
        children: [
          _headerSection(context),
          Container(
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.all(16.r),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${S.of(context).orderId}: ${orderModel.code}",
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
                        color:
                            GlobalFunction.orderStatus(orderModel.status ?? '')
                                .bgColor,
                        borderRadius: BorderRadius.circular(16).r,
                      ),
                      child: Text(
                        GlobalFunction.orderStatus(orderModel.status ?? '')
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
                  padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.r),
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // two text in a row with separeted by gap
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            orderModel.name ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "${S.of(context).date}: ${orderModel.createdAt!.split(' ').first}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),
                      // phone number
                      Text(
                        orderModel.phone ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gap(10.h),
                      Text(
                        orderModel.fullAddress ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.r),
            padding: EdgeInsets.all(16.r),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).orderSummary,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(10.h),
                orderModel.orderItems == null
                    ? Center(
                        child: Text(S.of(context).noItemFound),
                      )
                    : Column(
                        children: List.generate(orderModel.orderItems!.length,
                            (index) {
                          final item = orderModel.orderItems![index];
                          return Row(
                            children: [
                              Container(
                                height: 48.r,
                                width: 48.r,
                                color: Colors.grey,
                                child: CachedNetworkImage(
                                  imageUrl: item.media ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Gap(16.r),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Gap(4.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CurrencyWidget(
                                          amount: item.price.toString(),
                                          fontSize: 14.sp,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.r,
                                            vertical: 4.r,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF6F6F6),
                                            borderRadius:
                                                BorderRadius.circular(16).r,
                                          ),
                                          child: Text(
                                            "${item.quantity} pcs",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                Gap(20.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).subTotal),
                    CurrencyWidget(
                      amount: orderModel.total.toString(),
                      fontSize: 14.sp,
                    )
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).discount),
                    CurrencyWidget(
                      amount: orderModel.discount.toString(),
                      fontSize: 14.sp,
                      isDiscount: true,
                    )
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).deliveryCharge),
                    CurrencyWidget(
                      amount: orderModel.deliveryCharge.toString(),
                      fontSize: 14.sp,
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).payableAmount),
                    CurrencyWidget(
                      amount: orderModel.grandTotal.toString(),
                      fontSize: 14.sp,
                    )
                  ],
                ),
                Gap(10.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).orderDetails,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/home/logic/system_setting_controller.dart';

class CurrencyWidget extends ConsumerWidget {
  CurrencyWidget({
    super.key,
    this.color,
    required this.amount,
    this.isDelete = false,
    this.fontWeight,
    this.fontSize,
    this.isDiscount,
  });

  String amount;
  bool isDelete;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? isDiscount;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
                .watch(systemSettingProvider.notifier)
                .currencySymbol
                .toLowerCase() ==
            'kd'
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3).r,
                child: Text(
                  isDiscount == true ? "-KD" : "KD",
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 10.sp,
                    color: isDiscount == true
                        ? Colors.red
                        : isDelete
                            ? const Color(0xff888888)
                            : color ?? const Color(0xff015B99),
                    fontWeight: fontWeight ?? FontWeight.w600,
                  ),
                ),
              ),
              Text(
                amount,
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: fontSize ?? 20.sp,
                  color: isDiscount == true
                      ? Colors.red
                      : isDelete
                          ? const Color(0xff888888)
                          : color ?? const Color(0xff015B99),
                  fontWeight: fontWeight ?? FontWeight.w600,
                  decoration: isDelete ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   isDiscount == true
              //       ? "-${ref.watch(systemSettingProvider.notifier).symbol}"
              //       : ref.watch(systemSettingProvider.notifier).symbol,
              //   style: context.textTheme.bodySmall!.copyWith(
              //     fontSize: 10.sp,
              //     color: isDiscount == true
              //         ? Colors.red
              //         : isDelete
              //             ? const Color(0xff888888)
              //             : color ?? const Color(0xff015B99),
              //     fontWeight: fontWeight ?? FontWeight.w600,
              //   ),
              // ),
              Text(
                isDiscount == true
                    ? "-${ref.watch(systemSettingProvider.notifier).currencyValue(
                          double.parse(amount),
                        )}"
                    : ref.watch(systemSettingProvider.notifier).currencyValue(
                          double.parse(amount),
                        ),
                style: context.textTheme.bodySmall!.copyWith(
                  fontSize: fontSize ?? 20.sp,
                  color: isDiscount == true
                      ? Colors.red
                      : isDelete
                          ? const Color(0xff888888)
                          : color ?? AppColors.primaryColor,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  decoration: isDelete ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';
import 'package:pinput/pinput.dart';

class PinPutField extends ConsumerStatefulWidget {
  const PinPutField({
    super.key,
    required this.otpCode,
    required this.phoneNumber,
    this.isParentLogin = false,
  });

  final String otpCode;
  final String phoneNumber;
  final bool? isParentLogin;

  @override
  ConsumerState<PinPutField> createState() => _PinPutFieldState();
}

class _PinPutFieldState extends ConsumerState<PinPutField> {
  int _secondsRemaining = 59;
  Timer? _timer;
  late String _currentOtpCode;

  late final TextEditingController _pinPutController;

  @override
  void initState() {
    super.initState();
    _pinPutController = TextEditingController(text: widget.otpCode);
    _currentOtpCode = widget.otpCode;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode() async {
    final sendOTPNotifier = ref.read(sendOTPProvider.notifier);

    String? otpCode = await sendOTPNotifier.sendOTP(phone: widget.phoneNumber);

    setState(() {
      _pinPutController.text = otpCode!;
      _currentOtpCode = otpCode;
    });

    GlobalFunction.showCustomSnackbar(
      message: 'OTP has been resent.',
      isSuccess: true,
    );

    // Reset the timer
    setState(() {
      _secondsRemaining = 59;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinPutController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    // Watch the SendOTP provider's state
    final isLoading = ref.watch(sendOTPProvider);
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.containerColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Assets.pngs.otp.image(height: 100.h),
              Gap(24.h),
              Text(
                S.of(context).enterCode,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
              Gap(16.h),
              Pinput(
                controller: _pinPutController,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer,
                    border: Border.all(
                      color: context.isDarkMode
                          ? AppColors.borderColor.withOpacity(.1)
                          : const Color.fromRGBO(234, 239, 243, 1),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (s) {
                  return s == _currentOtpCode ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                length: 6,
                onCompleted: (pin) => print(pin),
                preFilledWidget: const Text("-"),
              ),
              Gap(24.h),
              _secondsRemaining > 0
                  ? Text(
                      "${S.of(context).reSendCode}: ${_formatTime(_secondsRemaining)}",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    )
                  : isLoading
                      ? const CircularProgressIndicator()
                      : TextButton(
                          onPressed: isLoading ? null : _resendCode,
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
              Gap(50.h),
              Consumer(
                builder: (context, ref, child) {
                  final verifyOTPLoading = ref.watch(verifyOTPProvider);
                  return verifyOTPLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          title: S.of(context).verifyOTP,
                          onPressed: () {
                            ref
                                .read(verifyOTPProvider.notifier)
                                .verifyOTP(
                                  phone: widget.phoneNumber,
                                  otp: _pinPutController.text,
                                )
                                .then((value) {
                              if (value != null) {
                                if (widget.isParentLogin == true) {
                                  Hive.box(AppConstants.authBox)
                                      .put(AppConstants.authToken, value);
                                  Hive.box(AppConstants.authBox).put(
                                      AppConstants.hasParentLoggedIn, true);
                                  context.go(Routes.childList);
                                } else {
                                  // hive box for hasOTPVefified saved
                                  Hive.box(AppConstants.appSettingsBox)
                                      .put(AppConstants.hasOTPVerified, true);
                                  // navigate to academic info screen
                                  context.push(Routes.academicInfo);
                                }
                              }
                            });
                          },
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

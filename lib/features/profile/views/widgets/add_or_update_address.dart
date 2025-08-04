import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/academic_info/models/academic_info_model/country.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/features/profile/logic/providers.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/features/profile/models/area_model.dart';
import 'package:lms/features/profile/models/city_model.dart';
import 'package:lms/features/profile/views/widgets/delete_address_dialog.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class AddOrUpdateAddressScreen extends ConsumerStatefulWidget {
  const AddOrUpdateAddressScreen({super.key, this.isUpdate, this.addressModel});
  final bool? isUpdate;
  final AddressModel? addressModel;

  @override
  ConsumerState<AddOrUpdateAddressScreen> createState() =>
      _AddOrUpdateAddressScreenState();
}

class _AddOrUpdateAddressScreenState
    extends ConsumerState<AddOrUpdateAddressScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  // State variables to track selections
  bool isCountryEnabled = false;
  bool isCityEnabled = false;
  bool isAreaEnabled = false;

  List<Country> countryList = [];
  List<CityModel> cityList = [];
  List<AreaModel> areaList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Fetch country list
      ref.read(countryListProvider.notifier).getCountryList().then((val) {
        // if (!mounted) return;
        setState(() {
          countryList.clear();
          countryList = val ?? [];
          isCountryEnabled = true;
        });
      });

      // If updating, fetch city and area lists
      if (widget.isUpdate == true && widget.addressModel != null) {
        // Fetch city list based on the selected country
        ref
            .read(cityListProvider.notifier)
            .getCityList(countryId: widget.addressModel!.countryId!)
            .then((val) {
          if (!mounted) return;
          setState(() {
            cityList.clear();
            cityList = val ?? [];
            isCityEnabled = true;
          });
        });

        // Fetch area list based on the selected city
        ref
            .read(areaListProvider.notifier)
            .getAreaList(cityId: widget.addressModel!.stateId!)
            .then((val) {
          if (!mounted) return;
          setState(() {
            areaList.clear();
            areaList = val ?? [];
            isAreaEnabled = true;
          });
        });
      }
    });
  }

  Country? getCountryById(int id) {
    return countryList.firstWhere((element) => element.id == id, orElse: () {
      return Country()
        ..id = null
        ..name = null;
    });
  }

  CityModel? getCityById(int id) {
    return cityList.firstWhere((element) => element.id == id, orElse: () {
      return CityModel()
        ..id = null
        ..name = null;
    });
  }

  AreaModel? getAreaById(int id) {
    return areaList.firstWhere((element) => element.id == id, orElse: () {
      return AreaModel()
        ..id = null
        ..name = null;
    });
  }

  @override
  void dispose() {
    // _formKey.currentState?.reset();
    // _formKey.currentState?.dispose();
    print('Disposing AddOrUpdateAddressScreen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryLoading = ref.watch(countryListProvider);
    final cityLoading = ref.watch(cityListProvider);
    final areaLoading = ref.watch(areaListProvider);
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, _) {
          return Scaffold(
            backgroundColor: context.isDarkMode
                ? AppColors.darkScaffoldColor
                : const Color(0xffF6F6F6),
            body: Column(
              children: [
                _headerSection(),
                Expanded(
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey,
                      initialValue: widget.addressModel != null
                          ? {
                              "name": widget.addressModel!.name,
                              "phone": widget.addressModel!.phone,
                              // "country_id":
                              //     getCountryById(widget.addressModel?.countryId ?? 0),
                              // "city_id":
                              //     getCityById(widget.addressModel?.cityId ?? 0),
                              // "state_id":
                              //     getAreaById(widget.addressModel?.stateId ?? 0),
                              "block": widget.addressModel!.block,
                              "street": widget.addressModel!.street,
                              "avenue": widget.addressModel!.avenue,
                              "house": widget.addressModel!.house,
                              "address_line1":
                                  widget.addressModel!.addressLine1,
                              "is_default":
                                  widget.addressModel!.isDefault == true
                                      ? true
                                      : false,
                            }
                          : {
                              "name": box.get(AppConstants.userData,
                                      defaultValue: null)?['name'] ??
                                  '',
                              "phone": box.get(AppConstants.userData,
                                      defaultValue: null)?['phone'] ??
                                  '',
                              // "country_id": null,
                              // "city_id": null,
                              // "state_id": null,
                              "block": "",
                              "street": "",
                              "avenue": "",
                              "house": "",
                              "address_line1": "",
                              "is_default": false,
                            },
                      child: Column(
                        children: [
                          Gap(8.h),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16).r,
                            color: context.cardColor,
                            child: Column(
                              children: [
                                Gap(5.h),
                                FormBuilderTextField(
                                  name: "name",
                                  decoration: InputDecoration(
                                    label: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(S.of(context).fullName),
                                        Gap(6.w),
                                        SvgPicture.asset(
                                          Assets.svgs.star,
                                          height: 8.r,
                                        )
                                      ],
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                Gap(24.h),
                                FormBuilderTextField(
                                  name: "phone",
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    label: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(S.of(context).phone),
                                        Gap(6.w),
                                        SvgPicture.asset(
                                          Assets.svgs.star,
                                          height: 8.r,
                                        )
                                      ],
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ]),
                                ),
                                //   Gap(24.h),
                                //   // Country dropdown
                                //  // countryLoading
                                //       // ? Skeletonizer(
                                //       //     enabled: true,
                                //       //     child: Container(
                                //       //       height: 50.h,
                                //       //       decoration: BoxDecoration(
                                //       //         color: Colors.grey[200],
                                //       //         borderRadius:
                                //       //             BorderRadius.circular(8).r,
                                //       //       ),
                                //       //     ),
                                //       //   )
                                //       : FormBuilderDropdown<Country>(
                                //           name: "country_id",
                                //           enabled: isCountryEnabled,
                                //           initialValue: countryList.contains(
                                //                   getCountryById(widget
                                //                           .addressModel
                                //                           ?.countryId ??
                                //                       0))
                                //               ? getCountryById(widget
                                //                       .addressModel?.countryId ??
                                //                   0)
                                //               : null,
                                //           items: countryList.map((country) {
                                //             return DropdownMenuItem(
                                //               value: country,
                                //               child: Text(
                                //                 country.name ?? '',
                                //                 style: context
                                //                     .textTheme.bodyLarge!
                                //                     .copyWith(
                                //                   fontSize: 14.sp,
                                //                 ),
                                //               ),
                                //             );
                                //           }).toList(),
                                //           icon: SvgPicture.asset(
                                //             Assets.svgs.arrowDown,
                                //             height: 20.r,
                                //             color: isCountryEnabled
                                //                 ? null
                                //                 : Colors
                                //                     .grey, // Adjust icon color
                                //           ),
                                //           decoration: InputDecoration(
                                //             fillColor: isCountryEnabled
                                //                 ? null
                                //                 : Colors.grey[
                                //                     200], // Change background color
                                //             filled: !isCountryEnabled,
                                //             label: Row(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Text(S.of(context).selectCountry),
                                //                 Gap(6.w),
                                //                 SvgPicture.asset(
                                //                   Assets.svgs.star,
                                //                   height: 8.r,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           validator:
                                //               FormBuilderValidators.required(),
                                //           onChanged: (value) async {
                                //             if (value == null) return;
                                //             _formKey
                                //                 .currentState!.fields['city_id']
                                //                 ?.reset();
                                //             _formKey
                                //                 .currentState!.fields['state_id']
                                //                 ?.reset();

                                //             cityList = await ref
                                //                     .read(
                                //                         cityListProvider.notifier)
                                //                     .getCityList(
                                //                         countryId: value.id!) ??
                                //                 [];
                                //             if (!mounted) return;
                                //             setState(() {
                                //               isCityEnabled = true;
                                //             });
                                //           },
                                //         ),
                                //   Gap(24.h),
                                //   // City dropdown
                                //   cityLoading
                                //       ? Skeletonizer(
                                //           enabled: true,
                                //           child: Container(
                                //             height: 50.h,
                                //             decoration: BoxDecoration(
                                //               color: Colors.grey[200],
                                //               borderRadius:
                                //                   BorderRadius.circular(8).r,
                                //             ),
                                //           ),
                                //         )
                                //       : FormBuilderDropdown<CityModel>(
                                //           name: "city_id",
                                //           enabled: isCityEnabled,
                                //           initialValue: cityList.contains(
                                //                   getCityById(widget.addressModel
                                //                           ?.stateId ??
                                //                       0))
                                //               ? getCityById(
                                //                   widget.addressModel?.stateId ??
                                //                       0)
                                //               : null,
                                //           items: (isCityEnabled == false)
                                //               ? []
                                //               : cityList.map((city) {
                                //                   return DropdownMenuItem(
                                //                     value: city,
                                //                     child: Text(
                                //                       city.name ?? '',
                                //                       style: context
                                //                           .textTheme.bodyLarge!
                                //                           .copyWith(
                                //                         fontSize: 14.sp,
                                //                       ),
                                //                     ),
                                //                   );
                                //                 }).toList(),
                                //           icon: SvgPicture.asset(
                                //             Assets.svgs.arrowDown,
                                //             height: 20.r,
                                //             color: isCityEnabled
                                //                 ? null
                                //                 : Colors
                                //                     .grey, // Adjust icon color
                                //           ),
                                //           decoration: InputDecoration(
                                //             fillColor: isCityEnabled
                                //                 ? null
                                //                 : context.isDarkMode
                                //                     ? Colors.grey[800]
                                //                     : Colors.grey[
                                //                         200], // Change background color
                                //             filled: !isCityEnabled,
                                //             label: Row(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Text(S.of(context).selectCity),
                                //                 Gap(6.w),
                                //                 SvgPicture.asset(
                                //                   Assets.svgs.star,
                                //                   height: 8.r,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           validator:
                                //               FormBuilderValidators.required(),
                                //           onChanged: (value) async {
                                //             _formKey
                                //                 .currentState!.fields['state_id']
                                //                 ?.reset();
                                //             areaList = await ref
                                //                     .read(
                                //                         areaListProvider.notifier)
                                //                     .getAreaList(
                                //                         cityId: value!.id!) ??
                                //                 [];
                                //             if (!mounted) return;
                                //             setState(() {
                                //               isAreaEnabled = true;
                                //             });
                                //           },
                                //         ),
                                //   Gap(24.h),
                                //   // Area dropdown
                                //   areaLoading
                                //       ? Skeletonizer(
                                //           enabled: true,
                                //           child: Container(
                                //             height: 50.h,
                                //             decoration: BoxDecoration(
                                //               color: Colors.grey[200],
                                //               borderRadius:
                                //                   BorderRadius.circular(8).r,
                                //             ),
                                //           ),
                                //         )
                                //       : FormBuilderDropdown<AreaModel>(
                                //           name: "state_id",
                                //           enabled: isAreaEnabled,
                                //           initialValue: areaList.contains(
                                //                   getAreaById(widget
                                //                           .addressModel?.cityId ??
                                //                       0))
                                //               ? getAreaById(
                                //                   widget.addressModel?.cityId ??
                                //                       0)
                                //               : null,
                                //           items: (isAreaEnabled == false)
                                //               ? []
                                //               : areaList.map((area) {
                                //                   return DropdownMenuItem(
                                //                     value: area,
                                //                     child: Text(
                                //                       area.name ?? '',
                                //                       style: context
                                //                           .textTheme.bodyLarge!
                                //                           .copyWith(
                                //                         fontSize: 14.sp,
                                //                       ),
                                //                     ),
                                //                   );
                                //                 }).toList(),
                                //           icon: SvgPicture.asset(
                                //             Assets.svgs.arrowDown,
                                //             height: 20.r,
                                //             color: isCityEnabled
                                //                 ? null
                                //                 : context.isDarkMode
                                //                     ? Colors.grey[800]
                                //                     : Colors
                                //                         .grey, // Adjust icon color
                                //           ),
                                //           decoration: InputDecoration(
                                //             fillColor: isAreaEnabled
                                //                 ? null
                                //                 : context.isDarkMode
                                //                     ? Colors.grey[800]
                                //                     : Colors.grey[
                                //                         200], // Change background color
                                //             filled: !isAreaEnabled,
                                //             label: Row(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               mainAxisSize: MainAxisSize.min,
                                //               children: [
                                //                 Text(S.of(context).selectArea),
                                //                 Gap(6.w),
                                //                 SvgPicture.asset(
                                //                   Assets.svgs.star,
                                //                   height: 8.r,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           validator:
                                //               FormBuilderValidators.required(),
                                //         ),
                                //   Gap(24.h),
                                // block and street in a row
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: FormBuilderTextField(
                                //         name: "block",
                                //         decoration: InputDecoration(
                                //             label: Text(S.of(context).block)),
                                //       ),
                                //     ),
                                //     Gap(16.w),
                                //     Expanded(
                                //       child: FormBuilderTextField(
                                //         name: "street",
                                //         decoration: InputDecoration(
                                //           label: Text(S.of(context).street),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Gap(24.h),
                                // avenue and house no in a row
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: FormBuilderTextField(
                                //         name: "avenue",
                                //         decoration: InputDecoration(
                                //           label: Text(S.of(context).avenue),
                                //         ),
                                //       ),
                                //     ),
                                //     Gap(16.w),
                                //     Expanded(
                                //       child: FormBuilderTextField(
                                //         name: "house",
                                //         decoration: InputDecoration(
                                //           label: Text(S.of(context).houseNo),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Gap(24.h),
                                // address line 1
                                // Gap(24.h),
                                FormBuilderTextField(
                                  name: "address_line1",
                                  decoration: InputDecoration(
                                    label: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(S.of(context).addressLine),
                                        Gap(6.w),
                                        SvgPicture.asset(
                                          Assets.svgs.star,
                                          height: 8.r,
                                        )
                                      ],
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                Gap(24.h),
                                // address line 2
                                FormBuilderTextField(
                                  name: "address_line2",
                                  decoration: InputDecoration(
                                    label: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${S.of(context).addressLine} 2"),
                                        Gap(6.w),
                                        // SvgPicture.asset(
                                        //   Assets.svgs.star,
                                        //   height: 8.r,
                                        // )
                                      ],
                                    ),
                                  ),
                                  // validator: FormBuilderValidators.compose([
                                  //   FormBuilderValidators.required(),
                                  // ]),
                                ),
                                Gap(24.h),
                              ],
                            ),
                          ),
                          Gap(8.h),
                          Container(
                            padding: const EdgeInsets.all(16).r,
                            color: context.cardColor,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).addressTag,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(8.h),
                                Row(
                                  children: List.generate(
                                    AddressTagEnum.values.length,
                                    (index) {
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ref
                                                      .read(addressTagProvider
                                                          .notifier)
                                                      .state =
                                                  AddressTagEnum.values[index];
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                          horizontal: 30,
                                                          vertical: 8)
                                                      .r,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(42).r,
                                                border: Border.all(
                                                  color: ref.watch(
                                                              addressTagProvider) ==
                                                          AddressTagEnum
                                                              .values[index]
                                                      ? AppColors.primaryColor
                                                      : AppColors.borderColor,
                                                ),
                                              ),
                                              child: Text(
                                                AddressTagEnum
                                                    .values[index].name
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gap(8.w),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(8.h),
                          Container(
                            padding: const EdgeInsets.all(16).r,
                            color: context.cardColor,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: FormBuilderCheckbox(
                                    name: 'is_default',
                                    title: Text(
                                      S.of(context).makeIdDefaultAddress,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .textTheme.labelLarge?.color!),
                                    ),
                                    onChanged: (value) {},
                                    activeColor: AppColors.primaryColor,
                                    contentPadding: const EdgeInsets.all(0),
                                    visualDensity:
                                        const VisualDensity(horizontal: -4),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                widget.isUpdate == true
                                    ? TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            barrierColor: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black.withOpacity(0.5),
                                            builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  context.isDarkMode
                                                      ? Colors.black
                                                      : Colors.white,
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              contentPadding:
                                                  const EdgeInsets.all(5),
                                              content: DeleteAddressDialog(
                                                  addressId:
                                                      widget.addressModel!.id!),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          S.of(context).deleteThis,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              height: 100.h,
              width: double.infinity,
              padding: const EdgeInsets.all(16).r,
              decoration: BoxDecoration(
                color: context.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final storeAddressLoading = ref.watch(addressStoreProvider);
                  final updateAddressLoading = ref.watch(addressUpdateProvider);
                  return storeAddressLoading || updateAddressLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          title: S.of(context).save,
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              Map<String, dynamic> rowData = {
                                ..._formKey.currentState!.value,
                              };

                              // // // Extract IDs from selected objects
                              // rowData['country_id'] =
                              //     _formKey.currentState!.value['country_id'].id ;
                              // rowData['city_id'] =
                              //     _formKey.currentState!.value['state_id'].id;
                              // rowData['state_id'] =
                              //     _formKey.currentState!.value['city_id'].id;
                              rowData['country_id'] = 1;
                              rowData['city_id'] = 1;
                              rowData['state_id'] = 1;

                              // Convert boolean to integer
                              rowData['is_default'] =
                                  rowData['is_default'] == true ? 1 : 0;

                              // Set the address type
                              rowData['type'] =
                                  ref.watch(addressTagProvider).name;

                              if (widget.isUpdate == true &&
                                  widget.addressModel != null) {
                                rowData['id'] = widget.addressModel!.id;
                                // **Update existing address**
                                ref
                                    .read(addressUpdateProvider.notifier)
                                    .updateAddress(rowData)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (mounted && value) {
                                    ref.invalidate(addressListProvider);
                                    GlobalFunction.showCustomSnackbar(
                                      message: "Address Updated Successfully",
                                      isSuccess: true,
                                    );
                                  }
                                });
                              } else {
                                // **Store new address**
                                ref
                                    .read(addressStoreProvider.notifier)
                                    .storeAddress(rowData)
                                    .then((value) {
                                  Navigator.pop(context);

                                  if (mounted && value) {
                                    ref.invalidate(addressListProvider);
                                    GlobalFunction.showCustomSnackbar(
                                      message: S
                                          .of(context)
                                          .addressStoredSuccessfully,
                                      isSuccess: true,
                                    );
                                  }
                                });
                              }
                            }
                          },
                        );
                },
              ),
            ),
          );
        });
  }

  CommonAppbarWithBg _headerSection() {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            widget.isUpdate == true
                ? S.of(context).updateAddress
                : S.of(context).addAddress,
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

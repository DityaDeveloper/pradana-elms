import 'dart:convert';

import 'android_version.dart';
import 'app_config.dart';
import 'currency.dart';
import 'currency_config.dart';
import 'ios_version.dart';
import 'language.dart';
import 'page.dart';
import 'payment_method.dart';

class Data {
  AppConfig? appConfig;
  AndroidVersion? androidVersion;
  IosVersion? iosVersion;
  List<Language>? languages;
  List<Currency>? currencies;
  List<dynamic>? addons;
  String? timezone;
  String? contactMobile;
  CurrencyConfig? currencyConfig;
  List<PaymentMethod>? paymentMethods;
  List<Page>? pages;

  Data({
    this.appConfig,
    this.androidVersion,
    this.iosVersion,
    this.languages,
    this.currencies,
    this.addons,
    this.timezone,
    this.contactMobile,
    this.currencyConfig,
    this.paymentMethods,
    this.pages,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        appConfig: data['app_config'] == null
            ? null
            : AppConfig.fromMap(data['app_config'] as Map<String, dynamic>),
        androidVersion: data['android_version'] == null
            ? null
            : AndroidVersion.fromMap(
                data['android_version'] as Map<String, dynamic>),
        iosVersion: data['ios_version'] == null
            ? null
            : IosVersion.fromMap(data['ios_version'] as Map<String, dynamic>),
        languages: (data['languages'] as List<dynamic>?)
            ?.map((e) => Language.fromMap(e as Map<String, dynamic>))
            .toList(),
        currencies: (data['currencies'] as List<dynamic>?)
            ?.map((e) => Currency.fromMap(e as Map<String, dynamic>))
            .toList(),
        addons: data['addons'] as List<dynamic>?,
        timezone: data['timezone'] as String?,
        contactMobile: data['contact_mobile'] as String?,
        currencyConfig: data['currency_config'] == null
            ? null
            : CurrencyConfig.fromMap(
                data['currency_config'] as Map<String, dynamic>),
        paymentMethods: (data['payment_methods'] as List<dynamic>?)
            ?.map((e) => PaymentMethod.fromMap(e as Map<String, dynamic>))
            .toList(),
        pages: (data['pages'] as List<dynamic>?)
            ?.map((e) => Page.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'app_config': appConfig?.toMap(),
        'android_version': androidVersion?.toMap(),
        'ios_version': iosVersion?.toMap(),
        'languages': languages?.map((e) => e.toMap()).toList(),
        'currencies': currencies?.map((e) => e.toMap()).toList(),
        'addons': addons,
        'timezone': timezone,
        'contact_mobile': contactMobile,
        'currency_config': currencyConfig?.toMap(),
        'payment_methods': paymentMethods?.map((e) => e.toMap()).toList(),
        'pages': pages?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}

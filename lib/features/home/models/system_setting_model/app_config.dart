import 'dart:convert';

class AppConfig {
  bool? loginMandatory;
  bool? introSkippable;
  String? privacyPolicyUrl;
  String? termsConditionUrl;
  String? supportUrl;
  bool? disableOtp;
  bool? disableEmail;
  String? defaultCountry;
  String? logo;
  String? baseUrl;
  String? assetBaseUrl;
  String? defaultCurrency;
  String? paginationLimit;

  AppConfig({
    this.loginMandatory,
    this.introSkippable,
    this.privacyPolicyUrl,
    this.termsConditionUrl,
    this.supportUrl,
    this.disableOtp,
    this.disableEmail,
    this.defaultCountry,
    this.logo,
    this.baseUrl,
    this.assetBaseUrl,
    this.defaultCurrency,
    this.paginationLimit,
  });

  factory AppConfig.fromMap(Map<String, dynamic> data) => AppConfig(
        loginMandatory: data['login_mandatory'] as bool?,
        introSkippable: data['intro_skippable'] as bool?,
        privacyPolicyUrl: data['privacy_policy_url'] as String?,
        termsConditionUrl: data['terms_condition_url'] as String?,
        supportUrl: data['support_url'] as String?,
        disableOtp: data['disable_otp'] as bool?,
        disableEmail: data['disable_email'] as bool?,
        defaultCountry: data['default_country'] as String?,
        logo: data['logo'] as String?,
        baseUrl: data['base_url'] as String?,
        assetBaseUrl: data['asset_base_url'] as String?,
        defaultCurrency: data['default_currency'] as String?,
        paginationLimit: data['pagination_limit'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'login_mandatory': loginMandatory,
        'intro_skippable': introSkippable,
        'privacy_policy_url': privacyPolicyUrl,
        'terms_condition_url': termsConditionUrl,
        'support_url': supportUrl,
        'disable_otp': disableOtp,
        'disable_email': disableEmail,
        'default_country': defaultCountry,
        'logo': logo,
        'base_url': baseUrl,
        'asset_base_url': assetBaseUrl,
        'default_currency': defaultCurrency,
        'pagination_limit': paginationLimit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppConfig].
  factory AppConfig.fromJson(String data) {
    return AppConfig.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AppConfig] to a JSON string.
  String toJson() => json.encode(toMap());
}

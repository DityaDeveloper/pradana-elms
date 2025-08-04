import 'dart:convert';

class IosVersion {
  String? latestIpaVersion;
  String? ipaCode;
  String? ipaFileUrl;
  String? whatsNew;
  bool? updateSkippable;

  IosVersion({
    this.latestIpaVersion,
    this.ipaCode,
    this.ipaFileUrl,
    this.whatsNew,
    this.updateSkippable,
  });

  factory IosVersion.fromMap(Map<String, dynamic> data) => IosVersion(
        latestIpaVersion: data['latest_ipa_version'] as String?,
        ipaCode: data['ipa_code'] as String?,
        ipaFileUrl: data['ipa_file_url'] as String?,
        whatsNew: data['whats_new'] as String?,
        updateSkippable: data['update_skippable'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'latest_ipa_version': latestIpaVersion,
        'ipa_code': ipaCode,
        'ipa_file_url': ipaFileUrl,
        'whats_new': whatsNew,
        'update_skippable': updateSkippable,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [IosVersion].
  factory IosVersion.fromJson(String data) {
    return IosVersion.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [IosVersion] to a JSON string.
  String toJson() => json.encode(toMap());
}

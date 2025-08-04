import 'dart:convert';

class AndroidVersion {
  String? latestApkVersion;
  String? apkCode;
  String? apkFileUrl;
  String? whatsNew;
  bool? updateSkippable;

  AndroidVersion({
    this.latestApkVersion,
    this.apkCode,
    this.apkFileUrl,
    this.whatsNew,
    this.updateSkippable,
  });

  factory AndroidVersion.fromMap(Map<String, dynamic> data) {
    return AndroidVersion(
      latestApkVersion: data['latest_apk_version'] as String?,
      apkCode: data['apk_code'] as String?,
      apkFileUrl: data['apk_file_url'] as String?,
      whatsNew: data['whats_new'] as String?,
      updateSkippable: data['update_skippable'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'latest_apk_version': latestApkVersion,
        'apk_code': apkCode,
        'apk_file_url': apkFileUrl,
        'whats_new': whatsNew,
        'update_skippable': updateSkippable,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AndroidVersion].
  factory AndroidVersion.fromJson(String data) {
    return AndroidVersion.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AndroidVersion] to a JSON string.
  String toJson() => json.encode(toMap());
}

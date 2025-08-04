import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/theme/app_theme.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/offline.dart';
import 'package:lms/generated/l10n.dart';

import 'core/constants/app_constants.dart';
import 'features/profile/logic/language_controller_hive.dart';

// Create a Riverpod provider for connectivity
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.map((event) => event.first);
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  Locale resolveLocal({required String langCode}) {
    return Locale(langCode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale locale = ref.watch(localeProvider);
    final connectivityStatus = ref.watch(connectivityProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder(
            valueListenable: Hive.box(AppConstants.appSettingsBox).listenable(),
            builder: (context, appSetting, _) {
              final selectedLocal =
                  appSetting.get(AppConstants.appLocal) as String?;
              if (selectedLocal == null) {
                appSetting.put(AppConstants.appLocal, 'en');
              }
              bool isDarkTheme =
                  appSetting.get(AppConstants.isDarkTheme, defaultValue: false);

              return MaterialApp.router(
                scaffoldMessengerKey: GlobalFunction.scaffoldMessengerKey,
                debugShowCheckedModeBanner: false,
                title: 'PradanaELMS',
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FormBuilderLocalizations.delegate,
                ],
                locale: locale,

                localeResolutionCallback: (deviceLocal, supportedLocales) {
                  if (selectedLocal == '') {
                    appSetting.put(
                      AppConstants.appLocal,
                      deviceLocal?.languageCode,
                    );
                  }
                  for (final locale in supportedLocales) {
                    if (locale.languageCode == deviceLocal!.languageCode) {
                      return deviceLocal;
                    }
                  }
                  return supportedLocales.first;
                },

                supportedLocales: S.delegate.supportedLocales,
                // locale: const Locale('en'),
                theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
                routerConfig: AppRouter.router,
                builder: (context, child) {
                  return connectivityStatus.when(data: (status) {
                    if (status == ConnectivityResult.none) {
                      return const Scaffold(
                        body: OfflineScreen(),
                      );
                    }
                    return child!;
                  }, error: (error, _) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Error'),
                      ),
                    );
                  }, loading: () {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  });
                },
              );
            });
      },
    );
  }
}

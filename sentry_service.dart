import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  static const String _dsn = String.fromEnvironment('SENTRY_DNS');
  static const double _tracesSampleRate = 1.0;
  static const double _profilesSampleRate = 1.0;

  static Future<void> init({required void Function() appRunner}) async {
    final packageInfo = await PackageInfo.fromPlatform();

    final releaseName =
        '${packageInfo.packageName}@${packageInfo.version}+${packageInfo.buildNumber}';

    await SentryFlutter.init((options) {
      options.dsn = _dsn;
      options.sendDefaultPii = true;
      options.tracesSampleRate = _tracesSampleRate;
      options.profilesSampleRate = _profilesSampleRate;
      options.environment = const String.fromEnvironment(
        'SENTRY_ENVIRONMENT',
        defaultValue: 'development',
      );
      options.release = releaseName;
      options.sendDefaultPii = true;
      options.reportSilentFlutterErrors = true;
      options.attachScreenshot = true;
      options.screenshotQuality = SentryScreenshotQuality.low;
      options.attachViewHierarchy = true;
      options.debug = false;
      options.spotlight = Spotlight(enabled: true);
      options.enableTimeToFullDisplayTracing = true;

      options.enableAutoSessionTracking = true;
    }, appRunner: appRunner);
  }
}

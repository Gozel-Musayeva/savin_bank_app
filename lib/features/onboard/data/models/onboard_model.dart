import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

/// Content + Figma geometry of one onboarding screen. All numbers are taken
/// from the 375×812 Figma frame and scaled with screenutil at use site.
class OnboardModel {
  const OnboardModel({
    required this.image,
    required this.title,
    required this.imageLeft,
    required this.imageTop,
    required this.imageWidth,
    required this.fadeStart,
    required this.fadeEnd,
    required this.contentBottom,
    required this.actionsGap,
  });

  /// `AppAssets` path of the phone mock-up render.
  final String image;
  final String title;

  /// Mock-up position and width in the frame.
  final double imageLeft;
  final double imageTop;
  final double imageWidth;

  /// Background fade over the mock-up, as fractions of the screen height:
  /// fully transparent at [fadeStart], solid background from [fadeEnd].
  final double fadeStart;
  final double fadeEnd;

  /// Distance from the bottom screen edge to the last button.
  final double contentBottom;

  /// Space between the title and the first button.
  final double actionsGap;

  /// Figma "Onboarding 1" (node 108:85155).
  static const first = OnboardModel(
    image: AppAssets.onboardFirst,
    title: AppTexts.onboardFirstTitle,
    imageLeft: 0,
    imageTop: 169,
    imageWidth: 375,
    fadeStart: 0.2198,
    fadeEnd: 0.6081,
    contentBottom: 69.8,
    actionsGap: 32,
  );

  /// Figma "Onboarding 2" (node 110:77954).
  static const second = OnboardModel(
    image: AppAssets.onboardSecond,
    title: AppTexts.onboardSecondTitle,
    imageLeft: 29,
    imageTop: 158,
    imageWidth: 319,
    fadeStart: 0.2783,
    fadeEnd: 0.6013,
    contentBottom: 53.6,
    actionsGap: 28,
  );

  static const pages = [first, second];
}

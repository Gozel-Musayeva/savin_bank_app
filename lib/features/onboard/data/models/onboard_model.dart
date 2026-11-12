class OnboardModel {
  const OnboardModel({
    required this.title,
    required this.description,
    this.image,
  });

  final String title;
  final String description;

  /// `AppAssets` path — filled in when the onboarding illustrations arrive.
  final String? image;

  static const pages = [
    OnboardModel(
      title: 'Manage your money in one place',
      description: 'Track balances, cards and spending at a glance.',
    ),
    OnboardModel(
      title: 'Send money instantly',
      description: 'Transfer to friends and family in seconds.',
    ),
    OnboardModel(
      title: 'Safe and secure',
      description: 'Your cards and data are always protected.',
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_loading.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/context_extension.dart';
import '../widgets/bank_card_carousel.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/send_money_section.dart';

/// Loads once on first open (MainPage keeps it alive in an IndexedStack),
/// showing a spinner while the (mock) dashboard request is in flight.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Stand-in for the dashboard request (user, cards, transactions).
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _isLoading ? const CustomLoading() : _content,
      ),
    );
  }

  /// Pull-to-refresh: content stays visible, spinner shows at the top.
  Future<void> _refresh() => Future.delayed(AppDurations.mockRequest);

  Widget get _content {
    final padding = EdgeInsets.symmetric(horizontal: AppSizes.homePadding.w);
    return RefreshIndicator.adaptive(
      onRefresh: _refresh,
      color: AppColors.primary500,
      backgroundColor: context.colors.surface,
      child: _scrollView(padding),
    );
  }

  Widget _scrollView(EdgeInsets padding) {
    return SingleChildScrollView(
      // Pullable even when the content is shorter than the screen.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: AppSizes.homeTop.h),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: AppSizes.homeSectionGap.h,
        children: [
          Padding(
            padding: padding,
            child: const HomeHeader(user: UserModel.current),
          ),
          const BankCardCarousel(),
          Padding(padding: padding, child: const QuickActions()),
          const SendMoneySection(),
          Padding(padding: padding, child: const RecentTransactions()),
        ],
      ),
    );
  }
}

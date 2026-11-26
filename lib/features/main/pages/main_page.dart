import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/navigation/tab_back_scope.dart';
import '../data/models/nav_bar_model.dart';
import '../widgets/nav_bar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const _homeIndex = 0;

  int _selectedIndex = _homeIndex;

  static const _tabs = [
    Pager.home,
    Pager.cards,
    Pager.transactions,
    Pager.profile,
  ];

  void _select(int index) => setState(() => _selectedIndex = index);

  void _goHome() => _select(_homeIndex);

  Widget _tab(NavBarModel item) => NavBarItem(
    item: item,
    isSelected: _selectedIndex == item.index,
    onTap: () => _select(item.index),
  );

  @override
  Widget build(BuildContext context) {
    // System back on another tab returns to Home instead of leaving the app.
    return PopScope(
      canPop: _selectedIndex == _homeIndex,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            for (final (i, tab) in _tabs.indexed)
              i == _homeIndex ? tab : TabBackScope(onBack: _goHome, child: tab),
          ],
        ),
        bottomNavigationBar: _navBar(context),
      ),
    );
  }

  Widget _navBar(BuildContext context) {
    const items = NavBarModel.items;
    final half = items.length ~/ 2;
    return Stack(
      clipBehavior: .none,
      alignment: .topCenter,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.navBarBackground,
            boxShadow: [
              BoxShadow(
                color: context.colors.shadow,
                blurRadius: 16,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: AppSizes.navBarHeight.h,
              child: Row(
                children: [
                  ...items.take(half).map(_tab),
                  // Room for the raised scan button drawn on top.
                  const Spacer(),
                  ...items.skip(half).map(_tab),
                ],
              ),
            ),
          ),
        ),
        Positioned(top: -AppSizes.navScanRaise.h, child: _scanButton(context)),
      ],
    );
  }

  /// Round brand button that sits above the bar — opens the QR scanner.
  Widget _scanButton(BuildContext context) => GestureDetector(
    onTap: () => Go.to(context, Pager.qrScan),
    child: Container(
      width: AppSizes.navScanButton.r,
      height: AppSizes.navScanButton.r,
      decoration: const BoxDecoration(
        shape: .circle,
        color: AppColors.primary500,
      ),
      child: Icon(
        Iconsax.scan_copy,
        size: AppSizes.navScanIcon.r,
        color: AppColors.white,
      ),
    ),
  );
}

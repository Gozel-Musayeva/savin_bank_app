import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/nav_bar_model.dart';
import '../widgets/nav_bar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const _tabs = [
    Pager.home,
    Pager.cards,
    Pager.statistics,
    Pager.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: DecoratedBox(
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
            height: 64.h,
            child: Row(
              children: [
                for (final item in NavBarModel.items)
                  NavBarItem(
                    item: item,
                    isSelected: _selectedIndex == item.index,
                    onTap: () => setState(() => _selectedIndex = item.index),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuel_application/screens/dashboard/logic/dashboard_cubit.dart';
import 'package:fuel_application/core/constants/app_colors.dart';
import 'package:fuel_application/screens/dashboard/logic/dashboard_state.dart';
import 'package:fuel_application/screens/home/presentation/screen/home_screen.dart';
import 'package:fuel_application/screens/more/presentation/screen/more_screen.dart';
import 'package:fuel_application/screens/report/presentation/screen/report_screen.dart';
import 'package:fuel_application/screens/stock/presentation/screen/stock_screen.dart';

class DashboardScreen extends StatelessWidget {
  final int initialIndex;

  const DashboardScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(initialIndex: initialIndex),
      child: const _DashboardScreenBody(),
    );
  }
}

class _DashboardScreenBody extends StatelessWidget {
  const _DashboardScreenBody();

  final List<Widget> pages = const [
    HomeScreen(),
    StockScreen(),
    ReportScreen(),
    MoreScreen(),
  ];

  Widget _buildNavItem({
    String? iconPath,
    IconData? icon,
    required String label,
    required bool isActive,
  }) {
    final activeColor = AppColors.customColor;
    const inactiveColor = Colors.grey;
    final color = isActive ? activeColor : inactiveColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 24,
            color: color,
          )
        else if (iconPath != null)
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
          ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;

        return PopScope(
          canPop: selectedIndex == 0, // Allow exit only if on Home tab
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            if (selectedIndex != 0) {
              context.read<DashboardCubit>().selectHomeTab();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: selectedIndex,
              children: pages,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  context.read<DashboardCubit>().changeTab(index);
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: _buildNavItem(
                      iconPath: 'assets/icons/home_icon.svg',
                      label: "Home",
                      isActive: selectedIndex == 0,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem(
                      iconPath: 'assets/icons/stock_svg.svg',
                      label: "Stock",
                      isActive: selectedIndex == 1,
                    ),
                    label: "Stock",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem(
                      iconPath: 'assets/icons/report_svg.svg',
                      label: "Report",
                      isActive: selectedIndex == 2,
                    ),
                    label: "Report",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem(
                      icon: Icons.more_horiz, // Native 3 dots icon
                      label: "More",
                      isActive: selectedIndex == 3,
                    ),
                    label: "More",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
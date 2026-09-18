import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/home/logic/home_cubit.dart';
import 'package:fuel_application/screens/home/logic/home_state.dart';
import 'package:fuel_application/screens/home/presentation/widget/tank_inventory_card.dart';
import 'package:fuel_application/screens/shift/presentation/screen/active_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(AuthRepositoryImpl())..fetchDashboardData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1E293B)),
                );
              }

              if (state.status == HomeStatus.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? "Failed to load dashboard data",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final data = state.dashboardData;
              if (data == null) return const SizedBox.shrink();

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active Manager Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Active Manager",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Ali Khan",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF1E293B),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Top Stat Cards (Revenue & Volume)
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            title: "Revenue Today",
                            value: "PKR ${(data.todayRevenuePkr / 1000).toStringAsFixed(0)}k",
                            subtitle: "+12.4%",
                            subtitleColor: const Color(0xFF16A34A),
                            icon: Icons.payments_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            title: "Dispensed",
                            value: "${data.todayLitres.toStringAsFixed(1)} L",
                            subtitle: "Yesterday: ${data.yesterdayLitres} L",
                            subtitleColor: const Color(0xFF64748B),
                            icon: Icons.water_drop_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Today Fuel Rates Section
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            title: "Petrol Rate",
                            value: "PKR 349.00",
                            subtitle: "per litre",
                            subtitleColor: const Color(0xFF16A34A),
                            icon: Icons.local_gas_station_outlined,
                            cardBgColor: const Color(0xFFF0FDF4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            title: "Diesel Rate",
                            value: "PKR 374.31",
                            subtitle: "per litre",
                            subtitleColor: const Color(0xFF2563EB),
                            icon: Icons.oil_barrel_outlined,
                            cardBgColor: const Color(0xFFEFF6FF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Active Shift Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF22C55E),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Open Shifts (${data.openShifts})",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                data.lastShiftLabel,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),


                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ActiveShiftScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.15),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),


                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tank Inventory Section Header
                    const Row(
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 20, color: Color(0xFF0F172A)),
                        SizedBox(width: 8),
                        Text(
                          "Tank Inventory",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Dynamic Tank List
                    ...data.tankLevels.map((tank) => TankInventoryCard(tank: tank)),

                    const SizedBox(height: 16),

                    // Dispenser Status Overview
                    const Text(
                      "Nozzle & Dispenser Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Active Dispensers",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${data.activeDispenserCount} / ${data.totalDispenserCount}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color subtitleColor,
    required IconData icon,
    Color cardBgColor = const Color(0xFFF1F5F9),
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
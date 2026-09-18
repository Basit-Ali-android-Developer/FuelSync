import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/report/logic/reports_cubit.dart';
import 'package:fuel_application/screens/report/logic/reports_state.dart';
import 'package:fuel_application/screens/report/presentation/widget/report_card.dart';


class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(AuthRepositoryImpl())..fetchReports(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Reports Dashboard',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFF0F172A)),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Access and manage your key financial and operational reports.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Search Bar
                Builder(
                  builder: (ctx) {
                    return TextField(
                      onChanged: (val) => ctx.read<ReportsCubit>().searchReports(val),
                      decoration: InputDecoration(
                        hintText: "Search reports...",
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Category Chips
                BlocBuilder<ReportsCubit, ReportsState>(
                  builder: (context, state) {
                    final selected = state is ReportsLoaded ? state.selectedCategory : 'All';
                    final categories = ['All', 'Financial', 'Tax Compliance', 'Inventory'];

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((cat) {
                          final isSelected = selected == cat;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(cat),
                              selected: isSelected,
                              onSelected: (_) {
                                context.read<ReportsCubit>().filterByCategory(cat);
                              },
                              selectedColor: const Color(0xFF0F172A),
                              backgroundColor: const Color(0xFFF8FAFC),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF64748B),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Main Reports List
                Expanded(
                  child: BlocBuilder<ReportsCubit, ReportsState>(
                    builder: (context, state) {
                      if (state is ReportsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Color(0xFF0F172A)),
                        );
                      }

                      if (state is ReportsError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }

                      if (state is ReportsLoaded) {
                        if (state.filteredReports.isEmpty) {
                          return const Center(
                            child: Text(
                              "No reports found.",
                              style: TextStyle(color: Color(0xFF64748B)),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: state.filteredReports.length,
                          itemBuilder: (context, index) {
                            final report = state.filteredReports[index];
                            return ReportCard(
                              report: report,
                              onTap: () {
                                // Navigate to detailed report view
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
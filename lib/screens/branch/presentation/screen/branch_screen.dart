import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/constants/request_status.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/branch/logic/branch_cubit.dart';
import 'package:fuel_application/screens/branch/logic/branch_state.dart';
import 'package:fuel_application/screens/branch/presentation/widget/branch_card.dart';
import 'package:fuel_application/screens/dashboard/presentation/screen/dashboard_screen.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BranchCubit(AuthRepositoryImpl())..fetchBranches(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: BlocBuilder<BranchCubit, BranchState>(
              builder: (context, state) {
                if (state.status == RequestStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Color(0xFF0F172A),
                    ),
                  );
                }

                if (state.status == RequestStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? "Failed to load branches",
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Top Sub-header
                    const Text(
                      "FUELBOARD",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Main Title
                    const Text(
                      "Choose your branch",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    const Text(
                      "Select a station to access your workspace",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Branch List
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.branches.length,
                        itemBuilder: (context, index) {
                          final branch = state.branches[index];
                          final isSelected =
                              state.selectedBranch?.branchId == branch.branchId;

                          return BranchCard(
                            branch: branch,
                            isSelected: isSelected,
                            onTap: () {
                              context.read<BranchCubit>().selectBranch(branch);
                            },
                          );
                        },
                      ),
                    ),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.selectedBranch != null
                            ? () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                                (route) => false,
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF8FAFC),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/screens/more/logic/more_cubit.dart';
import 'package:fuel_application/screens/more/logic/more_state.dart';
import 'package:fuel_application/screens/more/presentation/widget/more_option_card.dart';


class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit()..loadUserData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<MoreCubit, MoreState>(
            listener: (context, state) {
              if (state is MoreLoggedOut) {
                // Navigate back to login screen
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is MoreLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF0F172A)),
                );
              }

              if (state is MoreError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }

              if (state is MoreLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      // User Profile Header
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 44,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  child: Text(
                                    state.name.isNotEmpty ? state.name[0].toUpperCase() : 'U',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF059669),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.email,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(
                                    radius: 3,
                                    backgroundColor: Color(0xFFD97706),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    state.role,
                                    style: const TextStyle(
                                      color: Color(0xFFB45309),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Account Details Section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ACCOUNT DETAILS",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64748B),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Update Profile Card
                      MoreOptionCard(
                        icon: Icons.person_outline_rounded,
                        title: "Update Profile",
                        subtitle: "Edit your name, email, and personal information",
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdateProfileScreen()));
                        },
                      ),

                      // Notification Settings Card
                      MoreOptionCard(
                        icon: Icons.notifications_none_rounded,
                        title: "Notifications",
                        subtitle: "Manage alert preferences and push notifications",
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                        },
                      ),
                      const SizedBox(height: 24),

                      // Operations Section
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "OPERATIONS",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64748B),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Active Branch Details
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.store_outlined,
                                    color: Color(0xFF0F172A),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Active Branch",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      state.activeBranch,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Action to switch branch
                                },
                                icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                                label: const Text("Switch Working Branch"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0F172A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Logout Button
                      TextButton.icon(
                        onPressed: () => context.read<MoreCubit>().logout(),
                        icon: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 18),
                        label: const Text(
                          "Log Out of Account",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Version Footer
                      const Text(
                        "Version 2.4.1 (Build 8492)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
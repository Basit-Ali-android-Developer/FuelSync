import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/constants/request_status.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/core/utils/toast_helper.dart';
import 'package:fuel_application/core/widgets/primary_button.dart';
import 'package:fuel_application/core/widgets/primary_text_field.dart';
import 'package:fuel_application/screens/auth/logic/login_cubit.dart';
import 'package:fuel_application/screens/auth/logic/login_state.dart';
import 'package:fuel_application/screens/dashboard/presentation/screen/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tenantController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _tenantController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _tenantController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepositoryImpl()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Form(
                key: _formKey,
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.status == RequestStatus.error) {
                      ToastHelper.showError(
                        context,
                        state.errorMessage ?? 'Login Failed',
                      );
                    } else if (state.status == RequestStatus.success) {
                      ToastHelper.showSuccess(context, 'Login successfully!');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
                            (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;

                    return Column(
                      children: [
                        const SizedBox(height: 20),

                        // App Icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.local_gas_station_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // App Title
                        const Text(
                          "FuelSync",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        const Text(
                          "Sign in to access station telemetry",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Main Login Card Container
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TENANT CODE FIELD
                              PrimaryTextField(
                                controller: _tenantController,
                                label: "Tenant Code",
                                hintText: "Enter tenant code",
                                prefixIcon: Icons.apartment_rounded,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter tenant code";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // EMAIL ADDRESS FIELD
                              PrimaryTextField(
                                controller: _emailController,
                                label: "Email Address",
                                hintText: "owner@station.com",
                                prefixIcon: Icons.mail_outline_rounded,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!value.contains('@')) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // PASSWORD FIELD HEADER WITH FORGOT BUTTON
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  GestureDetector(
                                    onTap: () {
                                      // Forgot Password Action
                                    },
                                    child: const Text(
                                      "Forgot?",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              PrimaryTextField(
                                controller: _passwordController,
                                label: "Password",
                                hintText: "••••••••••••",
                                isObscure: state.isPasswordObscured,
                                prefixIcon: Icons.lock_outline_rounded,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    state.isPasswordObscured
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF64748B),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<LoginCubit>()
                                        .togglePasswordVisibility();
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 28),

                              // SUBMIT BUTTON
                              PrimaryButton(
                                title: isLoading ? "LOGGING IN..." : "LOG IN TO BRANCH",
                                icon: Icons.arrow_forward_rounded,
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      tenantCode: _tenantController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Enhanced Design: End-to-End Security Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              size: 16,
                              color: Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "256-bit Encrypted Telemetry Connection",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
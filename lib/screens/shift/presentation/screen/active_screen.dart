import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/screens/shift/logic/active_shift_cubit.dart';
import 'package:fuel_application/screens/shift/logic/active_shift_state.dart';
import 'package:fuel_application/screens/shift/presentation/widget/nozzle_card.dart';
import 'package:fuel_application/screens/shift/presentation/widget/shift_header_card.dart';
import 'package:fuel_application/screens/shift/presentation/widget/worker_card.dart';


class ActiveShiftScreen extends StatelessWidget {
  const ActiveShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveShiftCubit()..fetchActiveShift(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Active Shift Operations',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocBuilder<ActiveShiftCubit, ActiveShiftState>(
          builder: (context, state) {
            if (state is ActiveShiftLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActiveShiftError) {
              return Center(child: Text(state.message));
            } else if (state is ActiveShiftLoaded) {
              final shift = state.shift;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShiftHeaderCard(shift: shift),
                    const SizedBox(height: 24),
                    const Text(
                      'Active Crew',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...shift.workers.map((w) => WorkerCard(worker: w)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nozzle Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<ActiveShiftCubit>()
                              .fetchActiveShift(),
                          child: Row(
                            children: const [
                              Icon(Icons.refresh, size: 16, color: Colors.black54),
                              SizedBox(width: 4),
                              Text(
                                'Sync',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...shift.nozzleAssignments
                        .map((n) => NozzleCard(nozzle: n)),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/screens/shift/data/active_shift_model.dart';
import 'active_shift_state.dart';

class ActiveShiftCubit extends Cubit<ActiveShiftState> {
  ActiveShiftCubit() : super(ActiveShiftInitial());

  Future<void> fetchActiveShift() async {
    emit(ActiveShiftLoading());

    try {
      // Mock API Delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock response aligned with your backend JSON schema & image details
      final mockJsonResponse = {
        "id": 42,
        "branchId": 3,
        "branchName": "Main Branch",
        "openedAt": "Today 06:00 AM",
        "openingFloat": 10000.00,
        "templateName": "Morning Shift",
        "supervisor": "Ali Khan",
        "elapsedTime": "4h 42m",
        "workers": [
          {
            "name": "Ahmed Ali",
            "role": "NozzleMan",
            "assignmentDetails": "Assigned: D-01/N1, D-01/N2"
          },
          {
            "name": "Bilal Khan",
            "role": "Cashier",
            "assignmentDetails": "Receiver for Ahmed Ali"
          }
        ],
        "nozzleAssignments": [
          {
            "nozzleCode": "N1",
            "dispenserCode": "D-01",
            "fuelType": "Super Petrol",
            "assignedTo": "Ahmed Ali",
            "rate": 280.75,
            "openingReading": 12450.50
          },
          {
            "nozzleCode": "N2",
            "dispenserCode": "D-01",
            "fuelType": "High Speed Diesel",
            "assignedTo": "Ahmed Ali",
            "rate": 265.50,
            "openingReading": 8900.00
          }
        ]
      };

      final activeShift = ActiveShift.fromJson(mockJsonResponse);
      emit(ActiveShiftLoaded(activeShift));
    } catch (e) {
      emit(ActiveShiftError('Failed to load active shift details'));
    }
  }
}
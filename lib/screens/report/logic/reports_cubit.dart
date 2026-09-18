import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/report/data/report_model.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final AuthRepositoryImpl repository;

  ReportsCubit(this.repository) : super(ReportsInitial());

  void fetchReports() async {
    emit(ReportsLoading());
    try {
      // Mock static API response for now
      await Future.delayed(const Duration(milliseconds: 600));

      final staticData = [
        ReportItem(
          id: '1',
          title: 'Profit & Loss (P&L)',
          description: 'View revenue, operational costs, and net profit margins over time.',
          category: 'Financial',
          status: 'Generated Today',
          iconType: 'analytics',
        ),
        ReportItem(
          id: '2',
          title: 'FBR Sales Tax Register',
          description: 'Official monthly sales tax records formatted for regulatory compliance.',
          category: 'Tax Compliance',
          status: 'Last Update: Yesterday',
          iconType: 'tax',
        ),
        ReportItem(
          id: '3',
          title: 'OGRA Daily Stock Report',
          description: 'Daily tank inventory and dip levels required for regulatory submission.',
          category: 'Inventory',
          status: 'Pending Submission',
          iconType: 'inventory',
        ),
        ReportItem(
          id: '4',
          title: 'Nozzle Sales Reconciliation',
          description: 'Detailed breakdown of mechanical vs electronic counter nozzle readings.',
          category: 'Financial',
          status: 'Generated Today',
          iconType: 'nozzle',
        ),
      ];

      emit(ReportsLoaded(allReports: staticData, filteredReports: staticData));
    } catch (e) {
      emit(ReportsError('Failed to load reports. Please try again.'));
    }
  }

  void filterByCategory(String category) {
    if (state is ReportsLoaded) {
      final current = state as ReportsLoaded;
      final query = current.searchQuery.toLowerCase();

      final filtered = current.allReports.where((item) {
        final matchesCategory = (category == 'All') || (item.category == category);
        final matchesQuery = item.title.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
        return matchesCategory && matchesQuery;
      }).toList();

      emit(current.copyWith(
        selectedCategory: category,
        filteredReports: filtered,
      ));
    }
  }

  void searchReports(String query) {
    if (state is ReportsLoaded) {
      final current = state as ReportsLoaded;
      final q = query.toLowerCase();

      final filtered = current.allReports.where((item) {
        final matchesCategory = (current.selectedCategory == 'All') ||
            (item.category == current.selectedCategory);
        final matchesQuery = item.title.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q);
        return matchesCategory && matchesQuery;
      }).toList();

      emit(current.copyWith(
        searchQuery: query,
        filteredReports: filtered,
      ));
    }
  }
}


import 'package:fuel_application/screens/report/data/report_model.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final List<ReportItem> allReports;
  final List<ReportItem> filteredReports;
  final String selectedCategory;
  final String searchQuery;

  ReportsLoaded({
    required this.allReports,
    required this.filteredReports,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  ReportsLoaded copyWith({
    List<ReportItem>? allReports,
    List<ReportItem>? filteredReports,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return ReportsLoaded(
      allReports: allReports ?? this.allReports,
      filteredReports: filteredReports ?? this.filteredReports,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ReportsError extends ReportsState {
  final String message;
  ReportsError(this.message);
}
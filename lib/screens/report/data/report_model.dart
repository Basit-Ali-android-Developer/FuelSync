class ReportItem {
  final String id;
  final String title;
  final String description;
  final String category; // e.g., 'Financial', 'Tax Compliance', 'Inventory'
  final String status;   // e.g., 'Generated Today', 'Last Update: Yesterday', 'Pending Submission'
  final String iconType;

  ReportItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.iconType,
  });

  factory ReportItem.fromJson(Map<String, dynamic> json) {
    return ReportItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'General',
      status: json['status'] ?? '',
      iconType: json['iconType'] ?? 'default',
    );
  }
}
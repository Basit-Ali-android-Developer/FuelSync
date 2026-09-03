// import 'package:ecommerce/core/constants/product.dart';
//
// abstract class HomeState {}
//
// class HomeInitialState extends HomeState {}
//
// class HomeLoadedState extends HomeState {
//   final List<Product> allProducts;
//   final List<Product> filteredProducts;
//   final String searchQuery;
//
//   HomeLoadedState({
//     required this.allProducts,
//     required this.filteredProducts,
//     required this.searchQuery,
//   });
//
//   HomeLoadedState copyWith({
//     List<Product>? allProducts,
//     List<Product>? filteredProducts,
//     String? searchQuery,
//   }) {
//     return HomeLoadedState(
//       allProducts: allProducts ?? this.allProducts,
//       filteredProducts: filteredProducts ?? this.filteredProducts,
//       searchQuery: searchQuery ?? this.searchQuery,
//     );
//   }
// }
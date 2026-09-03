// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ecommerce/core/constants/product.dart';
// import 'home_state.dart';
//
// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitialState());
//
//   void loadProducts() {
//     // Initially load mock products (or replace with API call)
//     emit(
//       HomeLoadedState(
//         allProducts: mockProducts,
//         filteredProducts: mockProducts,
//         searchQuery: '',
//       ),
//     );
//   }
//
//   void filterProducts(String query) {
//     if (state is HomeLoadedState) {
//       final currentState = state as HomeLoadedState;
//
//       if (query.trim().isEmpty) {
//         emit(
//           currentState.copyWith(
//             filteredProducts: currentState.allProducts,
//             searchQuery: '',
//           ),
//         );
//       } else {
//         final filtered = currentState.allProducts.where((product) {
//           return product.title.toLowerCase().contains(query.toLowerCase());
//         }).toList();
//
//         emit(
//           currentState.copyWith(
//             filteredProducts: filtered,
//             searchQuery: query,
//           ),
//         );
//       }
//     }
//   }
// }
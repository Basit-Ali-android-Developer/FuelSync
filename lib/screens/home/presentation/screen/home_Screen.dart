import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..loadProducts(),
//       child: const HomeScreenContent(),
//     );
//   }
// }
//
// class HomeScreenContent extends StatelessWidget {
//   const HomeScreenContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//                 children: [
//                 // Header Search
//                 CustomHeaderAppBar(
//                 onMenuPressed: () {},
//             onNotificationPressed: () {},
//             onSearchChanged: (query) {
//               context.read<HomeCubit>().filterProducts(query);
//             },
//             onVoiceSearchPressed: () {},
//             onCameraSearchPressed: () {},
//           ),
//
//           // Categories Section ------------------------------------------
//           SectionHeader(
//             title: "Categories",
//             icon: Icons.category_outlined,
//             onViewAllPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CategoryScreen(),
//                 ),
//               );
//             },
//           ),
//
//           SizedBox(
//             height: 92,
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               scrollDirection: Axis.horizontal,
//               itemCount: mockCategories.length,
//               separatorBuilder: (context, index) =>
//               const SizedBox(width: 16),
//               itemBuilder: (context, index) {
//                 final category = mockCategories[index];
//                 return CategoryCard(
//                   title: category.title,
//                   iconPath: category.iconPath,
//                   backgroundColor: category.backgroundColor,
//                   iconColor: category.iconColor,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CategoryScreen(
//                           initialCategory: category.title,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//
//
//           const SizedBox(height: 12),
//
//           // Flash Sale Section -----------------------------------------
//           SectionHeader(
//             title: "Flash Sale",
//             icon: Icons.bolt,
//             onViewAllPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const FlashSaleScreen(),
//                 ),
//               );
//             },
//           ),
//
//           SizedBox(
//             height: 270,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 10,
//               ),
//               itemCount: mockProducts.length,
//               itemBuilder: (context, index) {
//                 final product = mockProducts[index];
//                 return Padding(
//                     padding: const EdgeInsets.only(right: 14.0),
//                 child: ProductCard(
//                 product: product,
//                 onTap: () {},
//                 )
//                 );
//               },
//             ),
//           ),
//
//         const SizedBox(height: 12),
//
//         // Recommended Section Header ---------------------------------
//
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Recommended for You",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     letterSpacing: -0.5,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         // Reactive Section with BlocBuilder --------------------------
//         BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoadedState) {
//               if (state.filteredProducts.isEmpty) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 48.0),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.search_off_rounded,
//                         size: 64,
//                         color: Colors.grey.shade400,
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'No products found for "${state.searchQuery}"',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey.shade600,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate:
//                 const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   childAspectRatio: 0.65,
//                 ),
//                 itemCount: state.filteredProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = state.filteredProducts[index];
//                   return ProductCard(
//                     product: product,
//                     onTap: () {},
//                   );
//                 },
//               );
//             }
//
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//
//         const SizedBox(height: 24),
//         ],
//       ),
//     ),
//     ),
//     ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

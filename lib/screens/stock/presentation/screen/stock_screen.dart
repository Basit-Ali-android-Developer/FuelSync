import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/stock/logic/stock_cubit.dart';
import 'package:fuel_application/screens/stock/logic/stock_state.dart';
import 'package:fuel_application/screens/stock/presentation/widget/delivery_card.dart';
import 'package:fuel_application/screens/stock/presentation/widget/stock_tank_inventory_card.dart';
import 'package:fuel_application/screens/stock/presentation/widget/total_inventory_card.dart';

class StockScreen extends StatelessWidget {
  final int branchId;

  const StockScreen({Key? key, this.branchId = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockCubit(AuthRepositoryImpl())
        ..fetchStockData(branchId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [

                    Icon(Icons.location_on, size: 12, color: Colors.black87),

                    SizedBox(width: 4),

                    Text('Main Branch • Lahore', style: TextStyle(color: Colors.black87, fontSize: 12)),

                  ],
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<StockCubit, StockState>(
          builder: (context, state) {
            if (state is StockLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StockError) {
              return Center(child: Text(state.message));
            } else if (state is StockLoaded) {
              final data = state.stockData;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TotalInventoryCard(total: data.totalInventory),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tank Inventory',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '4 Active • ATG & Manual',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 12),
                    ...data.tanks.map((tank) => StockTankInventoryCard(tank: tank)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Deliveries',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View All (12)'),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...data.recentDeliveries.map((del) => DeliveryCard(delivery: del)),
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
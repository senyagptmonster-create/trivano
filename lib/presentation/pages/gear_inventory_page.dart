import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/gear_inventory_repository.dart';
import '../../domain/pack_weight_math.dart';
import '../trivano_palette.dart';

class GearInventoryPage extends StatelessWidget {
  const GearInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<GearInventoryRepository>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: repo.items.length,
      itemBuilder: (context, idx) {
        final item = repo.items[idx];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: TrivanoPalette.cardBorder),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: TrivanoPalette.alpineForest.withValues(alpha: 0.1),
              child: Icon(_categoryIcon(item.category), color: TrivanoPalette.alpineForest, size: 20),
            ),
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              item.isWorn ? 'Worn Gear (Not in base weight)' : item.category.name.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                color: item.isWorn ? Colors.blueGrey : TrivanoPalette.mossLime,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '${item.weightGrams.toStringAsFixed(0)} g',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  IconData _categoryIcon(GearCategory cat) {
    switch (cat) {
      case GearCategory.shelter: return Icons.cottage;
      case GearCategory.sleepSystem: return Icons.bed;
      case GearCategory.cooking: return Icons.local_fire_department;
      case GearCategory.clothing: return Icons.dry_cleaning;
      case GearCategory.electronics: return Icons.battery_charging_full;
      case GearCategory.firstAid: return Icons.medical_services;
    }
  }
}

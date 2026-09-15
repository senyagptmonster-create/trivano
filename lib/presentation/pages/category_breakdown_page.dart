import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/gear_inventory_repository.dart';
import '../../domain/pack_weight_math.dart';
import '../trivano_palette.dart';

class CategoryBreakdownPage extends StatelessWidget {
  const CategoryBreakdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<GearInventoryRepository>();
    final totalGrams = repo.baseWeightGrams;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: GearCategory.values.map((cat) {
        final catGrams = repo.categoryWeight(cat);
        final pct = totalGrams > 0 ? (catGrams / totalGrams) : 0.0;

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: TrivanoPalette.cardBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(_catName(cat), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    Text('${catGrams.toStringAsFixed(0)} g  (${(pct * 100).toStringAsFixed(0)}%)',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: TrivanoPalette.alpineForest)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: pct.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: TrivanoPalette.cardBorder,
                    valueColor: const AlwaysStoppedAnimation(TrivanoPalette.mossLime),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _catName(GearCategory cat) {
    switch (cat) {
      case GearCategory.shelter: return 'Shelter & Tarp';
      case GearCategory.sleepSystem: return 'Sleep System & Pad';
      case GearCategory.cooking: return 'Cookware & Stove';
      case GearCategory.clothing: return 'Packed Insulation & Rain';
      case GearCategory.electronics: return 'Electronics & Power';
      case GearCategory.firstAid: return 'First Aid & Hygeine';
    }
  }
}

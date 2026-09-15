import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/gear_inventory_repository.dart';
import '../trivano_palette.dart';

class PackTargetPage extends StatelessWidget {
  const PackTargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<GearInventoryRepository>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: TrivanoPalette.cardBorder),
            ),
            child: Column(
              children: [
                const Text('Trail Base Weight (Excl. Food/Water)',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 10),
                Text(
                  '${repo.baseWeightKg.toStringAsFixed(2)} kg',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: TrivanoPalette.alpineForest,
                  ),
                ),
                Text(
                  '(${repo.baseWeightLbs.toStringAsFixed(1)} lbs)',
                  style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: repo.isUltralight ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    repo.isUltralight ? '✓ ULTRALIGHT SUB-10 LB CERTIFIED' : 'TRADITIONAL PACK WEIGHT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: repo.isUltralight ? const Color(0xFF166534) : const Color(0xFF92400E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: TrivanoPalette.cardBorder),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Thru-Hike Packing Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  Text('• Base Weight: Total pack minus consumables (food, water, fuel).'),
                  SizedBox(height: 6),
                  Text('• Ultralight: Base weight under 10 lbs (4.53 kg).'),
                  SizedBox(height: 6),
                  Text('• Super-Ultralight: Base weight under 5 lbs (2.27 kg).'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/gear_inventory_repository.dart';
import '../trivano_palette.dart';

class TripChecklistPage extends StatelessWidget {
  const TripChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<GearInventoryRepository>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: repo.checklist.entries.map((entry) {
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: TrivanoPalette.cardBorder),
          ),
          child: CheckboxListTile(
            title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
            value: entry.value,
            activeColor: TrivanoPalette.alpineForest,
            onChanged: (_) => repo.toggleChecklist(entry.key),
          ),
        );
      }).toList(),
    );
  }
}

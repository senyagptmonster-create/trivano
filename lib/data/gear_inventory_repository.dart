import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/pack_weight_math.dart';

class GearInventoryRepository extends ChangeNotifier {
  final List<GearItem> _items = [
    const GearItem(
      id: 'g1',
      name: 'DCF Dyneema 1P Tent',
      category: GearCategory.shelter,
      weightGrams: 420.0,
    ),
    const GearItem(
      id: 'g2',
      name: '850FP Down Quilt (20°F)',
      category: GearCategory.sleepSystem,
      weightGrams: 580.0,
    ),
    const GearItem(
      id: 'g3',
      name: 'Insulated Sleeping Pad R4.5',
      category: GearCategory.sleepSystem,
      weightGrams: 410.0,
    ),
    const GearItem(
      id: 'g4',
      name: 'Titanium 550ml Cook Pot',
      category: GearCategory.cooking,
      weightGrams: 95.0,
    ),
    const GearItem(
      id: 'g5',
      name: 'Micro Canister Stove',
      category: GearCategory.cooking,
      weightGrams: 48.0,
    ),
    const GearItem(
      id: 'g6',
      name: 'Merino Wool Base Layer (Worn)',
      category: GearCategory.clothing,
      weightGrams: 210.0,
      isWorn: true,
    ),
    const GearItem(
      id: 'g7',
      name: '10,000mAh Power Bank',
      category: GearCategory.electronics,
      weightGrams: 175.0,
    ),
    const GearItem(
      id: 'g8',
      name: 'Trail Running Shoes (Worn)',
      category: GearCategory.clothing,
      weightGrams: 640.0,
      isWorn: true,
    ),
  ];

  final Map<String, bool> _checklist = {
    'Water filter backflushed': true,
    'Permethrin gear treated': true,
    'Offline maps cached': true,
    'Bear canister packed': false,
    'First aid blister tape checked': true,
  };

  GearInventoryRepository() {
    _loadPrefs();
  }

  List<GearItem> get items => _items;
  Map<String, bool> get checklist => _checklist;

  double get baseWeightGrams {
    return _items
        .where((item) => !item.isWorn && !item.isConsumable)
        .fold(0.0, (sum, item) => sum + item.weightGrams);
  }

  double get baseWeightKg => baseWeightGrams / 1000.0;
  double get baseWeightLbs => baseWeightGrams * 0.00220462;
  bool get isUltralight => baseWeightLbs <= 10.0;

  double categoryWeight(GearCategory cat) {
    return _items
        .where((item) => item.category == cat && !item.isWorn)
        .fold(0.0, (sum, item) => sum + item.weightGrams);
  }

  void addItem(String name, GearCategory cat, double grams) {
    _items.add(GearItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      category: cat,
      weightGrams: grams,
    ));
    notifyListeners();
  }

  void toggleChecklist(String key) {
    if (_checklist.containsKey(key)) {
      _checklist[key] = !_checklist[key]!;
      notifyListeners();
    }
  }

  Future<void> _loadPrefs() async {
    await SharedPreferences.getInstance();
    notifyListeners();
  }
}

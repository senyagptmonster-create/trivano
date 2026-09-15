enum GearCategory { shelter, sleepSystem, cooking, clothing, electronics, firstAid }

class GearItem {
  final String id;
  final String name;
  final GearCategory category;
  final double weightGrams;
  final bool isWorn;
  final bool isConsumable;

  const GearItem({
    required this.id,
    required this.name,
    required this.category,
    required this.weightGrams,
    this.isWorn = false,
    this.isConsumable = false,
  });
}

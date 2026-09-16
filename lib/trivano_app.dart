import 'package:flutter/material.dart';
import 'theme/trivano_theme.dart';
import 'painters/backpack_weight_painter.dart';

class TrivanoApp extends StatelessWidget {
  const TrivanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivano Ultralight Pack',
      debugShowCheckedModeBanner: false,
      theme: TrivanoTheme.themeData,
      home: const TrivanoShell(),
    );
  }
}

class TrivanoShell extends StatefulWidget {
  const TrivanoShell({super.key});

  @override
  State<TrivanoShell> createState() => _TrivanoShellState();
}

class _TrivanoShellState extends State<TrivanoShell> {
  double _shelterKg = 1.35; // Dyneema Tent + Stakes
  double _sleepKg = 1.20;   // Down Quilt + Insulated Pad
  double _cookKg = 0.45;    // Titanium pot + stove
  double _clothesKg = 1.10; // Puffy + rain shell + thermals

  final List<Map<String, dynamic>> _checklist = [
    {'item': 'Ultralight Dyneema 1P Tent', 'weight': '680 g', 'checked': true},
    {'item': 'Carbon Fiber Tent Stakes x8', 'weight': '72 g', 'checked': true},
    {'item': '850 FP Down Quilt (20°F)', 'weight': '620 g', 'checked': true},
    {'item': 'R-value 4.5 Sleeping Pad', 'weight': '430 g', 'checked': true},
    {'item': '550ml Titanium Pot & Lid', 'weight': '85 g', 'checked': true},
    {'item': 'Micro Canister Stove', 'weight': '45 g', 'checked': true},
    {'item': 'Water Filter & Squeeze Pouch', 'weight': '85 g', 'checked': false},
    {'item': 'Headlamp (USB-C Rechargeable)', 'weight': '55 g', 'checked': true},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TRIVANO PACK WEIGHT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: TrivanoTheme.ink,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: TrivanoTheme.accent,
            unselectedLabelColor: TrivanoTheme.muted,
            indicatorColor: TrivanoTheme.accent,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: [
              Tab(text: 'Base Weight'),
              Tab(text: 'Category Breakdown'),
              Tab(text: 'Classification'),
              Tab(text: 'Gear Checklist'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBaseWeightTab(),
            _buildCategoriesTab(),
            _buildClassificationTab(),
            _buildChecklistTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildBaseWeightTab() {
    final totalBaseKg = _shelterKg + _sleepKg + _cookKg + _clothesKg;
    final totalLbs = totalBaseKg * 2.20462;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pack Base Weight Tiers',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TrivanoTheme.ink),
                      ),
                      Text(
                        '${totalBaseKg.toStringAsFixed(2)} kg',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TrivanoTheme.accent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: CustomPaint(
                      painter: BackpackWeightPainter(
                        shelterKg: _shelterKg,
                        sleepKg: _sleepKg,
                        cookKg: _cookKg,
                        clothesKg: _clothesKg,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${totalBaseKg.toStringAsFixed(2)} KG',
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: TrivanoTheme.ink),
                            ),
                            Text(
                              '(${totalLbs.toStringAsFixed(1)} LBS)',
                              style: const TextStyle(fontSize: 13, color: TrivanoTheme.muted, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sliders card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Adjust Category Loads', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 12),
                  _buildSliderRow('Shelter & Tent', _shelterKg, 0.5, 3.5, TrivanoTheme.accent, (v) => setState(() => _shelterKg = v)),
                  _buildSliderRow('Sleep System', _sleepKg, 0.5, 3.0, TrivanoTheme.accentLight, (v) => setState(() => _sleepKg = v)),
                  _buildSliderRow('Cook & Kitchen', _cookKg, 0.1, 2.0, const Color(0xFFF59E0B), (v) => setState(() => _cookKg = v)),
                  _buildSliderRow('Packed Clothing', _clothesKg, 0.2, 3.0, const Color(0xFF38BDF8), (v) => setState(() => _clothesKg = v)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow(String label, double val, double min, double max, Color c, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            Text('${val.toStringAsFixed(2)} kg', style: TextStyle(fontWeight: FontWeight.bold, color: c)),
          ],
        ),
        Slider(
          value: val,
          min: min,
          max: max,
          activeColor: c,
          inactiveColor: TrivanoTheme.edge,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCategoriesTab() {
    final total = _shelterKg + _sleepKg + _cookKg + _clothesKg;
    final items = [
      {'name': 'Shelter & Tent System', 'weight': _shelterKg, 'color': TrivanoTheme.accent},
      {'name': 'Sleep System (Quilt & Pad)', 'weight': _sleepKg, 'color': TrivanoTheme.accentLight},
      {'name': 'Cookware & Hydration Gear', 'weight': _cookKg, 'color': const Color(0xFFF59E0B)},
      {'name': 'Spare / Thermal Clothing', 'weight': _clothesKg, 'color': const Color(0xFF38BDF8)},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final item = items[i];
        final w = item['weight'] as double;
        final c = item['color'] as Color;
        final pct = total > 0 ? (w / total * 100).toStringAsFixed(1) : '0';

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('$pct %', style: TextStyle(fontWeight: FontWeight.bold, color: c)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: total > 0 ? w / total : 0.0,
                  backgroundColor: TrivanoTheme.edge,
                  color: c,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: 8),
                Text('Category Weight: ${w.toStringAsFixed(2)} kg (${(w * 1000).toStringAsFixed(0)} g)', style: const TextStyle(fontSize: 12, color: TrivanoTheme.muted)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassificationTab() {
    final totalKg = _shelterKg + _sleepKg + _cookKg + _clothesKg;
    final categories = [
      {'title': 'Super-Ultralight (SUL)', 'range': '< 2.3 kg (< 5 lbs)', 'desc': 'Minimalist tarp bivvy, sub-freezing discipline.'},
      {'title': 'Ultralight (UL)', 'range': '2.3 - 4.5 kg (5 - 10 lbs)', 'desc': 'Sweet spot of comfort, durability, and high daily trail mileage.'},
      {'title': 'Lightweight', 'range': '4.5 - 9.0 kg (10 - 20 lbs)', 'desc': 'Standard modern trail comfort with freestanding double-wall tent.'},
      {'title': 'Traditional Backpacking', 'range': '> 9.0 kg (> 20 lbs)', 'desc': 'Heavy-duty framed packs, multi-pot cooking setups.'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final cat = categories[i];
        final isCurrent = (i == 0 && totalKg < 2.3) ||
            (i == 1 && totalKg >= 2.3 && totalKg <= 4.5) ||
            (i == 2 && totalKg > 4.5 && totalKg <= 9.0) ||
            (i == 3 && totalKg > 9.0);

        return Card(
          color: isCurrent ? TrivanoTheme.accent.withValues(alpha: 0.15) : TrivanoTheme.surface,
          child: ListTile(
            leading: Icon(
              isCurrent ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: isCurrent ? TrivanoTheme.accent : TrivanoTheme.muted,
            ),
            title: Text(cat['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat['range']!, style: const TextStyle(fontSize: 12, color: TrivanoTheme.accentLight, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(cat['desc']!, style: const TextStyle(fontSize: 12, color: TrivanoTheme.muted)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChecklistTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _checklist.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final item = _checklist[i];
        final checked = item['checked'] as bool;
        return Card(
          child: CheckboxListTile(
            value: checked,
            activeColor: TrivanoTheme.accent,
            checkColor: Colors.black,
            title: Text(
              item['item'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                decoration: checked ? TextDecoration.lineThrough : null,
                color: checked ? TrivanoTheme.muted : TrivanoTheme.ink,
              ),
            ),
            subtitle: Text(item['weight'] as String, style: const TextStyle(fontSize: 11, color: TrivanoTheme.accentLight)),
            onChanged: (v) => setState(() => item['checked'] = v ?? false),
          ),
        );
      },
    );
  }
}

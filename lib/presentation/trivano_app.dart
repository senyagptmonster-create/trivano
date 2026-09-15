import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/gear_inventory_repository.dart';
import 'trivano_palette.dart';
import 'pages/gear_inventory_page.dart';
import 'pages/category_breakdown_page.dart';
import 'pages/pack_target_page.dart';
import 'pages/trip_checklist_page.dart';

class TrivanoApp extends StatelessWidget {
  const TrivanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GearInventoryRepository(),
      child: MaterialApp(
        title: 'Trivano Ultralight Pack',
        theme: TrivanoPalette.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const TrivanoHomeScaffold(),
      ),
    );
  }
}

class TrivanoHomeScaffold extends StatefulWidget {
  const TrivanoHomeScaffold({super.key});

  @override
  State<TrivanoHomeScaffold> createState() => _TrivanoHomeScaffoldState();
}

class _TrivanoHomeScaffoldState extends State<TrivanoHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Gear Inventory', 'Category Breakdown', 'Base Weight Target', 'Pre-Trip Checklist'];
  final _pages = const [
    GearInventoryPage(),
    CategoryBreakdownPage(),
    PackTargetPage(),
    TripChecklistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.backpack_outlined), selectedIcon: Icon(Icons.backpack), label: 'Gear'),
          NavigationDestination(icon: Icon(Icons.pie_chart_outline), selectedIcon: Icon(Icons.pie_chart), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.speed_outlined), selectedIcon: Icon(Icons.speed), label: 'Target'),
          NavigationDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: 'Checklist'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'trivano_store.dart';

class TrivanoHome extends StatefulWidget {
  const TrivanoHome({super.key});
  @override
  _TrivanoHomeState createState() => _TrivanoHomeState();
}

class _TrivanoHomeState extends State<TrivanoHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const GearInventoryScreen(),
    const CategoryWeightScreen(),
    const PackTargetScreen(),
    const ChecklistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trivano', style: AppTheme.display(context))),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) { setState(() { _currentIndex = index; }); },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Gear List'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Category Pie'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Pack Targets'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Checklist'),
        ],
        selectedItemColor: cAccent,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class GearInventoryScreen extends StatelessWidget {
  const GearInventoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<TrivanoStore>();
    return ListView.builder(
      itemCount: store.items.length,
      itemBuilder: (context, index) {
        final item = store.items[index];
        return ListTile(
          title: Text(item['name'], style: AppTheme.text(context)),
          trailing: Text('${item['weight']}g', style: AppTheme.text(context)),
        );
      },
    );
  }
}

class CategoryWeightScreen extends StatelessWidget {
  const CategoryWeightScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Category Weight Breakdown', style: AppTheme.display(context)));
}

class PackTargetScreen extends StatelessWidget {
  const PackTargetScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Ultralight Pack Target', style: AppTheme.display(context)));
}

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Trip Checklist', style: AppTheme.display(context)));
}

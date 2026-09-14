import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens.dart';
import 'trivano_store.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrivanoStore(),
      child: MaterialApp(
        title: 'Trivano',
        home: const TrivanoHome(),
      ),
    );
  }
}

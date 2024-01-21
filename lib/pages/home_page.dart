import 'package:flutter/material.dart';
import 'package:formato/config/database/db.dart';
import 'package:formato/pages/escola/escolas_page.dart';
import 'package:formato/pages/produto/produtos_page.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  final int currentPageIndex;

  const HomePage({super.key, required this.currentPageIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.currentPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const ProdutosPage(),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Database db = await DB.instance.database;
                    await db.execute('DELETE FROM escola');
                    await db.execute('DELETE FROM produto');
                  },
                  child: const Text('Reset Banco'),
                ),
              ],
            ),
          ),
        ),
        const EscolasPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.inventory),
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Produtos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu),
            icon: Icon(Icons.menu_outlined),
            label: 'Menu',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Escolas',
          ),
        ],
      ),
    );
  }
}

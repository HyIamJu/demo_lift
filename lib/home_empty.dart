import 'package:flutter/material.dart';

class HomeEmptyView extends StatefulWidget {
  const HomeEmptyView({super.key});

  @override
  State<HomeEmptyView> createState() => _HomeEmptyViewState();
}

class _HomeEmptyViewState extends State<HomeEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("HALO BROW OMEn")],
          ),
        ),
      ),
    );
  }
}

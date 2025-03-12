import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_model.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<CounterModel>(context).currentIndex;
    return Scaffold(
      body: currentIndex == 0 ? const ColorTapsScreen() : const StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => Provider.of<CounterModel>(context, listen: false).updateIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(type: CardType.red, tapCount: counter.redTapCount, onTap: counter.incrementRedTap),
          ColorTap(type: CardType.blue, tapCount: counter.blueTapCount, onTap: counter.incrementBlueTap),
        ],
      ),
    );
  }
}

enum CardType { red, blue }

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Red Taps: ${counter.redTapCount}', style: const TextStyle(fontSize: 24)),
            Text('Blue Taps: ${counter.blueTapCount}', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

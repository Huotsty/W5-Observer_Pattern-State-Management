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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    print('home screen is built');
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen()
              : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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
    print('color taps screen is built');
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: [
          Selector<CounterModel, int>(
            selector: (context, counter) => counter.redTapCount,
            builder: (context, redTapCount, child) {
              return ColorTap(
                type: CardType.red,
                tapCount: redTapCount,
                onTap: context.read<CounterModel>().incrementRedTap,
              );
            },
          ),
          Selector<CounterModel, int>(
            selector: (context, counter) => counter.blueTapCount,
            builder: (context, blueTapCount, child) {
              return ColorTap(
                type: CardType.blue,
                tapCount: blueTapCount,
                onTap: context.read<CounterModel>().incrementBlueTap,
              );
            },
          ),
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
    print('StatisticsScreen rebuilt');
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${counter.redTapCount}', style: const TextStyle(fontSize: 24)),
                Text('Blue Taps: ${counter.blueTapCount}', style: const TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}

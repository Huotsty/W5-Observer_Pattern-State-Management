import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterModel extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;
  int _currentIndex = 0; // ✅ Now managed in CounterModel

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;
  int get currentIndex => _currentIndex; // ✅ Getter for currentIndex

  void incrementRedTap() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementBlueTap() {
    _blueTapCount++;
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MyApp(),
    ),
  );
}

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

// ✅ Home is now Stateless
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    print('Home screen is built');

    int currentIndex = context.watch<CounterModel>().currentIndex;

    return Scaffold(
      body: currentIndex == 0 ? const ColorTapsScreen() : const StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.read<CounterModel>().updateIndex(index),
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
    print('ColorTapsScreen is built');

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
    print('ColorTap is built');

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
    print('StatisticsScreen is built');

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

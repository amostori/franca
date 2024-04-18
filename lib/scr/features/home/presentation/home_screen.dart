import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:france_edukacy/scr/features/home/presentation/widgets/custom_paint.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import '../../../utils/routing/routing.dart';
import '../provider/word_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final offsets = <Offset?>[];
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider);
    final delay = ref.watch(delayProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Czas: $delay s'),
        actions: [
          IconButton(
              onPressed: () {
                context.goNamed(AppRoute.wordList.name);
              },
              icon: const Icon(Icons.list)),
          IconButton(
              onPressed: () {
                setState(() {
                  offsets.clear();
                });
              },
              icon: const Icon(Icons.cleaning_services)),
          // IconButton(
          //     onPressed: () {
          //       _showAlertDialog(context, ref);
          //     },
          //     icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                context.goNamed(AppRoute.adding.name);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(wordProvider.notifier).showWord();
          setState(() {
            offsets.clear();
          });
        },
        child: const Icon(Icons.navigate_next),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  word.polishWord,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 50.0,
                ),
                word.frenchWord == Constants.progressIndicator
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator())
                    : SizedBox(
                        height: 20,
                        width: double.infinity,
                        child: Text(
                          word.frenchWord,
                          textAlign: TextAlign.center,
                        )),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.black38,
            width: double.infinity,
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onPanDown: (details) {
                setState(() {
                  offsets.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  offsets.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  offsets.add(null);
                });
              },
              child: CustomPaint(
                painter: MyPainter(offsets: offsets),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _showAlertDialog(BuildContext context, WidgetRef ref) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Kasowanie wszystkiego'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Jesteś pewien, że chcesz wymazać wszystko?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Anuluj'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Tak'),
  //             onPressed: () {
  //               ref.read(wordProvider.notifier).clearAll();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

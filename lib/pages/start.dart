import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jinro_web/pages/game.dart';
import 'package:jinro_web/providers/game.dart';

class StartApp extends ConsumerWidget {
  StartApp({Key? key}) : super(key: key);

  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(gameProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('ワンナイト人狼')),
      body: Center(
        child: Column(
          children: [
            Column(
              children: createPlayerWidgets(),
            ),
            MaterialButton(
              onPressed: () => {start(context, provider)},
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: const Text('スタート！'),
            ),
          ],
        ),
      ),
    );
  }

  void start(BuildContext context, Game provider) {
    provider.controllers = controllers;
    provider.shufflePositions();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameApp(),
      ),
    );
  }

  List<Widget> createPlayerWidgets() {
    final players = <Widget>[];
    for (var i = 0; i < 4; i++) {
      players.add(
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: controllers[i],
            decoration: const InputDecoration(
              hintText: '参加者の名前',
            ),
          ),
        ),
      );
    }
    return players;
  }
}

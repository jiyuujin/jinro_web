import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jinro_web/providers/game.dart';

class GameApp extends ConsumerWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('役職')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                getMasterText(provider, ref),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: createButton(provider, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(Game provider, WidgetRef ref) {
    final count = ref.watch(gameProvider);

    if (count / 2 >= ref.read(gameProvider.notifier).controllers.length - 1) {
      return Container();
    } else {
      return MaterialButton(
        onPressed: () => {ref.read(gameProvider.notifier).increment()},
        color: Colors.blueAccent,
        textColor: Colors.white,
        child: const Text('Yes'),
      );
    }
  }

  String getMasterText(Game provider, WidgetRef ref) {
    final count = ref.watch(gameProvider);

    if (count / 2 >= ref.read(gameProvider.notifier).controllers.length - 1) {
      return 'ゲームスタート';
    } else if (count.isEven) {
      final num = (count / 2).floor();
      return 'あなたは${ref.read(gameProvider.notifier).controllers[num].text}ですか';
    } else {
      final num = (count / 2).floor();
      return 'あなたの役職は${ref.read(gameProvider.notifier).positions[num]}です';
    }
  }
}

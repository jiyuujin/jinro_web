import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jinro_web/providers/game.dart';

class GameApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('役職')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                getMasterText(provider, ref),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: createButton(provider, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(Game provider, WidgetRef ref) {
    Widget button;
    int count = ref.watch(gameProvider);

    if (count / 2 >= ref.read(gameProvider.notifier).controllers.length - 1) {
      button = Container();
      return button;
    } else {
      button = MaterialButton(
        onPressed: () => {ref.read(gameProvider.notifier).increment()},
        child: Text('Yes'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
      return button;
    }
  }

  String getMasterText(Game provider, WidgetRef ref) {
    String text = '';
    int count = ref.watch(gameProvider);

    if (count / 2 >= ref.read(gameProvider.notifier).controllers.length - 1) {
      text = 'ゲームスタート';
      return text;
    } else if (count % 2 == 0) {
      int num = (count / 2).floor();
      text = 'あなたは' +
          ref.read(gameProvider.notifier).controllers[num].text +
          'ですか';
      return text;
    } else {
      int num = (count / 2).floor();
      text = 'あなたの役職は' + ref.read(gameProvider.notifier).positions[num] + 'です';
      return text;
    }
  }
}

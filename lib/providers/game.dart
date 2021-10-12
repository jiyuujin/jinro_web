import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final gameProvider = StateNotifierProvider<Game, int>((_) => Game());

class Game extends StateNotifier<int> {
  Game() : super(0);

  late List<TextEditingController> controllers;

  final List<String> _positions = ['村人', '村人', '人狼', '人狼', '占い師', 'てるてる'];
  List<String> get positions => _positions;

  void shufflePositions() {
    _positions.shuffle();
  }

  void increment() {
    state++;
  }
}

import 'package:frontend/models/poker_card.dart';

class PokerDeck {
  static final List<String> ranks = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    'jack',
    'queen',
    'king',
    'ace'
  ];
  static final List<String> suits = ['clubs', 'diamonds', 'hearts', 'spades'];

  static List<PokerCard> getDeck() {
    return [
      for (var rank in ranks)
        for (var suit in suits) PokerCard(rank: rank, suit: suit)
    ];
  }
}

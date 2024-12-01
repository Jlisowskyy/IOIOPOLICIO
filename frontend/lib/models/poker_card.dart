class PokerCard {
  final String rank;
  final String suit;
  final String assetPath;

  PokerCard({required this.rank, required this.suit})
      : assetPath = 'assets/images/playing_cards/${rank}_of_${suit}.svg';

  @override
  String toString() => '$rank of $suit';
}

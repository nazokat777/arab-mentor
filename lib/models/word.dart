enum WordType { noun, verb, particle, adjective, pronoun }

class Word {
  final String arabic;
  final String transliteration;
  final String uzbek;
  final WordType type;
  final String? plural;
  final String? root;
  final String? exampleSentence;
  final String? exampleTranslation;

  const Word({
    required this.arabic,
    required this.transliteration,
    required this.uzbek,
    required this.type,
    this.plural,
    this.root,
    this.exampleSentence,
    this.exampleTranslation,
  });

  String get typeUzbek {
    switch (type) {
      case WordType.noun:
        return 'Ism (اسم)';
      case WordType.verb:
        return 'Fe\'l (فعل)';
      case WordType.particle:
        return 'Harf (حرف)';
      case WordType.adjective:
        return 'Sifat (صفة)';
      case WordType.pronoun:
        return 'Zamir (ضمير)';
    }
  }
}

import 'word.dart';

enum LessonCategory { nahv, sarf, tarkib, vocabulary }

class Lesson {
  final String id;
  final String title;
  final String arabicTitle;
  final String description;
  final LessonCategory category;
  final int level;
  final String theory;
  final List<Example> examples;
  final List<Word> vocabulary;
  final List<Quiz> quizzes;
  final String source;

  const Lesson({
    required this.id,
    required this.title,
    required this.arabicTitle,
    required this.description,
    required this.category,
    required this.level,
    required this.theory,
    required this.examples,
    required this.vocabulary,
    required this.quizzes,
    required this.source,
  });
}

class Example {
  final String arabic;
  final String transliteration;
  final String translation;
  final String? grammarNote;

  const Example({
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.grammarNote,
  });
}

class Quiz {
  final String question;
  final String? arabicSentence;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final QuizType type;

  const Quiz({
    required this.question,
    this.arabicSentence,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.type = QuizType.multipleChoice,
  });
}

enum QuizType { multipleChoice, fillBlank, wordMatch, sentenceBuilder, irab }

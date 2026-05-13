import '../models/lesson.dart';
import '../models/word.dart';
import 'vocabulary.dart';

class LessonsData {
  static final List<Lesson> allLessons = [
    Lesson(
      id: 'nahv_01',
      title: 'Kalom va Kalima',
      arabicTitle: 'الكَلَامُ وَالكَلِمَةُ',
      description: 'Arab tilida so\'z va gap nima ekanligi haqida birinchi dars',
      category: LessonCategory.nahv,
      level: 1,
      source: 'S. Bekpo\'lat — Mabdaun Nahv',
      theory: '''
Arab tilida **Kalima (الكَلِمَة)** — bu ma'noli bitta so'z.

Kalima 3 qismga bo'linadi:

1. **Ism (الاِسْم)** — narsa, shaxs, joy, sifat nomi
   Misol: كِتَابٌ (kitob), بَيْتٌ (uy)

2. **Fe'l (الفِعْل)** — ish-harakat
   Misol: كَتَبَ (yozdi), قَرَأَ (o'qidi)

3. **Harf (الحَرْف)** — yordamchi so'zlar
   Misol: فِي (-da), مِنْ (-dan)

**Kalom (الكَلَامُ)** — bu to\'liq ma'noli gap. Eng kamida 2 kalimadan tuziladi.

Misol: **الكِتَابُ جَدِيدٌ** — "Kitob yangi"
''',
      examples: [
        Example(
          arabic: 'كِتَابٌ',
          transliteration: 'kitābun',
          translation: 'kitob',
          grammarNote: 'Ism — narsa nomi',
        ),
        Example(
          arabic: 'كَتَبَ',
          transliteration: 'kataba',
          translation: 'yozdi',
          grammarNote: 'Fe\'l — o\'tgan zamon',
        ),
        Example(
          arabic: 'فِي البَيْتِ',
          transliteration: 'fī al-bayti',
          translation: 'uyda',
          grammarNote: 'Harf "فِي" + Ism "البَيْت"',
        ),
        Example(
          arabic: 'الطَّالِبُ مُجْتَهِدٌ',
          transliteration: 'aṭ-ṭālibu mujtahidun',
          translation: 'Talaba tirishqoq',
          grammarNote: 'To\'liq Kalom (gap)',
        ),
      ],
      vocabulary: Vocabulary.beginnerWords.take(8).toList(),
      quizzes: const [
        Quiz(
          question: 'Quyidagilardan qaysi biri "Ism" (اسم) hisoblanadi?',
          options: ['كَتَبَ', 'كِتَابٌ', 'فِي', 'مِنْ'],
          correctIndex: 1,
          explanation:
              'كِتَابٌ (kitob) — bu narsa nomi, demak Ism. كَتَبَ — Fe\'l, فِي va مِنْ — Harf.',
        ),
        Quiz(
          question: 'Kalima necha qismga bo\'linadi?',
          options: ['2 ga', '3 ga', '4 ga', '5 ga'],
          correctIndex: 1,
          explanation: 'Kalima 3 qismga bo\'linadi: Ism, Fe\'l, Harf.',
        ),
        Quiz(
          question: '"ذَهَبَ" so\'zi qaysi turga kiradi?',
          options: ['Ism', 'Fe\'l', 'Harf', 'Sifat'],
          correctIndex: 1,
          explanation: 'ذَهَبَ (bordi) — bu ish-harakat, demak Fe\'l.',
        ),
        Quiz(
          question: 'Kalom (gap) nima?',
          options: [
            'Bitta so\'z',
            'Ma\'nosiz so\'zlar yig\'indisi',
            'To\'liq ma\'noli gap (2+ kalimadan)',
            'Faqat fe\'l',
          ],
          correctIndex: 2,
          explanation:
              'Kalom — kamida 2 ta kalimadan iborat to\'liq ma\'no beruvchi gap.',
        ),
      ],
    ),
    Lesson(
      id: 'nahv_02',
      title: 'Mubtado va Xabar',
      arabicTitle: 'المُبْتَدَأُ وَالخَبَرُ',
      description: 'Ismli gapning ikki asosiy bo\'lagi',
      category: LessonCategory.nahv,
      level: 2,
      source: 'S. Bekpo\'lat — Mabdaun Nahv',
      theory: '''
**Ismli gap (الجُمْلَةُ الاِسْمِيَّةُ)** — Ismdan boshlangan gap.

U 2 asosiy bo\'lakdan tashkil topadi:

🟢 **Mubtado (المُبْتَدَأ)** — gap egasi, ya'ni kim/nima haqida gap ketmoqda
   - Doim **marfu'** (دَمَّةٌ — ـُ) bo\'ladi
   - Odatda gap boshida keladi
   - Aniq (ma'rifa) bo\'ladi: ال bilan

🟡 **Xabar (الخَبَر)** — Mubtado haqida xabar
   - U ham **marfu'** bo\'ladi
   - Mubtadodan keyin keladi
   - Noaniq (nakira) bo\'ladi

**Misol:**
الكِتَابُ ← Mubtado (kitob)
جَدِيدٌ ← Xabar (yangi)

**الكِتَابُ جَدِيدٌ** = "Kitob yangi"

💡 *Asosiy qoida:* Mubtado va Xabar **jins** va **son**da mos kelishi kerak.
''',
      examples: [
        Example(
          arabic: 'البَيْتُ كَبِيرٌ',
          transliteration: 'al-baytu kabīrun',
          translation: 'Uy katta',
          grammarNote: 'البَيْتُ — Mubtado, كَبِيرٌ — Xabar',
        ),
        Example(
          arabic: 'الطَّالِبُ مُجْتَهِدٌ',
          transliteration: 'aṭ-ṭālibu mujtahidun',
          translation: 'Talaba tirishqoq',
          grammarNote: 'الطَّالِبُ — Mubtado, مُجْتَهِدٌ — Xabar',
        ),
        Example(
          arabic: 'القَلَمُ جَدِيدٌ',
          transliteration: 'al-qalamu jadīdun',
          translation: 'Qalam yangi',
        ),
        Example(
          arabic: 'المُعَلِّمَةُ جَمِيلَةٌ',
          transliteration: 'al-muʿallimatu jamīlatun',
          translation: 'O\'qituvchi (ayol) chiroyli',
          grammarNote: 'Jinsi mos: ikkalasi ham muannas (ayol jinsi)',
        ),
      ],
      vocabulary: Vocabulary.beginnerWords.where((w) => w.type == WordType.adjective).toList(),
      quizzes: const [
        Quiz(
          question: '"البَيْتُ كَبِيرٌ" gapida Mubtado qaysi?',
          arabicSentence: 'البَيْتُ كَبِيرٌ',
          options: ['البَيْتُ', 'كَبِيرٌ', 'ikkalasi', 'hech qaysi'],
          correctIndex: 0,
          explanation:
              'البَيْتُ — gap egasi, ya'ni kim haqida gap ketmoqda. Bu Mubtado.',
        ),
        Quiz(
          question: 'Mubtado qanday harakat bilan keladi?',
          options: ['Fatha (ـَ)', 'Kasra (ـِ)', 'Damma (ـُ)', 'Sukun (ـْ)'],
          correctIndex: 2,
          explanation:
              'Mubtado doim marfu\' bo\'ladi, ya\'ni damma (ـُ) bilan o\'qiladi.',
        ),
        Quiz(
          question: '"القَلَمُ ___" — Xabarni to\'g\'ri tanlang',
          options: ['جَدِيدٌ', 'جَدِيدَةٌ', 'جَدِيدِينَ', 'جَدِيدًا'],
          correctIndex: 0,
          explanation:
              'القَلَم — muzakkar (erkak jinsi), shuning uchun Xabar ham muzakkar shaklda — جَدِيدٌ.',
        ),
      ],
    ),
    Lesson(
      id: 'sarf_01',
      title: 'Muzakkar va Muannas',
      arabicTitle: 'المُذَكَّرُ وَالمُؤَنَّثُ',
      description: 'Arab tilidagi jins kategoriyalari',
      category: LessonCategory.sarf,
      level: 1,
      source: 'D. N. Bodariy — Mukammal Sarf',
      theory: '''
Arab tilida har bir ism **2 jinsdan biriga** kiradi:

🔵 **Muzakkar (المُذَكَّر)** — erkak jinsi
   - Maxsus belgisi yo'q
   - Misol: كِتَابٌ, بَيْتٌ, قَلَمٌ

🔴 **Muannas (المُؤَنَّث)** — ayol jinsi
   - Odatda **ة (ta marbuta)** bilan tugaydi
   - Misol: مَدْرَسَةٌ, مُعَلِّمَةٌ, طَالِبَةٌ

**Muannasning 3 belgisi:**

1. **ة (ta marbuta):** مُعَلِّمَة (o'qituvchi ayol)
2. **ـَى (alif maqsura):** ذِكْرَى (xotira)
3. **ـَاء (alif mamdude):** صَحْرَاء (sahro)

💡 *Diqqat:* Ba'zi so'zlar **belgisiz muannas** bo'ladi:
- أُمٌّ (ona), شَمْسٌ (quyosh), يَدٌ (qo'l), أَرْضٌ (yer)
''',
      examples: [
        Example(
          arabic: 'طَالِبٌ — طَالِبَةٌ',
          transliteration: 'ṭālib — ṭāliba',
          translation: 'talaba (erkak) — talaba (ayol)',
        ),
        Example(
          arabic: 'مُعَلِّمٌ — مُعَلِّمَةٌ',
          transliteration: 'muʿallim — muʿallima',
          translation: 'o\'qituvchi (er.) — o\'qituvchi (ay.)',
        ),
        Example(
          arabic: 'كَبِيرٌ — كَبِيرَةٌ',
          transliteration: 'kabīr — kabīra',
          translation: 'katta (er.) — katta (ay.)',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"مَدْرَسَةٌ" qaysi jinsda?',
          options: ['Muzakkar', 'Muannas', 'Ikkalasi', 'Hech qaysi'],
          correctIndex: 1,
          explanation: 'ة (ta marbuta) bilan tugaganligi uchun — Muannas.',
        ),
        Quiz(
          question: '"بَيْتٌ" qaysi jinsda?',
          options: ['Muzakkar', 'Muannas', 'Aniq emas', 'Ikkalasi'],
          correctIndex: 0,
          explanation: 'بَيْتٌ — muzakkar (erkak jinsi). Belgisi yo\'q.',
        ),
        Quiz(
          question: '"شَمْسٌ" qaysi jinsda?',
          options: ['Muzakkar', 'Muannas (belgisiz)', 'Ikkalasi', 'Hech qaysi'],
          correctIndex: 1,
          explanation:
              'شَمْسٌ — belgisiz muannas. Ta marbuta yo\'q, lekin baribir muannas.',
        ),
      ],
    ),
    Lesson(
      id: 'sarf_02',
      title: 'Mufrad, Musanno, Jam\'',
      arabicTitle: 'المُفْرَدُ وَالمُثَنَّى وَالجَمْعُ',
      description: 'Son bo\'yicha ismlarning shakli',
      category: LessonCategory.sarf,
      level: 2,
      source: 'D. N. Bodariy — Mukammal Sarf',
      theory: '''
Arab tilida ism son jihatidan **3 ga bo\'linadi**:

1️⃣ **Mufrad (المُفْرَد)** — birlik
   - 1 ta narsani bildiradi
   - Misol: كِتَابٌ (1 ta kitob)

2️⃣ **Musanno (المُثَنَّى)** — ikkilik
   - 2 ta narsani bildiradi
   - Birlikga **ـَانِ** yoki **ـَيْنِ** qo\'shiladi
   - Misol: كِتَابَانِ (2 ta kitob)

3️⃣ **Jam\' (الجَمْع)** — ko\'plik
   - 3 va undan ko\'p
   - 3 turi bor:
     a) **Jam\' muzakkar solim:** ـُونَ qo\'shiladi
        مُعَلِّمُونَ (o\'qituvchilar)
     b) **Jam\' muannas solim:** ـَاتٌ qo\'shiladi
        مُعَلِّمَاتٌ (o\'qituvchilar ay.)
     c) **Jam\' taksir** (siniq ko\'plik) — shakli o\'zgaradi
        كِتَابٌ → كُتُبٌ
        بَيْتٌ → بُيُوتٌ
''',
      examples: [
        Example(
          arabic: 'قَلَمٌ → قَلَمَانِ → أَقْلَامٌ',
          transliteration: 'qalam → qalamāni → aqlām',
          translation: 'qalam → 2 qalam → qalamlar',
        ),
        Example(
          arabic: 'طَالِبٌ → طَالِبَانِ → طُلَّابٌ',
          transliteration: 'ṭālib → ṭālibāni → ṭullāb',
          translation: 'talaba → 2 talaba → talabalar',
        ),
        Example(
          arabic: 'مُعَلِّمَةٌ → مُعَلِّمَتَانِ → مُعَلِّمَاتٌ',
          transliteration: 'muʿallima → muʿallimatāni → muʿallimāt',
          translation: 'o\'qituvchi → 2 o\'qituvchi → o\'qituvchilar',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"كِتَابَانِ" qaysi son shaklida?',
          options: ['Mufrad', 'Musanno', 'Jam\'', 'Hech qaysi'],
          correctIndex: 1,
          explanation: 'ـَانِ qo\'shimchasi — Musanno (ikkilik) belgisi.',
        ),
        Quiz(
          question: '"كُتُبٌ" qaysi turdagi ko\'plik?',
          options: [
            'Jam\' muzakkar solim',
            'Jam\' muannas solim',
            'Jam\' taksir',
            'Musanno',
          ],
          correctIndex: 2,
          explanation:
              'كِتَابٌ → كُتُبٌ shakli o\'zgargan, demak — Jam\' taksir.',
        ),
      ],
    ),
    Lesson(
      id: 'tarkib_01',
      title: 'Gap turlari: Ismli va Fe\'lli',
      arabicTitle: 'الجُمْلَةُ الاِسْمِيَّةُ وَالفِعْلِيَّةُ',
      description: 'Arab tilidagi 2 asosiy gap turi',
      category: LessonCategory.tarkib,
      level: 2,
      source: 'TIU — Tarkib qoidalari',
      theory: '''
Arab tilida gap **2 turga** bo\'linadi:

📘 **1. Ismli gap (الجُمْلَةُ الاِسْمِيَّةُ)**
   - **Ism**dan boshlanadi
   - Tarkibi: Mubtado + Xabar
   - Misol: الكِتَابُ جَدِيدٌ (Kitob yangi)

📗 **2. Fe\'lli gap (الجُمْلَةُ الفِعْلِيَّةُ)**
   - **Fe\'l**dan boshlanadi
   - Tarkibi: Fe\'l + Foil (+ Maf\'ul bih)
   - Misol: كَتَبَ الطَّالِبُ الدَّرْسَ
            (Talaba darsni yozdi)

**Fe\'lli gap bo\'laklari:**

🔹 **Fe\'l (الفِعْل)** — ish-harakat
🔹 **Foil (الفَاعِل)** — ish bajaruvchi (kim?) — **marfu\'**
🔹 **Maf\'ul bih (المَفْعُولُ بِهِ)** — ish ob\'ekti (nimani?) — **mansub**

**Tahlil namunasi:**
كَتَبَ ← Fe\'l (yozdi)
الطَّالِبُ ← Foil (talaba — marfu\')
الدَّرْسَ ← Maf\'ul bih (darsni — mansub)
''',
      examples: [
        Example(
          arabic: 'قَرَأَ المُعَلِّمُ الكِتَابَ',
          transliteration: 'qaraʾa al-muʿallimu al-kitāba',
          translation: 'O\'qituvchi kitobni o\'qidi',
          grammarNote: 'Fe\'l + Foil (marfu\') + Maf\'ul bih (mansub)',
        ),
        Example(
          arabic: 'ذَهَبَ الطَّالِبُ إِلَى المَدْرَسَةِ',
          transliteration: 'dhahaba aṭ-ṭālibu ilā al-madrasati',
          translation: 'Talaba maktabga bordi',
        ),
        Example(
          arabic: 'البَيْتُ جَمِيلٌ',
          transliteration: 'al-baytu jamīlun',
          translation: 'Uy chiroyli',
          grammarNote: 'Ismli gap: Mubtado + Xabar',
        ),
      ],
      vocabulary: Vocabulary.beginnerWords.where((w) => w.type == WordType.verb).toList(),
      quizzes: const [
        Quiz(
          question:
              '"كَتَبَ الطَّالِبُ الدَّرْسَ" — bu qaysi turdagi gap?',
          arabicSentence: 'كَتَبَ الطَّالِبُ الدَّرْسَ',
          options: ['Ismli gap', 'Fe\'lli gap', 'Aniq emas', 'Ikkalasi'],
          correctIndex: 1,
          explanation:
              'Fe\'l (كَتَبَ) bilan boshlangan, demak — Fe\'lli gap.',
        ),
        Quiz(
          question: 'Foil (الفَاعِل) qanday harakat bilan keladi?',
          options: ['Marfu\' (ـُ)', 'Mansub (ـَ)', 'Majrur (ـِ)', 'Sukun'],
          correctIndex: 0,
          explanation: 'Foil doim marfu\' bo\'ladi — damma (ـُ) bilan.',
        ),
        Quiz(
          question:
              '"قَرَأَ ___ الكِتَابَ" — Foilni to\'g\'ri shaklda tanlang',
          options: ['الطَّالِبُ', 'الطَّالِبَ', 'الطَّالِبِ', 'طَالِبٍ'],
          correctIndex: 0,
          explanation:
              'Foil marfu\' bo\'lishi kerak: الطَّالِبُ (damma bilan).',
        ),
      ],
    ),
  ];

  static List<Lesson> getByCategory(LessonCategory category) =>
      allLessons.where((l) => l.category == category).toList();
}

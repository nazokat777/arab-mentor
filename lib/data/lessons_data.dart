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
    Lesson(
      id: 'sarf_03',
      title: 'Ma\'rifa va Nakira',
      arabicTitle: 'المَعْرِفَةُ وَالنَّكِرَةُ',
      description: 'Aniq va noaniq ismlar',
      category: LessonCategory.sarf,
      level: 2,
      source: 'D. N. Bodariy — Mukammal Sarf',
      theory: '''
Arab tilida har bir ism **2 holatdan birida** keladi:

🔵 **Ma'rifa (المَعْرِفَة)** — **aniq** ism
   - **الـ (al-)** prefiksi qo'shiladi
   - Tinvin (ـٌ) tushadi
   - Misol: **الكِتَابُ** (bu kitob — aniq)

🔴 **Nakira (النَّكِرَة)** — **noaniq** ism
   - **الـ** yo'q
   - **Tinvin** (ـٌ, ـً, ـٍ) bo'ladi
   - Misol: **كِتَابٌ** (bir kitob — noaniq)

**Ma'rifaning 6 turi:**
1. **Ism** (ism alam): مُحَمَّدٌ
2. **Zamir**: أَنَا, هُوَ
3. **Ishora ismlari**: هَذَا, ذَلِكَ
4. **Mavsul**: الَّذِي, الَّتِي
5. **Al + ism**: الكِتَابُ
6. **Izafat** (idafa): كِتَابُ الطَّالِبِ

💡 *Asosiy farq:*
   - **كِتَابٌ** = bir kitob (qaysidir)
   - **الكِتَابُ** = (o'sha) kitob
''',
      examples: [
        Example(
          arabic: 'كِتَابٌ — الكِتَابُ',
          transliteration: 'kitābun — al-kitābu',
          translation: 'bir kitob — (o\'sha) kitob',
        ),
        Example(
          arabic: 'بَيْتٌ — البَيْتُ',
          transliteration: 'baytun — al-baytu',
          translation: 'bir uy — (o\'sha) uy',
        ),
        Example(
          arabic: 'كِتَابُ الطَّالِبِ',
          transliteration: 'kitābu aṭ-ṭālibi',
          translation: 'talabaning kitobi',
          grammarNote: 'Izafat — birinchi so\'z ham ma\'rifa hisoblanadi',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"البَيْتُ" qaysi holatda?',
          options: ['Nakira', 'Ma\'rifa', 'Ikkalasi', 'Aniq emas'],
          correctIndex: 1,
          explanation: 'الـ prefiksi bor — demak ma\'rifa (aniq).',
        ),
        Quiz(
          question: '"قَلَمٌ" — bu qanday ism?',
          options: ['Ma\'rifa', 'Nakira', 'Izafat', 'Zamir'],
          correctIndex: 1,
          explanation: 'Tinvin (ـٌ) bor, الـ yo\'q — nakira (noaniq).',
        ),
        Quiz(
          question: '"هَذَا" qaysi ma\'rifa turiga kiradi?',
          options: ['Zamir', 'Ishora ismi', 'Mavsul', 'Al + ism'],
          correctIndex: 1,
          explanation: 'هَذَا — "bu" ma\'nosini bildiruvchi ishora ismi.',
        ),
      ],
    ),
    Lesson(
      id: 'nahv_03',
      title: 'Izafat (Idafa)',
      arabicTitle: 'الإِضَافَةُ',
      description: 'Egalik aloqasi (kim+kimning)',
      category: LessonCategory.nahv,
      level: 3,
      source: 'S. Bekpo\'lat — Mabdaun Nahv',
      theory: '''
**Izafat (الإِضَافَة)** — ikki ismni birlashtirib egalik aloqasini bildirish.

**Tarkibi:**
🟢 **Muzof (المُضَاف)** — egalik qiluvchi (birinchi ism)
🟡 **Muzof ilayh (المُضَافُ إِلَيْه)** — egalik (ikkinchi ism)

**Qoidalar:**

1. **Muzof:**
   - الـ ham, tinvin ham bo'lmaydi
   - Holatga ko'ra harakatlanadi (marfu', mansub, majrur)

2. **Muzof ilayh:**
   - Doim **majrur** (kasra — ـِ)
   - Ma'rifa yoki nakira bo'lishi mumkin

**Misol:**
**كِتَابُ الطَّالِبِ** = "talabaning kitobi"
- كِتَابُ ← Muzof (marfu')
- الطَّالِبِ ← Muzof ilayh (majrur)

**Eslatma:** Muzof ham **ma'rifa** hisoblanadi, agar Muzof ilayh ma'rifa bo'lsa.
''',
      examples: [
        Example(
          arabic: 'بَيْتُ المُعَلِّمِ',
          transliteration: 'baytu al-muʿallimi',
          translation: 'o\'qituvchining uyi',
          grammarNote: 'بَيْتُ — Muzof, المُعَلِّمِ — Muzof ilayh (majrur)',
        ),
        Example(
          arabic: 'بَابُ المَدْرَسَةِ',
          transliteration: 'bābu al-madrasati',
          translation: 'maktabning eshigi',
        ),
        Example(
          arabic: 'قَلَمُ الطَّالِبِ جَدِيدٌ',
          transliteration: 'qalamu aṭ-ṭālibi jadīdun',
          translation: 'Talabaning qalami yangi',
          grammarNote: 'Izafat + Mubtado, keyin Xabar',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"كِتَابُ المُعَلِّمِ" — bu qaysi tuzilma?',
          arabicSentence: 'كِتَابُ المُعَلِّمِ',
          options: [
            'Mubtado + Xabar',
            'Fe\'l + Foil',
            'Izafat (Muzof + Muzof ilayh)',
            'Sifat + Mavsuf',
          ],
          correctIndex: 2,
          explanation:
              'Ikki ism birlashgan, Muzof ilayh majrur — bu Izafat.',
        ),
        Quiz(
          question: 'Muzof ilayh qaysi holatda bo\'ladi?',
          options: ['Marfu\' (ـُ)', 'Mansub (ـَ)', 'Majrur (ـِ)', 'Sukun'],
          correctIndex: 2,
          explanation: 'Muzof ilayh doim majrur (kasra) bo\'ladi.',
        ),
      ],
    ),
    Lesson(
      id: 'sarf_04',
      title: 'Fe\'l Mozi va Muzore\'',
      arabicTitle: 'الفِعْلُ المَاضِي وَالمُضَارِعُ',
      description: 'O\'tgan va hozirgi/kelasi zamon fe\'llari',
      category: LessonCategory.sarf,
      level: 3,
      source: 'D. N. Bodariy — Mukammal Sarf',
      theory: '''
Arab tilida fe'l **3 zamonga** bo'linadi, lekin asosan 2 tasi:

📘 **1. Fe'l Mozi (الفِعْلُ المَاضِي)** — o'tgan zamon
   - **Allaqachon bo'lib bo'lgan** ish
   - Misol: **كَتَبَ** (yozdi), **قَرَأَ** (o'qidi)

📗 **2. Fe'l Muzore' (الفِعْلُ المُضَارِع)** — hozirgi/kelasi zamon
   - Hozir bo'layotgan yoki kelajakda bo'ladigan ish
   - **يـ, تـ, أ, نـ** harflaridan biri bilan boshlanadi
   - Misol: **يَكْتُبُ** (yozadi), **يَقْرَأُ** (o'qiydi)

**Muzore' boshi harflari (إِنْتَ نَأْتِي):**
- **أَ** — men (مَتَكَلِّم وَحْدَهُ): **أَكْتُبُ** (men yozaman)
- **نَ** — biz (مَعَ الغَيْر): **نَكْتُبُ** (biz yozamiz)
- **تَ** — sen, u (ay.): **تَكْتُبُ**
- **يَ** — u (er.): **يَكْتُبُ**

**Misol jadval:**
| Zamir | Mozi | Muzore' |
|-------|------|---------|
| أَنَا | كَتَبْتُ | أَكْتُبُ |
| نَحْنُ | كَتَبْنَا | نَكْتُبُ |
| أَنْتَ | كَتَبْتَ | تَكْتُبُ |
| هُوَ | كَتَبَ | يَكْتُبُ |
| هِيَ | كَتَبَتْ | تَكْتُبُ |
''',
      examples: [
        Example(
          arabic: 'كَتَبَ الطَّالِبُ',
          transliteration: 'kataba aṭ-ṭālibu',
          translation: 'Talaba yozdi (o\'tgan)',
        ),
        Example(
          arabic: 'يَكْتُبُ الطَّالِبُ',
          transliteration: 'yaktubu aṭ-ṭālibu',
          translation: 'Talaba yozyapti / yozadi (hozir)',
        ),
        Example(
          arabic: 'أَدْرُسُ اللُّغَةَ العَرَبِيَّةَ',
          transliteration: 'adrusu al-lughata al-ʿarabiyyata',
          translation: 'Men arab tilini o\'rganaman',
          grammarNote: 'Muzore\' + أ prefiks = men',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"يَقْرَأُ" qaysi zamon?',
          options: ['Mozi', 'Muzore\'', 'Amr', 'Hech qaysi'],
          correctIndex: 1,
          explanation: 'يَ bilan boshlangan — Muzore\' (hozirgi/kelasi).',
        ),
        Quiz(
          question: '"Men yozaman" arab tilida qanday?',
          options: ['كَتَبْتُ', 'أَكْتُبُ', 'يَكْتُبُ', 'نَكْتُبُ'],
          correctIndex: 1,
          explanation:
              'أَ — men (mutakallim) prefiksi. أَكْتُبُ = men yozaman.',
        ),
        Quiz(
          question: '"كَتَبَتْ" qaysi zamir uchun?',
          options: ['هُوَ (u er.)', 'هِيَ (u ay.)', 'أَنْتَ', 'نَحْنُ'],
          correctIndex: 1,
          explanation: 'تْ qo\'shimchasi — muannas (u ayol kishi).',
        ),
      ],
    ),
    Lesson(
      id: 'tarkib_02',
      title: 'I\'rob darajalari',
      arabicTitle: 'حَرَكَاتُ الإِعْرَابِ',
      description: 'Marfu\', Mansub, Majrur, Majzum',
      category: LessonCategory.tarkib,
      level: 3,
      source: 'TIU — Tarkib qoidalari',
      theory: '''
**I'rob (الإِعْرَاب)** — so'z oxiridagi harakatning gapdagi rolga qarab o'zgarishi.

**4 ta asosiy holat:**

🟢 **1. Marfu' (المَرْفُوع)** — damma (ـُ)
   - **Kim ish bajaradi:** Mubtado, Xabar, Foil
   - Misol: **الطَّالِبُ** (talaba — kim?)

🟡 **2. Mansub (المَنْصُوب)** — fatha (ـَ)
   - **Kim/nimani:** Maf'ul bih (ob'ekt)
   - Misol: **الكِتَابَ** (kitobni — nimani?)

🔴 **3. Majrur (المَجْرُور)** — kasra (ـِ)
   - **Harf jarr bilan** yoki **Muzof ilayh**
   - Misol: **فِي البَيْتِ** (uyda)

⚫ **4. Majzum (المَجْزُوم)** — sukun (ـْ)
   - Faqat **fe'l muzore'**da (لَمْ, لَا nahy)
   - Misol: **لَمْ يَكْتُبْ** (yozmadi)

**Tahlil namunasi:**
> كَتَبَ الطَّالِبُ الدَّرْسَ فِي البَيْتِ

| So'z | Rol | I'rob |
|------|-----|-------|
| كَتَبَ | Fe'l | — |
| الطَّالِبُ | Foil | Marfu' (ـُ) |
| الدَّرْسَ | Maf'ul bih | Mansub (ـَ) |
| البَيْتِ | Majrur (harf jarr keyin) | Majrur (ـِ) |
''',
      examples: [
        Example(
          arabic: 'الطَّالِبُ ← marfu\'',
          transliteration: 'aṭ-ṭālibu',
          translation: 'talaba (foil — kim?)',
        ),
        Example(
          arabic: 'الدَّرْسَ ← mansub',
          transliteration: 'ad-darsa',
          translation: 'darsni (maf\'ul bih — nimani?)',
        ),
        Example(
          arabic: 'فِي البَيْتِ ← majrur',
          transliteration: 'fī al-bayti',
          translation: 'uyda (harf jarr + ism)',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: 'Foil qaysi i\'robda bo\'ladi?',
          options: ['Marfu\'', 'Mansub', 'Majrur', 'Majzum'],
          correctIndex: 0,
          explanation: 'Foil — ish bajaruvchi, doim marfu\' (damma).',
        ),
        Quiz(
          question: 'Maf\'ul bih qanday harakat oladi?',
          options: ['Damma (ـُ)', 'Fatha (ـَ)', 'Kasra (ـِ)', 'Sukun'],
          correctIndex: 1,
          explanation: 'Maf\'ul bih mansub bo\'ladi — fatha (ـَ).',
        ),
        Quiz(
          question: '"فِي" dan keyingi ism qaysi holatda?',
          options: ['Marfu\'', 'Mansub', 'Majrur', 'Majzum'],
          correctIndex: 2,
          explanation:
              'فِي — harf jarr. Undan keyingi ism doim majrur (kasra).',
        ),
        Quiz(
          question:
              '"قَرَأَ الطَّالِبُ الكِتَابَ" — الكِتَابَ qaysi rolda?',
          arabicSentence: 'قَرَأَ الطَّالِبُ الكِتَابَ',
          options: ['Foil', 'Maf\'ul bih', 'Mubtado', 'Xabar'],
          correctIndex: 1,
          explanation:
              'Fatha (ـَ) bilan kelgan, o\'qilgan narsa — Maf\'ul bih.',
        ),
      ],
    ),
    Lesson(
      id: 'nahv_04',
      title: 'Sifat va Mavsuf',
      arabicTitle: 'الصِّفَةُ وَالمَوْصُوفُ',
      description: 'Belgi va belgilanmish',
      category: LessonCategory.nahv,
      level: 3,
      source: 'S. Bekpo\'lat — Mabdaun Nahv',
      theory: '''
**Sifat (الصِّفَة)** — ismning belgisini bildiruvchi so'z.
**Mavsuf (المَوْصُوف)** — sifatlanayotgan ism.

**Asosiy qoida:** Sifat 4 jihatdan Mavsufga **mos kelishi** shart:

1. **Jins** (muzakkar/muannas)
2. **Son** (mufrad/musanno/jam')
3. **Ma'rifa/Nakira**
4. **I'rob** (marfu'/mansub/majrur)

**Misollar:**

✅ **رَجُلٌ كَبِيرٌ** — katta erkak
   - Mavsuf: رَجُلٌ (nakira, mufrad, muzakkar, marfu')
   - Sifat: كَبِيرٌ (xuddi shunday)

✅ **الرَّجُلُ الكَبِيرُ** — (o'sha) katta erkak
   - Ikkalasi ham ma'rifa (الـ bilan)

✅ **اِمْرَأَةٌ جَمِيلَةٌ** — chiroyli ayol
   - Ikkalasi muannas (ة bilan)

❌ **رَجُلٌ كَبِيرَةٌ** — XATO!
   - Jins mos kelmaydi (er.+ay.)
''',
      examples: [
        Example(
          arabic: 'الكِتَابُ الجَدِيدُ',
          transliteration: 'al-kitābu al-jadīdu',
          translation: 'yangi kitob',
          grammarNote: 'Ikkalasi: ma\'rifa, mufrad, muzakkar, marfu\'',
        ),
        Example(
          arabic: 'بِنْتٌ جَمِيلَةٌ',
          transliteration: 'bintun jamīlatun',
          translation: 'chiroyli qiz',
          grammarNote: 'Ikkalasi: nakira, mufrad, muannas, marfu\'',
        ),
        Example(
          arabic: 'فِي البَيْتِ الكَبِيرِ',
          transliteration: 'fī al-bayti al-kabīri',
          translation: 'katta uyda',
          grammarNote: 'Ikkalasi majrur (kasra)',
        ),
      ],
      vocabulary: const [],
      quizzes: const [
        Quiz(
          question: '"اِمْرَأَةٌ ___" — Sifatni to\'g\'ri tanlang',
          options: ['كَبِيرٌ', 'كَبِيرَةٌ', 'كِبَارٌ', 'كَبِيرَيْنِ'],
          correctIndex: 1,
          explanation:
              'اِمْرَأَةٌ — muannas, demak sifati ham muannas: كَبِيرَةٌ.',
        ),
        Quiz(
          question: '"الكِتَابُ ___" — Sifatni tanlang',
          options: ['جَدِيدٌ', 'الجَدِيدُ', 'جَدِيدَةٌ', 'جَدِيدًا'],
          correctIndex: 1,
          explanation:
              'الكِتَابُ — ma\'rifa, demak sifati ham الـ bilan: الجَدِيدُ.',
        ),
        Quiz(
          question: 'Sifat Mavsufga necha jihatdan mos kelishi kerak?',
          options: ['2', '3', '4', '5'],
          correctIndex: 2,
          explanation:
              'Jins, son, ma\'rifa/nakira, i\'rob — 4 jihatdan mos kelishi shart.',
        ),
      ],
    ),
  ];

  static List<Lesson> getByCategory(LessonCategory category) =>
      allLessons.where((l) => l.category == category).toList();
}

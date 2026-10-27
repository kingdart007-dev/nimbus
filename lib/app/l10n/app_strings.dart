import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppStrings {
  const AppStrings(this.locale);
  final Locale locale;
  bool get isArabic => locale.languageCode == 'ar';

  static const supportedLocales = [Locale('en'), Locale('ar')];
  static const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const LocalizationsDelegate<AppStrings> delegate =
      _AppStringsDelegate();
  static AppStrings of(BuildContext context) =>
      Localizations.of<AppStrings>(context, AppStrings)!;

  String get(String key) => (isArabic ? _ar : _en)[key] ?? _en[key] ?? key;

  static const Map<String, String> _en = {
    'today': 'Today',
    'food': 'Food',
    'activity': 'Activity',
    'settings': 'Settings',
    'headline': 'Your day, in balance.',
    'subtitle': 'Small steps. Steady progress.',
    'nutrition': 'Nutrition today',
    'calories': 'Calories',
    'left': 'kcal left',
    'eaten': 'eaten',
    'daily_goal': 'daily goal',
    'macros': 'Your macros',
    'protein': 'Protein',
    'carbs': 'Carbs',
    'fat': 'Fat',
    'grams': 'g',
    'water': 'Water',
    'water_hint': 'A little hydration goes a long way.',
    'add_glass': 'Add a glass',
    'food_log': 'Food log',
    'view_food': 'View food',
    'empty_food': 'Nothing logged yet',
    'empty_food_hint': 'Add a meal to see your daily nutrition here.',
    'food_title': 'Your food',
    'food_subtitle': 'Keep it simple. Log a meal and move on.',
    'add_food': 'Add food',
    'food_name': 'Food or meal name',
    'protein_short': 'Protein (g)',
    'carbs_short': 'Carbs (g)',
    'fat_short': 'Fat (g)',
    'cancel': 'Cancel',
    'save': 'Save food',
    'required': 'Please enter a name.',
    'invalid_number': 'Enter a valid number.',
    'no_entries': 'Your food log is empty',
    'no_entries_hint': 'Your first entry can be as simple as a snack.',
    'activity_title': 'Move your way.',
    'activity_subtitle': 'A little movement counts. Choose what you did.',
    'walk': 'Walk',
    'run': 'Run',
    'strength': 'Strength',
    'minutes': 'minutes',
    'log_activity': 'Log activity',
    'recent_activity': 'Recent activity',
    'no_activity': 'No movement logged yet',
    'no_activity_hint': 'Add a walk, run, or strength session when ready.',
    'activity_note':
        'Automatic step counts and calories-burned estimates are not connected yet.',
    'duration': 'Duration (minutes)',
    'save_session': 'Save session',
    'appearance': 'Appearance',
    'appearance_hint': 'Make Nimbus feel comfortable on your eyes.',
    'theme': 'Theme',
    'system': 'System',
    'light': 'Light',
    'dark': 'Dark',
    'language': 'Language',
    'language_hint': 'Choose the language that feels natural.',
    'english': 'English',
    'arabic': 'العربية',
    'storage_note':
        'Food, water, and activity entries are in memory in this starter build. Local history and sync come later.',
    'goal_note':
        'Goals and personal recommendations will be configurable in a later milestone.',
  };
  static const Map<String, String> _ar = {
    'today': 'اليوم',
    'food': 'الطعام',
    'activity': 'النشاط',
    'settings': 'الإعدادات',
    'headline': 'يومك بتوازن.',
    'subtitle': 'خطوات صغيرة. تقدّم مستمر.',
    'nutrition': 'تغذيتك اليوم',
    'calories': 'السعرات',
    'left': 'سعرة متبقية',
    'eaten': 'تم تناولها',
    'daily_goal': 'الهدف اليومي',
    'macros': 'العناصر الغذائية',
    'protein': 'البروتين',
    'carbs': 'الكربوهيدرات',
    'fat': 'الدهون',
    'grams': 'جم',
    'water': 'الماء',
    'water_hint': 'القليل من الماء يصنع فرقًا.',
    'add_glass': 'أضف كوبًا',
    'food_log': 'سجل الطعام',
    'view_food': 'عرض الطعام',
    'empty_food': 'لا توجد وجبات مسجلة',
    'empty_food_hint': 'أضف وجبة لعرض تغذيتك اليومية هنا.',
    'food_title': 'طعامك',
    'food_subtitle': 'ببساطة: سجّل وجبتك وتابع يومك.',
    'add_food': 'أضف طعامًا',
    'food_name': 'اسم الطعام أو الوجبة',
    'protein_short': 'بروتين (جم)',
    'carbs_short': 'كربوهيدرات (جم)',
    'fat_short': 'دهون (جم)',
    'cancel': 'إلغاء',
    'save': 'حفظ الطعام',
    'required': 'يرجى إدخال الاسم.',
    'invalid_number': 'أدخل رقمًا صحيحًا.',
    'no_entries': 'سجل الطعام فارغ',
    'no_entries_hint': 'يمكن أن تكون أول إضافة وجبة خفيفة.',
    'activity_title': 'تحرّك بطريقتك.',
    'activity_subtitle': 'كل حركة مفيدة. اختر ما قمت به.',
    'walk': 'مشي',
    'run': 'جري',
    'strength': 'تمارين القوة',
    'minutes': 'دقيقة',
    'log_activity': 'سجّل نشاطًا',
    'recent_activity': 'النشاط الأخير',
    'no_activity': 'لا يوجد نشاط مسجل',
    'no_activity_hint': 'أضف جلسة مشي أو جري أو تمارين قوة عندما تكون مستعدًا.',
    'activity_note':
        'لم يتم ربط عدّاد الخطوات التلقائي أو تقديرات السعرات المحروقة بعد.',
    'duration': 'المدة (بالدقائق)',
    'save_session': 'حفظ الجلسة',
    'appearance': 'المظهر',
    'appearance_hint': 'اختر ألوانًا مريحة لعينيك.',
    'theme': 'السمة',
    'system': 'النظام',
    'light': 'فاتح',
    'dark': 'داكن',
    'language': 'اللغة',
    'language_hint': 'اختر اللغة المناسبة لك.',
    'english': 'English',
    'arabic': 'العربية',
    'storage_note':
        'تُحفظ إدخالات الطعام والماء والنشاط في الذاكرة خلال هذه النسخة. سيأتي التخزين المحلي والمزامنة لاحقًا.',
    'goal_note':
        'ستصبح الأهداف والتوصيات الشخصية قابلة للتخصيص في مرحلة لاحقة.',
  };
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();
  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'en' || locale.languageCode == 'ar';
  @override
  Future<AppStrings> load(Locale locale) =>
      SynchronousFuture<AppStrings>(AppStrings(locale));
  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}

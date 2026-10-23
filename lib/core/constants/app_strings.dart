import '../utils/uk_grammar.dart';

/// Текстові рядки інтерфейсу. Зібрані в одному місці, щоб надалі
/// перенести їх у файли локалізації (NFR-10).
abstract final class AppStrings {
  // Загальні
  static const appTitle = 'Каталог навчальних матеріалів';
  static const appShortTitle = 'Каталог матеріалів';
  static const appTagline =
      'Конспекти, посилання та файли за дисциплінами й темами';
  static const cancel = 'Скасувати';
  static const or = 'або';
  static const showPassword = 'Показати пароль';
  static const hidePassword = 'Приховати пароль';

  // Матеріали та дисципліни
  static const materialTypeNote = 'конспект';
  static const materialTypeLink = 'посилання';
  static const materialTypeFile = 'файл';
  static const addToFavorites = 'Додати до обраного';
  static const removeFromFavorites = 'Прибрати з обраного';

  static String topicsCount(int count) =>
      UkGrammar.count(count, 'тема', 'теми', 'тем');

  static String materialsCount(int count) =>
      UkGrammar.count(count, 'матеріал', 'матеріали', 'матеріалів');

  static String disciplinesCount(int count) =>
      UkGrammar.count(count, 'дисципліна', 'дисципліни', 'дисциплін');

  // Навігація
  static const navHome = 'Головна';
  static const navDisciplines = 'Дисципліни';
  static const navSearch = 'Пошук';
  static const navProfile = 'Профіль';
  static const navSettings = 'Налаштування';
  static const myDisciplines = 'Мої дисципліни';
  static const synced = 'Синхронізовано';
  static const searchShortcut = '⌘F';

  // Розділи в розробці
  static const comingSoonTitle = 'Розділ у розробці';
  static const comingSoonDisciplines =
      'Тут буде список дисциплін із сортуванням, створенням, '
      'редагуванням і видаленням.';
  static const comingSoonSearch =
      'Тут буде пошук матеріалів за назвою, тегами й текстом конспектів '
      'з фільтрами за типом і дисципліною.';
  static const comingSoonSettings =
      'Тут можна буде обрати тему оформлення та мову інтерфейсу.';
  static const comingSoonHome =
      'Тут буде головний екран зі швидким доступом до матеріалів.';
  static const comingSoonProfile =
      'Тут можна буде змінити дані профілю, фото та пароль.';

  // Валідація
  static const emailRequired = 'Введіть електронну пошту';
  static const emailInvalid = 'Некоректний формат електронної пошти';
  static const passwordRequired = 'Введіть пароль';
  static const passwordRules = 'Щонайменше 8 символів, літери та цифри';
  static const passwordTooWeak =
      'Пароль має містити щонайменше 8 символів, літери та цифри';
  static const confirmPasswordRequired = 'Підтвердьте пароль';
  static const passwordsDoNotMatch = 'Паролі не збігаються';
  static const nameRequired = "Введіть ім'я";
  static const photoFormatHint =
      'Оберіть зображення JPG або PNG розміром до 5 МБ.';

  static String photoUnsupported(String fileName) =>
      'Файл «$fileName» не підтримується';

  static String photoTooLarge(String fileName) =>
      'Файл «$fileName» перевищує 5 МБ';
}

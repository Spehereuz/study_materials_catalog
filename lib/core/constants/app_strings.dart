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

  // Вхід, реєстрація, відновлення пароля
  static const emailLabel = 'Електронна пошта';
  static const emailHint = 'name@example.com';
  static const passwordLabel = 'Пароль';
  static const forgotPassword = 'Забули пароль?';
  static const signIn = 'Увійти';
  static const signInWithApple = 'Увійти через Apple';
  static const noAccount = 'Немає облікового запису?';
  static const createAccount = 'Створити обліковий запис';
  static const invalidCredentials = 'Неправильна електронна пошта або пароль';
  static const backToSignIn = 'Назад до входу';
  static const registerTitle = 'Створення облікового запису';
  static const registerSubtitle =
      'Заповніть форму, щоб зберігати свої матеріали';
  static const nameLabel = "Ім'я";
  static const confirmPasswordLabel = 'Підтвердження пароля';
  static const register = 'Зареєструватися';
  static const haveAccount = 'Вже маєте обліковий запис?';
  static const emailAlreadyInUse = 'Цю електронну пошту вже зареєстровано';
  static const resetTitle = 'Відновлення пароля';
  static const resetSubtitle =
      'Введіть електронну пошту, вказану під час реєстрації. '
      'Ми надішлемо посилання для скидання пароля.';
  static const sendResetLink = 'Надіслати посилання';
  static const resendResetLink = 'Надіслати ще раз';
  static const returnToSignIn = 'Повернутися до входу';

  static String resetEmailSent(String email) =>
      'Лист надіслано на $email. Перевірте пошту.';

  // Навігація
  static const navHome = 'Головна';
  static const navDisciplines = 'Дисципліни';
  static const navSearch = 'Пошук';
  static const navProfile = 'Профіль';
  static const navSettings = 'Налаштування';
  static const myDisciplines = 'Мої дисципліни';
  static const synced = 'Синхронізовано';
  static const searchShortcut = '⌘F';

  // Головний екран
  static const searchMaterialsHint = 'Пошук матеріалів';
  static const newDiscipline = 'Нова дисципліна';
  static const newMaterial = 'Новий матеріал';
  static const recentMaterials = 'Нещодавні матеріали';
  static const allMaterials = 'Усі матеріали';
  static const favorites = 'Обране';
  static const allDisciplines = 'Усі дисципліни';
  static const noRecentMaterials =
      "Тут з'являться матеріали, які ви нещодавно відкривали.";
  static const noFavorites =
      'Позначте матеріал зірочкою, щоб швидко повертатися до нього.';
  static const emptyCatalogTitle = 'Поки що немає дисциплін';
  static const emptyCatalogMessage =
      'Створіть першу дисципліну, щоб додавати до неї конспекти, '
      'посилання й файли.';
  static const createFirstDiscipline = 'Створити дисципліну';
  static const featureInProgress =
      "Ця функція з'явиться в наступній версії застосунку";

  static String greeting(String firstName) =>
      'Вітаємо, ${UkGrammar.vocative(firstName)}!';

  static String catalogSummary(int disciplines, int topics, int materials) =>
      '${disciplinesCount(disciplines)}, ${topicsCount(topics)}, '
      '${materialsCount(materials)}';

  static String materialPath(String discipline, String topic) =>
      '$discipline › $topic';

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

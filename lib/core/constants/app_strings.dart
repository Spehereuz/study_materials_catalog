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

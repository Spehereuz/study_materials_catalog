import 'package:flutter/foundation.dart';

/// Профіль користувача (див. «Об'єкти даних» у ЛР2).
@immutable
class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordChangedAt,
    this.institution = '',
    this.group = '',
  });

  final String id;
  final String name;
  final String email;
  final String institution;
  final String group;
  final DateTime passwordChangedAt;

  /// Ім'я без прізвища — для привітання на головному екрані.
  String get firstName => _words.isEmpty ? '' : _words.first;

  /// Ініціали для аватара: «Владислав Гардецький» → «ВГ».
  String get initials {
    final letters = _words.take(2).map((word) => word.substring(0, 1));
    return letters.join().toUpperCase();
  }

  List<String> get _words =>
      name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

  UserProfile copyWith({
    String? name,
    String? institution,
    String? group,
    DateTime? passwordChangedAt,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email,
      institution: institution ?? this.institution,
      group: group ?? this.group,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
    );
  }
}

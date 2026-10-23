import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_snack_bar.dart';
import '../../core/widgets/confirm_dialog.dart';
import '../../core/widgets/page_header.dart';
import '../../data/models/catalog_snapshot.dart';
import '../../data/models/user_profile.dart';
import '../auth/login_screen.dart';
import 'widgets/change_password_dialog.dart';
import 'widgets/profile_form_card.dart';
import 'widgets/profile_summary_card.dart';
import 'widgets/security_card.dart';

/// Екран профілю S10: дані користувача, фото, зміна пароля і вихід.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user, required this.snapshot});

  final UserProfile user;
  final CatalogSnapshot snapshot;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// Ширина вмісту, від якої картки стоять у дві колонки.
  static const _twoColumnWidth = 720.0;
  static const _leftColumnWidth = 336.0;

  /// Зберігає стан форми, коли розкладка перемикається між колонками.
  final _formKey = GlobalKey();
  String? _photoError;

  Future<void> _pickPhoto() async {
    final photo = await AppScope.of(context).photoPicker.pickImage();
    if (photo == null || !mounted) return;
    final error = Validators.profilePhoto(photo.name, photo.sizeBytes);
    setState(() => _photoError = error);
    if (error == null) showAppSnackBar(context, AppStrings.featureInProgress);
  }

  Future<void> _changePassword() async {
    final changed = await showChangePasswordDialog(context);
    if (!changed || !mounted) return;
    showAppSnackBar(context, AppStrings.passwordChanged);
  }

  Future<void> _signOut() async {
    final confirmed = await showConfirmDialog(
      context,
      icon: Icons.logout,
      title: AppStrings.signOutTitle,
      message: AppStrings.signOutMessage,
      confirmLabel: AppStrings.signOutConfirm,
    );
    if (!confirmed || !mounted) return;

    // Після виходу оболонка перебудовується без користувача, тому
    // навігатор беремо до очікування.
    final navigator = Navigator.of(context);
    await AppScope.of(context).auth.signOut();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary = ProfileSummaryCard(
      user: widget.user,
      disciplineCount: widget.snapshot.disciplines.length,
      materialCount: widget.snapshot.materialCount,
      onPickPhoto: _pickPhoto,
      photoError: _photoError,
    );
    final security = SecurityCard(
      passwordChangedAt: widget.user.passwordChangedAt,
      onChangePassword: _changePassword,
      onSignOut: _signOut,
    );
    final form = ProfileFormCard(key: _formKey, user: widget.user);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyO, meta: true): _pickPhoto,
      },
      child: Focus(
        autofocus: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PageHeader(title: AppStrings.navProfile),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppSizes.contentMaxWidth,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < _twoColumnWidth) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              summary,
                              const SizedBox(height: AppSpacing.large),
                              form,
                              const SizedBox(height: AppSpacing.large),
                              security,
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _leftColumnWidth,
                              child: Column(
                                children: [
                                  summary,
                                  const SizedBox(height: AppSpacing.large),
                                  security,
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.large),
                            Expanded(child: form),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

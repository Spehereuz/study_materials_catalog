import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_snack_bar.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/models/user_profile.dart';

/// Форма «Дані профілю»: ім'я, група, навчальний заклад (FR-05).
/// Пошта лише для читання, бо використовується для входу.
class ProfileFormCard extends StatefulWidget {
  const ProfileFormCard({super.key, required this.user});

  final UserProfile user;

  @override
  State<ProfileFormCard> createState() => _ProfileFormCardState();
}

class _ProfileFormCardState extends State<ProfileFormCard> {
  late final _nameController = TextEditingController(text: widget.user.name);
  late final _groupController = TextEditingController(text: widget.user.group);
  late final _institutionController = TextEditingController(
    text: widget.user.institution,
  );
  late final _emailController = TextEditingController(text: widget.user.email);

  String? _nameError;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    _institutionController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _nameController.text = widget.user.name;
      _groupController.text = widget.user.group;
      _institutionController.text = widget.user.institution;
      _nameError = null;
    });
  }

  Future<void> _save() async {
    final error = Validators.name(_nameController.text);
    setState(() => _nameError = error);
    if (error != null) return;

    setState(() => _isSaving = true);
    await AppScope.of(context).auth.updateProfile(
      name: _nameController.text,
      institution: _institutionController.text,
      group: _groupController.text,
    );
    if (!mounted) return;
    setState(() => _isSaving = false);
    showAppSnackBar(context, AppStrings.changesSaved);
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: AppStrings.profileData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.small),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: AppStrings.nameLabel,
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  errorText: _nameError,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) {
                    if (_nameError != null) setState(() => _nameError = null);
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: AppTextField(
                  label: AppStrings.groupLabel,
                  controller: _groupController,
                  prefixIcon: Icons.groups_outlined,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          AppTextField(
            label: AppStrings.institutionLabel,
            controller: _institutionController,
            prefixIcon: Icons.account_balance_outlined,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: AppSpacing.large),
          AppTextField(
            label: AppStrings.emailLabel,
            controller: _emailController,
            prefixIcon: Icons.mail_outline,
            readOnly: true,
            helperText: AppStrings.emailReadOnlyHint,
            trailing: const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.small),
              child: Icon(Icons.lock_outline, size: 20),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: AppSpacing.small,
            runSpacing: AppSpacing.small,
            children: [
              AppButton(
                label: AppStrings.cancel,
                variant: AppButtonVariant.text,
                onPressed: _isSaving ? null : _reset,
              ),
              AppButton(
                label: AppStrings.saveChanges,
                onPressed: _save,
                isLoading: _isSaving,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

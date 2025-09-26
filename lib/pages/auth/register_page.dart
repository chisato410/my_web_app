import 'package:flutter/material.dart';
import '../../models/user_registration.dart';
import 'register_confirm_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nameKanaController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zipController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _agreeTerms = false;
  bool _obscurePw = true;
  bool _obscurePwConfirm = true;

  bool hasMin(String v) => v.length >= 8;
  bool hasLetter(String v) => RegExp(r'[A-Za-z]').hasMatch(v);
  bool hasNumber(String v) => RegExp(r'[0-9]').hasMatch(v);
  bool hasSymbol(String v) =>
      RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-\[\]\\\/+=~]').hasMatch(v);

  Widget _pwRule(String text, bool ok) => Row(
    children: [
      Icon(
        ok ? Icons.check_circle : Icons.cancel,
        color: ok ? Colors.green : Colors.red,
        size: 18,
      ),
      const SizedBox(width: 6),
      Text(text),
    ],
  );

  void _next() {
    if (!_agreeTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('利用規約とプライバシーポリシーに同意してください')));
      return;
    }
    if (_formKey.currentState!.validate()) {
      final user = UserRegistration(
        fullName: _nameController.text.trim(),
        fullNameKana: _nameKanaController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        postalCode: _zipController.text.trim(),
        address: _addressController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RegisterConfirmPage(user: user)),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameKanaController.dispose();
    _emailController.dispose();
    _emailConfirmController.dispose();
    _phoneController.dispose();
    _zipController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pw = _passwordController.text;
    return Scaffold(
      appBar: AppBar(title: const Text('新規会員登録')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '氏名',
                  hintText: '山田 太郎',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? '氏名を入力してください' : null,
              ),
              TextFormField(
                controller: _nameKanaController,
                decoration: const InputDecoration(
                  labelText: '氏名（カナ）',
                  hintText: 'ヤマダ タロウ',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return '氏名（カナ）を入力してください';
                  if (!RegExp(r'^[ァ-ヶー\s]+$').hasMatch(v)) {
                    return '全角カタカナで入力してください';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  hintText: 'example@mail.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'メールアドレスを入力してください' : null,
              ),
              TextFormField(
                controller: _emailConfirmController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス（確認）',
                  hintText: '確認用に再入力してください',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v ?? '') != _emailController.text ? 'メールが一致しません' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '電話番号（任意）',
                  hintText: '09012345678',
                ),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v != null && v.isNotEmpty) {
                    if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                      return '数字のみ入力してください';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(
                  labelText: '郵便番号',
                  hintText: '123-4567',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return '郵便番号を入力してください';
                  if (!RegExp(r'^\d{3}-?\d{4}$').hasMatch(v)) {
                    return '正しい形式で入力してください（例: 123-4567）';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: '住所',
                  hintText: '東京都〇〇区△△1-2-3',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? '住所を入力してください' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  hintText: '8文字以上・英数記号を含む',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePw ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => _obscurePw = !_obscurePw),
                  ),
                ),
                obscureText: _obscurePw,
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  final value = v ?? '';
                  if (!hasMin(value)) return '8文字以上で入力してください';
                  if (!hasLetter(value)) return '英字を含めてください';
                  if (!hasNumber(value)) return '数字を含めてください';
                  if (!hasSymbol(value)) return '記号を含めてください';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              _pwRule('8文字以上', hasMin(pw)),
              _pwRule('英字を含む', hasLetter(pw)),
              _pwRule('数字を含む', hasNumber(pw)),
              _pwRule('記号を含む', hasSymbol(pw)),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  labelText: 'パスワード（確認）',
                  hintText: '確認用に再入力してください',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePwConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePwConfirm = !_obscurePwConfirm),
                  ),
                ),
                obscureText: _obscurePwConfirm,
                validator: (v) => (v ?? '') != _passwordController.text
                    ? 'パスワードが一致しません'
                    : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _agreeTerms,
                onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                title: const Text('利用規約とプライバシーポリシーに同意します'),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _next,
                  child: const Text('確認画面へ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

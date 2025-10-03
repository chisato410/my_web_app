import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // ← 追加
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
  bool _loadingAddress = false; // 住所検索中のフラグ

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

  /// 郵便番号が7桁揃ったら住所検索
  void _onZipChanged(String value) async {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 7) {
      final formatted = '${digits.substring(0, 3)}-${digits.substring(3)}';
      if (_zipController.text != formatted) {
        setState(() {
          _zipController.text = formatted;
          _zipController.selection = TextSelection.fromPosition(
            TextPosition(offset: formatted.length),
          );
        });
      }
      await _fetchAddress(digits);
    }
  }

  /// zipcloud APIで住所検索
  Future<void> _fetchAddress(String zipcode) async {
    setState(() => _loadingAddress = true);
    try {
      final res = await http.get(
        Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode'),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0];
          final address =
              '${result['address1']}${result['address2']}${result['address3']}';
          setState(() {
            _addressController.text = address;
          });
        } else {
          _showSnack('住所が見つかりませんでした');
        }
      } else {
        _showSnack('住所検索に失敗しました');
      }
    } catch (e) {
      _showSnack('通信エラーが発生しました');
    } finally {
      setState(() => _loadingAddress = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _next() {
    if (!_agreeTerms) {
      _showSnack('利用規約とプライバシーポリシーに同意してください');
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

  /// 利用規約・プライバシーポリシーを表示するダイアログ
  void _showTermsDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
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
              // --- 名前 ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '氏名',
                  hintText: '山田 太郎',
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? '氏名を入力してください' : null,
              ),
              // --- カナ ---
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
              // --- メール ---
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
                enableInteractiveSelection: false, // ← コピー禁止
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v ?? '') != _emailController.text ? 'メールが一致しません' : null,
              ),
              // --- 電話 ---
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
              // --- 郵便番号 ---
              TextFormField(
                controller: _zipController,
                decoration: InputDecoration(
                  labelText: '郵便番号',
                  hintText: '123-4567',
                  suffixIcon: _loadingAddress
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                ),
                keyboardType: TextInputType.number,
                onChanged: _onZipChanged,
                validator: (v) {
                  if (v == null || v.isEmpty) return '郵便番号を入力してください';
                  if (!RegExp(r'^\d{3}-?\d{4}$').hasMatch(v)) {
                    return '正しい形式で入力してください（例: 123-4567）';
                  }
                  return null;
                },
              ),
              // --- 住所 ---
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
              // --- パスワード ---
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
                enableInteractiveSelection: false, // ← コピー禁止
                obscureText: _obscurePwConfirm,
                validator: (v) => (v ?? '') != _passwordController.text
                    ? 'パスワードが一致しません'
                    : null,
              ),
              const SizedBox(height: 16),
              // --- 規約チェック + リンク付き ---
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _agreeTerms,
                onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                title: Wrap(
                  children: [
                    const Text('利用規約と'),
                    GestureDetector(
                      onTap: () => _showTermsDialog(
                        '利用規約',
                        'ここに利用規約の内容を表示します。\n\n第1条〜第○条...',
                      ),
                      child: const Text(
                        '利用規約',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(' および '),
                    GestureDetector(
                      onTap: () => _showTermsDialog(
                        'プライバシーポリシー',
                        'ここにプライバシーポリシーの内容を表示します。\n\n第1条〜第○条...',
                      ),
                      child: const Text(
                        'プライバシーポリシー',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(' に同意します'),
                  ],
                ),
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

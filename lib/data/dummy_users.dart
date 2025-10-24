class User {
  /// FirebaseユーザーUIDなど、一意なID
  final String id;

  /// 表示名（メールアドレスやユーザー名など）
  final String name;

  /// ローカル認証などで使うパスワード
  final String password;

  /// ユーザーのイニシャル（例: 名前やメールの先頭文字）
  final String initial;

  const User({
    required this.id,
    required this.name,
    required this.password,
    required this.initial,
  });
}

// ✅ ダミーデータ（オフライン動作用）
final List<User> dummyUsers = [
  User(id: '001', name: 'Alice', password: 'alice123', initial: 'A'),
  User(id: '002', name: 'Bob', password: 'bob123', initial: 'B'),
  User(id: '003', name: 'Charlie', password: 'charlie123', initial: 'C'),
];

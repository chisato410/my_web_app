class AuthService {
  Future<bool> signIn(String email, String password) async {
    // モック: 本来は認証APIを呼び出す
    await Future.delayed(const Duration(seconds: 1));
    if (email == "test@example.com" && password == "password") {
      return true;
    }
    return false;
  }

  Future<void> sendPasswordReset(String email) async {
    // モック: 実際はメール送信処理
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  Future<bool> signUp(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    print('attempting login');
    await Future.delayed(const Duration(seconds: 3));
    return 'abc';
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<String> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

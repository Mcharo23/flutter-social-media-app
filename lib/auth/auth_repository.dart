class AuthRepository {
  Future<void> login() async {
    print('attempting to login');
    await Future.delayed(const Duration(seconds: 3));
    print('logged in');

    throw Exception('Invalid credentials');
  }
}

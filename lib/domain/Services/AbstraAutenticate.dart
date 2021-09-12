

abstract class AbstractServices {
  Future login({required String email, required String password});

  Future register({required String email, required String password, required String fullname});

  Future forget({required String email});

  Future signOut();
}
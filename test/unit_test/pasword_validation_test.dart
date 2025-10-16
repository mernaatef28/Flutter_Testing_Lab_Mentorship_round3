import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/data/validator.dart';

void main() {
  group("password validations ", () {
    test("test validatePassword returns Error whenEmpty ", () {
      Validator _validator = Validator();
      bool test = _validator.isValidPassword("");
      expect(test, false);
    });
    test("test validate password is empty ", () {
      Validator _validator = Validator();
      String? test = _validator.validatePassword("");
      expect(test, "Password is required");
    });

    test("test validate password must be at least 8 characters long ", () {
      Validator _validator = Validator();
      String? test = _validator.validatePassword("aaa12");
      expect(test, "Password must be at least 8 characters long");
    });
    test(
      "test validate password must contain uppercase, lowercase, and number",
      () {
        Validator _validator = Validator();
        String? test = _validator.validatePassword("aaaaaaaaa");
        expect(test, "Password must contain uppercase, lowercase, and number");
      },
    );
  });
}

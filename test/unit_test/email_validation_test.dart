import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/data/validator.dart';

void main() {
  test("test isValidEmail returns True for Valid Emails", () {
    Validator _validator = Validator();
    bool test = _validator.isValidEmail("test@example.com");
    expect(test, true);
  });

  test("test isValidEmail returns False for InvalidEmails", () {
    Validator _validator = Validator();
    bool test = _validator.isValidEmail("test@example");
    expect(test, false);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/services/cart_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/services/cart_service.dart';
import 'package:flutter_testing_lab/data/cart_item.dart'; // if needed

void main() {
  group('CartService Tests', () {
    test('Adding a new item adds it to the cart', () {
      // === Arrange ===
      final cartService = CartService();

      // === Act ===
      cartService.addItem('1', 'iPhone', 1000.0);

      // === Assert ===
      expect(cartService.items.length, 1);
      expect(cartService.items.first.name, 'iPhone');
    });
    test('deleting a new item adds it to the cart', () {
      // === Arrange ===
      final cartService = CartService();

      // === Act ===

      cartService.removeItem("1");

      // === Assert ===
      expect(cartService.items.length, 0);
    });

    test('Adding a new item Add Duplicate Item Increases Quantity', () {
      // === Arrange ===
      final cartService = CartService();

      // === Act ===
      cartService.addItem('1', 'iPhone', 1000.0);
      cartService.addItem('1', 'iPhone', 1000.0);
      // === Assert ===
      expect(cartService.items.length, 1);
      expect(cartService.items.first.quantity, 2);
    });
    test('test Update Quantity To Zero Removes Item', () {
      // === Arrange ===
      final cartService = CartService();

      // === Act ===
      cartService.addItem('1', 'iPhone', 1000.0);
      cartService.updateQuantity("1", 0);

      // === Assert ===
      expect(cartService.items.length, 0);
    });
    test('test Subtotal Calculation', () {
      // Arrange
      final cartService = CartService();
      cartService.addItem('1', 'iPhone', 1000.0);
      cartService.addItem('2', 'Samsung', 800.0);

      // Act
      final subtotal = cartService.items.fold(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      // Assert
      expect(subtotal, 1800.0);
    });

    test('test Total Discount Calculation', () {
      // Arrange
      final cartService = CartService();
      cartService.addItem('1', 'iPhone', 1000.0, discount: 0.1); // 100
      cartService.addItem('2', 'Samsung', 800.0, discount: 0.2); // 160

      // Act
      final discount = cartService.items.fold(
        0.0,
        (sum, item) => sum + ((item.price * item.discount) * item.quantity),
      );

      // Assert
      expect(discount, 260.0);
    });

    test('test Total Amount After Discount', () {
      // Arrange
      final cartService = CartService();
      cartService.addItem(
        '1',
        'MacBook',
        2000.0,
        discount: 0.1,
      ); // 200 discount

      // Act
      final subtotal = cartService.items.fold(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );
      final totalDiscount = cartService.items.fold(
        0.0,
        (sum, item) => sum + ((item.price * item.discount) * item.quantity),
      );
      final totalAmount = subtotal - totalDiscount;

      // Assert
      expect(subtotal, 2000.0);
      expect(totalDiscount, 200.0);
      expect(totalAmount, 1800.0);
    });

    test('test Empty Cart Totals Are Zero', () {
      // Arrange
      final cartService = CartService();

      // Act
      final subtotal = cartService.items.fold(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );
      final totalDiscount = cartService.items.fold(
        0.0,
        (sum, item) => sum + ((item.price * item.discount) * item.quantity),
      );
      final totalAmount = subtotal - totalDiscount;

      // Assert
      expect(cartService.items.length, 0);
      expect(subtotal, 0.0);
      expect(totalDiscount, 0.0);
      expect(totalAmount, 0.0);
    });

    test('test Full Discount Makes Item Free', () {
      // Arrange
      final cartService = CartService();
      cartService.addItem('1', 'Promo Item', 500.0, discount: 1.0); // 100% off

      // Act
      final totalAmount = cartService.items.fold(
        0.0,
        (sum, item) =>
            sum + ((item.price - (item.price * item.discount)) * item.quantity),
      );

      // Assert
      expect(totalAmount, 0.0);
    });

    test('test Negative Quantity Prevents Crash Or Removes Item', () {
      // Arrange
      final cartService = CartService();
      cartService.addItem('1', 'iPhone', 1000.0);

      // Act
      cartService.updateQuantity('1', -3);

      // Assert
      expect(cartService.items.length, 0);
    });
  });
}

testUpdateQuantityToZeroRemovesItem() {}

testSubtotalCalculation() {}

testTotalDiscountCalculation() {}

testTotalAmountAfterDiscount() {}

testEmptyCartTotalsAreZero() {}

testFullDiscountMakesItemFree() {}

testNegativeQuantityPreventsCrashOrRemovesItem() {}

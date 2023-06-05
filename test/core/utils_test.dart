import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('string to unsigned int', () {
    test('shoult return int when string represents an unsigned int', () async {
//arrange
      const str = '123';
//act
      final result = inputConverter.stringToUnsignedInteger(str);
//assert
      expect(result, const Right(123));
    });

    test('should return a failure when the string is not an int', () async {
      //arrange
      const str = 'abc';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}

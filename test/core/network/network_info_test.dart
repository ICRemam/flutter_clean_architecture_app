import 'package:flutter_clean_architecture_app/core/platform/newtwork_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });

  group('connected', () {
    test('should forward the call to connectivity', () async {
      //arrange
      final tHasConnection = Future.value(true);
      when(() => mockConnectivity.hasConnection).thenAnswer((_) async => tHasConnection);
      //act
      final result = await networkInfoImpl.connected;
      //assert
      verify(() => mockConnectivity.hasConnection);
      expect(result, true);
    });
  });
}

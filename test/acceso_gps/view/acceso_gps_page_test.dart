// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:counter/UI/acceso_gps/acceso_gps.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<int> implements AccesoGpsCubit {}

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const AccesoGpsPage());
      expect(find.byType(AccesoGpsPage), findsOneWidget);
    });
  });
}

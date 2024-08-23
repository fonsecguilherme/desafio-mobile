import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_app/business_logic/locations/locations_cubit.dart';
import 'package:gabriel_app/data/models/address_model.dart';
import 'package:gabriel_app/data/models/location_info_model.dart';
import 'package:gabriel_app/data/models/video_info.dart';
import 'package:gabriel_app/data/models/video_model.dart';
import 'package:gabriel_app/presentation/locations/locations_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationsCubit extends MockCubit<LocationsState>
    implements LocationsCubit {}

late LocationsCubit locationsCubit;

void main() {
  setUp(() => locationsCubit = MockLocationsCubit());

  tearDown(() => locationsCubit.close());

  group('Should find correct widgets according to page', () {
    testWidgets('Find initial state widget', (tester) async {
      when(() => locationsCubit.getLocations())
          .thenAnswer((_) => Future.value());

      when(() => locationsCubit.state).thenReturn(InitialLocationsState());

      await _createWidget(tester);

      expect(find.text('Obtendo dados...'), findsOneWidget);
    });
    testWidgets('Find loading state widget', (tester) async {
      when(() => locationsCubit.getLocations())
          .thenAnswer((_) => Future.value());

      when(() => locationsCubit.state).thenReturn(LoadingLocationsState());

      await _createWidget(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Find error state widget', (tester) async {
      when(() => locationsCubit.getLocations())
          .thenAnswer((_) => Future.value());

      when(() => locationsCubit.state)
          .thenReturn(ErrorLocationsState(errorMessage: 'error'));

      await _createWidget(tester);

      expect(find.text('Recarregar'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Find success state widget', (tester) async {
      when(() => locationsCubit.getLocations())
          .thenAnswer((_) => Future.value());

      when(() => locationsCubit.state)
          .thenReturn(SuccessLocationsState(result: _videoList));

      await _createWidget(tester);

      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: BlocProvider(
      create: (context) => locationsCubit,
      child: const LocationsPage(),
    ),
  ));
}

VideoModel _videoList = VideoModel(data: [
  Video(
    uri: 'uri',
    fileName: '',
    videoInfo: VideoInfo(
        title: 'meuvideo',
        subtitle: 'casa do guilherme',
        description: 'portaria'),
    locationInfo: LocationInfo(
      id: '#0',
      name: 'name',
      address: Address(
          city: 'arap',
          state: 'al',
          address: 'Rua das laranjeitas',
          latitude: 'latitude',
          longitude: 'longitude'),
    ),
  ),
]);

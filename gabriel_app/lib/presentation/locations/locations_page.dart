import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabriel_app/presentation/location_detail/location_detail_page.dart';
import 'package:gabriel_app/business_logic/locations/locations_cubit.dart';

import '../../models/video_model.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  LocationsCubit get cubit => context.read<LocationsCubit>();

  final List<String> itensAmount = ['10', '20'];
  String dropdownValue = '';

  @override
  void initState() {
    cubit.getLocations();
    dropdownValue = itensAmount.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Locais',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 57, 85, 132),
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                onChanged: (String? value) {
                  cubit.getLocations(size: value ?? '10');

                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items:
                    itensAmount.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        body: BlocBuilder<LocationsCubit, LocationsState>(
          builder: (context, state) {
            if (state is InitialLocationsState) {
              return const Center(child: Text('Obtendo dados...'));
            } else if (state is LoadingLocationsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorLocationsState) {
              return Center(
                child: ElevatedButton(
                  onPressed: cubit.getLocations,
                  child: const Text('Recarregar'),
                ),
              );
            } else if (state is SuccessLocationsState) {
              final address = state.result.data;

              log('$address');

              return _SuccessLocationWidget(address: address);
            }
            return const SizedBox();
          },
        ),
      );
}

class _SuccessLocationWidget extends StatelessWidget {
  final List<Video> address;

  const _SuccessLocationWidget({required this.address});

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: address.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationDetailPage(
                videoUrl: address.elementAt(index).uri,
                info: address.elementAt(index).videoInfo,
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              address.elementAt(index).locationInfo.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: const Color.fromARGB(255, 57, 85, 132),
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              address.elementAt(index).locationInfo.address.address,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.lightGreen,
            ),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
      );
}

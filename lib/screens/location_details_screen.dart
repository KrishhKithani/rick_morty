import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rickandmorty_app/models/character.dart';
import 'package:rickandmorty_app/models/location_details.dart';
import 'package:rickandmorty_app/widgets/image_viewer.dart';

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({required this.url, super.key});

  final String url;

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  String? locationName;
  List<String>? residents;
  bool isLoading = false;
  String errorMessage = '';
  Character? character;

  @override
  void initState() {
    super.initState();
    getData();
  }

  LocationDetails? locationDetails;
  Future<void> getData() async {
    final dio = Dio();
    try {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(widget.url);
      if (response.statusCode == 200) {
        setState(() {
          locationDetails = LocationDetails.fromJson(response.data);
          locationName = locationDetails!.name;
          residents = locationDetails!.residents;
          isLoading = false;
        });
      } else {
        print('There is some problem ');
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          errorMessage = 'No Internet Connection';
        } else {
          errorMessage = error.message!;
        }
      } else {
        errorMessage = error.toString();
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Character?> getCharImage(charUrl) async {
    final dio = Dio();
    Character? character1;
    try {
      final response = await dio.get(charUrl);
      if (response.statusCode == 200) {
        character1 = Character.fromJson(response.data);
      } else {
        print('Some error occured');
      }
      return character1;
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          errorMessage = 'No Internet Connection';
        } else {
          errorMessage = error.message!;
        }
      } else {
        errorMessage = error.toString();
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(102, 102, 102, 100),
      appBar: AppBar(
        title: const Text('Location details '),
      ),
      body: (locationDetails == null)
          ? (isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      OutlinedButton(
                        onPressed: getData,
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location Name :  ${locationDetails!.name}',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white60)),
                Text('Location Type :  ${locationDetails!.type}',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white60)),
                Text('Location Dimension :  ${locationDetails!.dimension}',
                    style:
                        const TextStyle(fontSize: 20, color: Colors.white60)),
                const Text('Residents : ',
                    style: TextStyle(fontSize: 20, color: Colors.white60)),
                Expanded(
                  child: GridView.builder(
                    itemCount: residents?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11),
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                        future: getCharImage(residents![index]),
                        builder: (context, AsyncSnapshot<Character?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              return Column(
                                children: [
                                  ImageViewer(url: snapshot.data!.image),
                                ],
                              );
                            } else {
                              return Center(
                                child: Column(
                                  children: [
                                    const Text('Character not found'),
                                    ElevatedButton(
                                        onPressed: getData,
                                        child: const Text('Retry '))
                                  ],
                                ),
                              );
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Error: ${snapshot.error}'),
                                  ElevatedButton(
                                    onPressed: getData,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}

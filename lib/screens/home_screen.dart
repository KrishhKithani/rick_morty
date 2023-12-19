import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty_app/models/character.dart';
import 'package:rickandmorty_app/models/character_list.dart';
import 'package:rickandmorty_app/widgets/image_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color statusColor = Colors.white54;
  bool isLoading = false;
  String errorMessage = '';
  int? charIndex;
  String? nextListUrl;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  CharacterList? characterList;
  CharacterList? characterList2;
  List<Character>? characters;
  List<Character>? newList;
  Map? info;

  Future<void> fetchData() async {
    final dio = Dio();
    const url = 'https://rickandmortyapi.com/api/character';
    try {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        setState(() {
          characterList = CharacterList.fromJson(response.data);
          characters = characterList?.results;
          //characters?.shuffle();
          nextListUrl = characterList?.info["next"];
          isLoading = false;
          info = characterList?.info;
          //characterList1 = response.data['results'] as List;
        });
        print(characters![1].url);
      } else {
        print('There is some problem ');
      }
      print('API Response: $characters');
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          errorMessage = ' No internet connection ';
          print('Error: No internet connection');
        } else {
          errorMessage = error.message!;
          print('DioError: ${error.message}');
        }
      } else {
        errorMessage = error.toString();
        print('Unknown error: ${error.toString()}');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> appendList() async {
    final dio = Dio();
    final url = nextListUrl;
    try {
      //setState(() {

      isLoadingMore = true;

      //});

      await Future.delayed(const Duration(seconds: 10));
      final response = await dio.get(url!);
      if (response.statusCode == 200) {
        characterList2 = CharacterList.fromJson(response.data);
        newList = characterList2?.results;
        nextListUrl = characterList2?.info["next"];

        if (newList != null) {
          print('==================== nullll lissttt');
          characters?.addAll(newList!);
          setState(() {});
        }
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No Internet connection'),
              ),
            );
          }
        }
      }
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(102, 102, 102, 100),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Rick And Morty app 2 '),
      ),
      body: characters == null
          ? (isLoading)
              ? const Center(child: CircularProgressIndicator())
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
                        onPressed: fetchData, child: const Text('Retry'))
                  ],
                ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: characters!.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(index);
                      print(isLoadingMore);
                      print(characters!.length);

                      if (index == characters!.length - 1) {
                        appendList();
                      }
                      print('=============$isLoadingMore');

                      return Card(
                        color: const Color.fromRGBO(108, 112, 112, 100),
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          const SizedBox(width: 10),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80)),
                              child: ImageViewer(url: characters![index].image)
                              ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text((characters![index].id).toString()),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/charDetails',
                                        arguments: characters![index].url);
                                  },
                                  child: Text(
                                    characters![index].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          (characters![index].status ==
                                                  "unknown")
                                              ? Colors.white54
                                              : (characters![index].status ==
                                                      "Alive")
                                                  ? Colors.green
                                                  : Colors.red,
                                      radius: 6,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${characters![index].status} - ${characters![index].species}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Last Known Location :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/locationDetails',
                                        arguments:
                                            characters![index].location.url);
                                  },
                                  child: Text(characters![index].location.name,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('First Seen in :',
                                    style: TextStyle(color: Colors.grey)),
                                Text(characters![index].origin.name,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
                (isLoadingMore)
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
    );
  }
}

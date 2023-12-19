import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty_app/models/character.dart';
import 'package:rickandmorty_app/widgets/image_viewer.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({required this.url, super.key});
  final String url;

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  bool isLoading = false;
  String errorMessage = '';
  String charName = '';
  List<String>? episodes;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Character? character;
  Future<void> getData() async {
    final dio = Dio();
    final charUrl = widget.url;
    try {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(charUrl);
      if (response.statusCode == 200) {
        setState(() {
          character = Character.fromJson(response.data);
          charName = character!.name;
          episodes = character!.episode;
          isLoading = false;
        });
      } else {
        print('There is some problem ');
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(102, 102, 102, 100),
      appBar: AppBar(
        title: Text(charName),
      ),
      body: (character == null)
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
                        child: const Text('Retry button'),
                      )
                    ],
                  ),
                )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 400,
                      width: 400,
                      child:ImageViewer(
                          url: character!.image)
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name :  ${character!.name}',
                    style: const TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Gender :  ${character!.gender}',
                    style: const TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Species :  ${character!.species}',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Status :  ${character!.status}',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'First Seen at :  ${character!.origin.name}',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Current Location  :  ${character!.location.name}',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Episodes :',
                    style: TextStyle(fontSize: 25, color: Colors.white60),
                  ),
                  SizedBox(
                    // height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: episodes?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '${index + 1})  ${episodes![index]}',
                          style:
                              const TextStyle(fontSize: 16, color: Colors.blue),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

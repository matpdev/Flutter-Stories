// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  List<StoriesModel> stories = [
    StoriesModel(name: "Teste", content: const Text("data")),
    StoriesModel(name: "Teste", content: const Text("data 1")),
    StoriesModel(name: "Teste", content: const Text("data 3")),
    StoriesModel(name: "Teste", content: const Text("data 4")),
  ];

  late Timer timer;
  int timerCount = 0;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerCount++;
      });
      if (timerCount == 5) {
        if (activeIndex < stories.length - 1) {
          setState(() {
            timerCount = 0;
            activeIndex++;
          });
        } else {
          timer.cancel();
        }
      }
    });
  }

  void resetTimer() {
    setState(() {
      timer.cancel();
      timerCount = 0;
      startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: stories[activeIndex].content,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      for (var i = 0; i < stories.length; i++)
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                            width: 50,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.black
                                  .withOpacity(i <= activeIndex ? 1 : 0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: timer.isActive && activeIndex == i
                                ? LinearProgressIndicator(
                                    value: timerCount / 5,
                                  )
                                : null,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  if (activeIndex > 0) {
                    setState(() {
                      activeIndex--;
                      resetTimer();
                    });
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  if (activeIndex < stories.length - 1) {
                    setState(() {
                      activeIndex++;
                      resetTimer();
                    });
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StoriesModel {
  String name = "";
  Widget content;
  StoriesModel({
    required this.name,
    required this.content,
  });

  StoriesModel copyWith({
    String? name,
    Widget? content,
  }) {
    return StoriesModel(
      name: name ?? this.name,
      content: content ?? this.content,
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/colors.dart' as color;
import 'package:gym_app/screens/home_screen.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  List videoinfo = [];
  bool isPlayArea = false;
  bool isPlaying = false;
  late VideoPlayerController _controller;

  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/videoinfo.json").then((value) {
      setState(() {
        videoinfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: isPlayArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                    colors: [color.AppColor.gradientFirst.withOpacity(.9), color.AppColor.gradientSecond],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.topRight))
            : BoxDecoration(color: color.AppColor.gradientSecond),
        child: Column(children: [
          isPlayArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const HomePage());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Legs Toning",
                        style: TextStyle(fontSize: 25, color: color.AppColor.secondPageTitleColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "and Glutes Workouts",
                        style: TextStyle(fontSize: 25, color: color.AppColor.secondPageTitleColor),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  color.AppColor.secondPageContainerGradient1stColor,
                                  color.AppColor.secondPageContainerGradient2ndColor
                                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "68 min",
                                style: TextStyle(fontSize: 16, color: color.AppColor.secondPageIconColor),
                              )
                            ]),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 250,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  color.AppColor.secondPageContainerGradient1stColor,
                                  color.AppColor.secondPageContainerGradient2ndColor
                                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(
                                Icons.handyman_outlined,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Resistent band, kettebel",
                                style: TextStyle(fontSize: 16, color: color.AppColor.secondPageIconColor),
                              )
                            ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                debugPrint("tapped");
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info,
                              size: 20,
                              color: color.AppColor.secondPageTopIconColor,
                            )
                          ],
                        ),
                      ),
                      _playView(context),
                      _controlView(context),
                    ],
                  ),
                ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Circuit 1 : Legs Toning",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color.AppColor.circuitsColor),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(
                          Icons.loop,
                          size: 30,
                          color: color.AppColor.loopColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "3 sets",
                          style: TextStyle(fontSize: 15, color: color.AppColor.setsColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        itemCount: videoinfo.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              _onTapVideo(index);
                              debugPrint(index.toString());
                              setState(() {
                                if (isPlayArea == false) {
                                  isPlayArea = true;
                                }
                              });
                            },
                            child: Container(
                              height: 135,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(videoinfo[index]['thumbnail']), fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            videoinfo[index]['title'],
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3),
                                            child: Text(
                                              videoinfo[index]['time'],
                                              style: TextStyle(color: Colors.grey[500]),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffeaeefc), borderRadius: BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            "15s rest",
                                            style: TextStyle(color: Color(0xff839fed)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < 70; i++)
                                            i.isEven
                                                ? Container(
                                                    width: 3,
                                                    height: 1,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xff839fed),
                                                        borderRadius: BorderRadius.circular(2)),
                                                  )
                                                : Container(
                                                    height: 1,
                                                    width: 3,
                                                    color: Colors.white,
                                                  ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ))
        ]),
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;

    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            "Preparing ....",
            style: TextStyle(fontSize: 20, color: Colors.white60),
          )));
    }
  }

  Widget _controlView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {},
              child: const Icon(
                Icons.fast_rewind,
                size: 36,
                color: Colors.white,
              )),
          ElevatedButton(
              onPressed: () async {
                if (isPlaying) {
                  setState(() {
                    isPlaying = false;
                  });
                  _controller.pause();
                } else {
                  setState(() {
                    isPlaying = true;
                  });
                  _controller.play();
                }
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36,
                color: Colors.white,
              )),
          ElevatedButton(
              onPressed: () async {},
              child: const Icon(
                Icons.fast_forward,
                size: 36,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  void _onControllerUpdate() async {
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller cannot be initailized");
    }
    final playing = controller.value.isPlaying;
    isPlayArea = playing;
  }

  _onTapVideo(int index) {
    final controller = VideoPlayerController.network(videoinfo[index]['videoUrl']);
    _controller = controller;

    setState(() {});
    controller
      ..initialize().then((_) {
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }
}

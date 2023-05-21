// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import "package:gym_app/colors.dart" as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List<Video> videoList = [];
  bool _playArea = false;
  bool _isPlaying = true;
  bool _disposed = false;
  int _isPlayingIndex = 0;
  String _curPos = "";
  String _totalPos = "";
  String _videoTime = "00:00";
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  _initData() async {
    if (_controller != null) {
      //如果视频控制器存在，清理掉重新创建
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
    }
    if (_initializeVideoPlayerFuture != null) {
      _initializeVideoPlayerFuture = null;
    }
    var res = await DefaultAssetBundle.of(context).loadString("json/videoinfo.json");
    var resInfo = json.decode(res);

    setState(() {
      videoList = List<Video>.from(resInfo.map((x) => Video.fromJson(x)));
      // print(videoList);
    });
  }

  void _videoListener() {
    print("_videoListener");
    var curPosition = _controller?.value.position;
    var totalPosition = _controller?.value.duration;
    setState(() {
      _curPos = curPosition.toString().substring(2, 7);
      _totalPos = totalPosition.toString().substring(2, 7);
      _videoTime = "${_curPos}/${_totalPos}";
    });
    print("当前位置${_curPos}，全部${_totalPos}");
    //如果当前位置是最后的位置就跳到下一个
    if (curPosition.toString() != "0:00:00.000000" && curPosition == totalPosition) {
      setState(() {
        _isPlayingIndex = _isPlayingIndex + 1;
        if (_isPlayingIndex >= videoList.length) {
          //循环回到第一首
          _isPlayingIndex = 0;
        }
      });
      _playVideo(videoList.elementAt(_isPlayingIndex).videoUrl!);
    }
  }

  _playVideo(String url) {
    setState(() {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
      _initializeVideoPlayerFuture = null;
      _curPos = "";
      _totalPos = "";
      _videoTime = "";
      _controller = VideoPlayerController.network(url);

      _initializeVideoPlayerFuture = _controller?.initialize().then((_) {
        _controller?.seekTo(Duration(milliseconds: 0));
        _controller?.play();
        _controller?.addListener(_videoListener);
      });
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _controller = null;
    _initializeVideoPlayerFuture = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: color.AppColor.homePageBackground,
            body: CustomScrollView(slivers: [
              SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                  sliver: SliverToBoxAdapter(
                      child: Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 25),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [color.AppColor.gradientFirst.withOpacity(0.9), color.AppColor.gradientSecond],
                      begin: const FractionalOffset(0.0, 0.4),
                      end: Alignment.topRight,
                    )),
                    child: Column(
                      children: [
                        _playArea == false
                            ? Container(
                                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                                height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(Icons.arrow_back_ios,
                                              size: 20, color: color.AppColor.secondPageIconColor),
                                        ),
                                        Expanded(child: Container()),
                                        Icon(Icons.info_outline, size: 20, color: color.AppColor.secondPageIconColor),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Legs Toning",
                                      style: TextStyle(fontSize: 16, color: color.AppColor.secondPageTitleColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "and Glutes Workout",
                                      style: TextStyle(fontSize: 16, color: color.AppColor.secondPageTitleColor),
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
                                              gradient: LinearGradient(
                                                colors: [
                                                  color.AppColor.secondPageContainerGradient1stColor,
                                                  color.AppColor.secondPageContainerGradient2ndColor
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                              )),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
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
                                                style:
                                                    TextStyle(fontSize: 14, color: color.AppColor.secondPageIconColor),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 250,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.secondPageContainerGradient1stColor,
                                                    color.AppColor.secondPageContainerGradient2ndColor
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                )),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.handyman_outlined,
                                                  size: 20,
                                                  color: color.AppColor.secondPageIconColor,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Resistent band, kettebell",
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontSize: 14, color: color.AppColor.secondPageIconColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                            : Container(
                                padding: const EdgeInsets.only(top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(left: 30, right: 30),
                                        margin: const EdgeInsets.only(bottom: 30),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Icon(Icons.arrow_back_ios,
                                                    size: 20, color: color.AppColor.secondPageTopIconColor)),
                                            Expanded(child: Container()),
                                            Icon(Icons.info_outline,
                                                size: 20, color: color.AppColor.secondPageTopIconColor)
                                          ],
                                        )),
                                    Container(
                                      width: 325,
                                      height: 200,
                                      child: FutureBuilder(
                                        future: _initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return _controller == null
                                                ? Container()
                                                : AspectRatio(
                                                    aspectRatio: _controller!.value.aspectRatio,
                                                    child: Stack(
                                                      alignment: Alignment.bottomCenter,
                                                      children: <Widget>[
                                                        VideoPlayer(_controller!),
                                                        VideoProgressIndicator(
                                                          _controller!,
                                                          allowScrubbing: true,
                                                          colors: const VideoProgressColors(playedColor: Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    _controlView(context),
                                  ],
                                )),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "Circuit 1: Legs Toning",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold, color: color.AppColor.circuitsColor),
                                  ),
                                  Expanded(child: Container()),
                                  Row(
                                    children: [
                                      Icon(Icons.loop, size: 30, color: color.AppColor.loopColor),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "3 sets",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: color.AppColor.setsColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 25,
                ),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (content, index) {
                    var item = videoList.elementAt(index);
                    print(item);
                    return _buildCard(content, index, item);
                  },
                  childCount: videoList.length,
                )),
              ),
            ])));
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 5, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ]),
                  child: Icon(
                    noMute ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                if (noMute) {
                  _controller?.setVolume(0);
                } else {
                  _controller?.setVolume(1.0);
                }
                setState(() {});
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isPlayingIndex = _isPlayingIndex - 1;
                  });
                  if (_isPlayingIndex < 0) {
                    setState(() {
                      _isPlayingIndex = 0;
                    });
                    Get.snackbar(
                      "Video List",
                      "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 30,
                        color: Colors.white,
                      ),
                      backgroundColor: color.AppColor.gradientSecond,
                      colorText: Colors.white,
                      messageText: const Text(
                        "No videos ahead !",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                    return;
                  }
                  var video_item = videoList.elementAt(_isPlayingIndex);
                  _playVideo(video_item.videoUrl!);
                },
                child: const Icon(
                  Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,
                )),
            ElevatedButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,
                )),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isPlayingIndex = _isPlayingIndex + 1;
                  });
                  if (_isPlayingIndex >= videoList.length) {
                    setState(() {
                      _isPlayingIndex = _isPlayingIndex - 1;
                    });
                    Get.snackbar("Video List", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: const Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: color.AppColor.gradientSecond,
                        colorText: Colors.white,
                        messageText: const Text(
                          "You have finished watching all the videos. Congrats !",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ));
                    return;
                  }
                  var video_item = videoList.elementAt(_isPlayingIndex);
                  _playVideo(video_item.videoUrl!);
                },
                child: const Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                )),
            Container(
              width: 100,
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "${_videoTime}",
                style: const TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  _buildCard(BuildContext context, int index, Video item) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_playArea == false) {
              _playArea = true;
            }
            _isPlayingIndex = index;
          });
          if (item.videoUrl != null) {
            _playVideo(item.videoUrl!);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(videoList.elementAt(index).thumbnail ?? ""), fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 160,
                          child: Text(
                            "${videoList.elementAt(index).title}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "${videoList.elementAt(index).time}",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFeaeefc),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "15s rest",
                        style: TextStyle(color: Color(0xFF839fed)),
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
                                    color: const Color(0xFF839fed), borderRadius: BorderRadius.circular(2)),
                              )
                            : Container(width: 3, height: 1, color: Colors.white)
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class Video {
  String? title;
  String? time;
  String? thumbnail;
  String? videoUrl;

  Video({
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        time: json["time"],
        thumbnail: json["thumbnail"],
        videoUrl: json["videoUrl"],
      );
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/colors.dart' as color;
import 'package:gym_app/screens/video_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() async {
    await DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      setState(() {
        info = json.decode(value);
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
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Training",
                    style: TextStyle(fontSize: 30, color: color.AppColor.homePageTitle, fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                  const SizedBox(width: 15),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Your Program",
                    style: TextStyle(fontSize: 20, color: color.AppColor.homePageSubtitle, fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "Details",
                    style: TextStyle(fontSize: 20, color: color.AppColor.homePageDetail),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const VideoApp());
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: color.AppColor.homePageIcons,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      color.AppColor.gradientFirst.withOpacity(0.8),
                      color.AppColor.gradientSecond.withOpacity(.9),
                    ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 10,
                          color: color.AppColor.gradientSecond.withOpacity(.2))
                    ]),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Next Workout",
                      style: TextStyle(fontSize: 16, color: color.AppColor.homePageContainerTextSmall),
                    ),
                    Text(
                      "Legs Toning",
                      style: TextStyle(fontSize: 25, color: color.AppColor.homePageContainerTextSmall),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "and Glutes Workouts",
                      style: TextStyle(fontSize: 25, color: color.AppColor.homePageContainerTextSmall),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: color.AppColor.homePageContainerTextSmall,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "60 min",
                              style: TextStyle(fontSize: 14, color: color.AppColor.homePageContainerTextSmall),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.play_circle_fill,
                          size: 60,
                          color: Colors.white,
                        )
                      ],
                    )
                  ]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(image: AssetImage("assets/card.png"), fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: const Offset(-1, -5),
                                color: color.AppColor.gradientSecond.withOpacity(.3))
                          ]),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 200, bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(image: AssetImage("assets/figure.png")),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      // color: color.AppColor.gradientFirst.withOpacity(.2),
                      margin: const EdgeInsets.only(left: 150, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You are doing great",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: color.AppColor.homePageDetail),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Keep it up",
                            style: TextStyle(fontSize: 16, color: color.AppColor.homePagePlanColor),
                          ),
                          Text(
                            "Stick to your Plan",
                            style: TextStyle(fontSize: 16, color: color.AppColor.homePagePlanColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Area of Focus",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: color.AppColor.homePageTitle),
                  )
                ],
              ),
              Expanded(
                  child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      itemCount: (info.length.toDouble() / 2).toInt(),
                      itemBuilder: (_, i) {
                        int a = 2 * i;
                        int b = 2 * i + 1;
                        return Row(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 90) / 2,
                              height: 170,
                              margin: const EdgeInsets.only(left: 30, bottom: 15, top: 15),
                              padding: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: AssetImage(info[a]['img'])),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(-5, -5),
                                        color: color.AppColor.gradientSecond.withOpacity(.2)),
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: color.AppColor.gradientSecond.withOpacity(.2))
                                  ]),
                              child: Center(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[a]['title'],
                                  style: TextStyle(fontSize: 20, color: color.AppColor.homePageDetail),
                                ),
                              )),
                            ),
                            Container(
                              height: 170,
                              width: (MediaQuery.of(context).size.width - 90) / 2,
                              margin: const EdgeInsets.only(left: 30, bottom: 15, top: 15),
                              padding: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: AssetImage(info[b]['img'])),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(-5, -5),
                                        color: color.AppColor.gradientSecond.withOpacity(.2)),
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: color.AppColor.gradientSecond.withOpacity(.2))
                                  ]),
                              child: Center(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[b]['title'],
                                  style: TextStyle(fontSize: 20, color: color.AppColor.homePageDetail),
                                ),
                              )),
                            ),
                          ],
                        );
                      }),
                ),
              ))
            ],
          )),
    );
  }
}

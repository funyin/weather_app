import 'package:flutter/material.dart';
import 'package:weather_app/resources/r.dart';
import 'package:weather_app/ui/navigation/app_router.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController();
  final pageNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.addListener(() {
        pageNotifier.value = pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [R.colors.seaBlue, R.colors.skyBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                    iconSize: 32,
                    padding: EdgeInsets.all(24),
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("London,", style: TextStyle(fontSize: 26)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text("United Kingdon",
                                style: TextStyle(fontSize: 26)),
                          ),
                          Text("Sat, 6 Aug"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: 2,
                        controller: pageController,
                        itemBuilder: (context, index) =>
                            const WeatherPageItem(),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValueListenableBuilder<double>(
                      valueListenable: pageNotifier,
                      builder: (context, value, child) {
                        return Wrap(
                          spacing: 16,
                          children: [
                            buildSectionText("Today", value.round() == 0, () {
                              animePageController(0);
                            }),
                            buildSectionText("Tomorrow", value.round() == 1,
                                () {
                              animePageController(1);
                            }),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildSectionText("Next 7 Days", false, () {
                                  Navigator.pushNamed(
                                      context, AppRouter.nextDaysScreen);
                                }),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: R.colors.offYellow,
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 68),
                child: SizedBox(
                  height: 186,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    clipBehavior: Clip.none,
                    child: Container(
                      decoration: BoxDecoration(
                          color: R.colors.offSkyBlue,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                                color: R.colors.seaBlue.withOpacity(0.3),
                                spreadRadius: -4,
                                blurRadius: 6,
                                offset: Offset(0, 2))
                          ]),
                      padding: EdgeInsets.all(24),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    color: R.colors.offSeaBlue,
                                    borderRadius: BorderRadius.circular(40)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("9AM"),
                                    Expanded(
                                      child: Icon(
                                        Icons.cloud_queue_outlined,
                                        size: 26,
                                      ),
                                    ),
                                    Text("16°")
                                  ],
                                ),
                              ),
                          separatorBuilder: (_, __) => SizedBox(width: 16),
                          itemCount: 24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> animePageController(int page) =>
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

  Widget buildSectionText(String text, bool active, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
            fontSize: 18, color: active ? Colors.white : R.colors.offYellow),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

class WeatherPageItem extends StatelessWidget {
  const WeatherPageItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Today",
          style: TextStyle(fontSize: 26),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.sunny,
                size: 52,
                color: Colors.yellow,
              ),
              SizedBox(width: 16),
              Text(
                "22 º",
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Text(
          "Sunny",
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

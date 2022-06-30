import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/resources/r.dart';

class NextDaysScreen extends StatefulWidget {
  NextDaysScreen({Key? key}) : super(key: key);

  @override
  State<NextDaysScreen> createState() => _NextDaysScreenState();
}

class _NextDaysScreenState extends State<NextDaysScreen> {
  var scrollController = ScrollController();
  var scrollNotifier = ValueNotifier(0.0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        scrollNotifier.value = scrollController.offset;
        if (kDebugMode) {
          print(scrollController.offset);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          textTheme: TextTheme(
              bodyText2: TextStyle(
                  color: R.colors.deepBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))),
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 150,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    flexibleSpace: ValueListenableBuilder<double>(
                        valueListenable: scrollNotifier,
                        builder: (context, value, child) {
                          return FlexibleSpaceBar(
                            title: Text(
                              "Next 7 Days",
                              style: TextStyle(color: R.colors.deepBlue),
                            ),
                            expandedTitleScale: 1.8,
                            titlePadding: EdgeInsets.only(
                              left: value < 56 ? 24 : 56 * value / 150,
                              bottom: value > 150 ? 24 : 16,
                            ),
                          );
                        }),
                  )
                ];
              },
              body: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 80, horizontal: 24),
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text("Sunday")),
                    Icon(
                      Icons.thunderstorm_outlined,
                      color: R.colors.deepBlue,
                      size: 26,
                    ),
                    SizedBox(width: 36),
                    Text("12 °")
                  ],
                ),
                itemCount: 7,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 48),
              )),
        ),
      ),
    );
  }
}

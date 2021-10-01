import 'package:covid_statistics_210927/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics_210927/src/components/bar_chart.dart';
import 'package:covid_statistics_210927/src/components/covid_statistics_viewer.dart';
import 'package:covid_statistics_210927/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);
  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            ' : $value',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  List<Widget> _background() {
    return [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color(0xFFEBC2C2), Color(0xFFEBC2C2)],
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 5,
        left: -10,
        child: Container(
          child: Image.asset(
            'assets/images/covid.png',
            width: Get.size.width * 0.5,
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 5,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFCE8E8E)),
              child: Obx(
                () => Text(
                  controller.todayData.standardDayString,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 30,
        child: Obx(
          () => CovidStatisticsViewer(
            addedCount: controller.todayData.calcDecideCnt,
            title: '확진자',
            totalCount: controller.todayData.decideCnt ?? 0,
            upDown:
                controller.calculateUpDown(controller.todayData.calcDecideCnt),
          ),
        ),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CovidStatisticsViewer(
              addedCount: controller.todayData.calcClearCnt,
              title: '격리해제',
              totalCount: controller.todayData.clearCnt ?? 0,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xFF8F8A8A),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
                addedCount: controller.todayData.calcExamCnt,
                title: '검사 중',
                totalCount: controller.todayData.examCnt ?? 0,
                upDown: ArrowDirection.DOWN,
                dense: true),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xFF8F8A8A),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              addedCount: controller.todayData.calcDeathCnt,
              title: '사망자',
              totalCount: controller.todayData.deathCnt ?? 0,
              upDown: ArrowDirection.MIDDLE,
              dense: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '확진자 추이',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Obx(
              () => controller.weekDays.length == 0
                  ? Container()
                  : CovidBarChart(
                      covidDatas: controller.weekDays,
                      maxY: controller.maxDecideValue,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          '코로나 일별 현황',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ..._background(),
          Positioned(
            top: headerTopZone + 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      _todayStatistics(),
                      SizedBox(
                        height: 20,
                      ),
                      _covidTrendsChart(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

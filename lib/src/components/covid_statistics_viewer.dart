import 'package:covid_statistics_210927/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics_210927/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CovidStatisticsViewer extends StatelessWidget {
  final String title; //CovidStatisticsViewer의 맨 윗줄
  final double addedCount; //CovidStatisticsViewer의 가운데 줄
  final ArrowDirection upDown; //CovidStatisticsViewer의 화살표
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color subValueColor;
  final double spacing;

  CovidStatisticsViewer({
    Key? key,
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.titleColor = const Color(0xff4c4e5d),
    this.spacing = 10,
    this.subValueColor = Colors.black,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    switch (upDown) {
      case ArrowDirection.UP:
        color = Color(0xFFF32E14);
        break;
      case ArrowDirection.MIDDLE:
        break;
      case ArrowDirection.DOWN:
        color = Color(0xff3749be);
    }

    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: dense ? 14 : 18,
            ),
          ),
          SizedBox(
            height: spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: ArrowClipPath(direction: upDown),
                // clipper는 도형을 어떻게 할거냐? 이건데, 캔버스에 있는 path를 사용해서 적용
                // path를 그려줄  class를 하나 생성해야 함
                child: Container(
                  width: dense ? 10 : 20,
                  height: dense ? 10 : 20,
                  color: color,
                ),
              ),
              SizedBox(width: 5),
              Text(
                DataUtils.numberFormat(addedCount),
                style: TextStyle(
                  color: color,
                  fontSize: dense ? 25 : 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing * 0.5),
          Text(
            DataUtils.numberFormat(totalCount),
            style: TextStyle(
              color: subValueColor,
              fontSize: dense ? 15 : 20,
            ),
          ),
        ],
      ),
    );
  }
}

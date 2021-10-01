import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>2.2916883087</accDefRate>
                <accExamCnt>14365935</accExamCnt>
                <accExamCompCnt>13245824</accExamCompCnt>
                <careCnt>31965</careCnt>
                <clearCnt>269132</clearCnt>
                <createDt>2021-09-27 10:08:41.366</createDt>
                <deathCnt>2456</deathCnt>
                <decideCnt>303553</decideCnt>
                <examCnt>1120111</examCnt>
                <resutlNegCnt>12942271</resutlNegCnt>
                <seq>648</seq>
                <stateDt>20210927</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accDefRate>2.2765913507</accDefRate>
                <accExamCnt>14325938</accExamCnt>
                <accExamCompCnt>13229076</accExamCompCnt>
                <careCnt>30582</careCnt>
                <clearCnt>268140</clearCnt>
                <createDt>2021-09-26 09:38:04.296</createDt>
                <deathCnt>2450</deathCnt>
                <decideCnt>301172</decideCnt>
                <examCnt>1096862</examCnt>
                <resutlNegCnt>12927904</resutlNegCnt>
                <seq>647</seq>
                <stateDt>20210926</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>2</totalCount>
    </body>
</response>''';

  test('코로나 전체 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    var covid19Statistics = <Covid19StatisticsModel>[];
    items.forEach((node) {
      covid19Statistics.add(Covid19StatisticsModel.fromXml(node));
    });
    print('${covid19Statistics.length}일치 데이터');
    covid19Statistics.forEach((covid19) {
      print('날짜 : ${covid19.stateDt} & 확진자수 : ${covid19.decideCnt}명');
    });
  });
}

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;
  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResult(xml, 'accDefRate'),
      accExamCnt: XmlUtils.searchResult(xml, 'accDefRate'),
      accExamCompCnt: XmlUtils.searchResult(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResult(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResult(xml, 'clearCnt'),
      createDt: XmlUtils.searchResult(xml, 'createDt'),
      deathCnt: XmlUtils.searchResult(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResult(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResult(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResult(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResult(xml, 'seq'),
      stateDt: XmlUtils.searchResult(xml, 'stateDt'),
      stateTime: XmlUtils.searchResult(xml, 'stateTime'),
      updateDt: XmlUtils.searchResult(xml, 'updateDt'),
    );
  }
}

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
}

import 'dart:ui';
//阅读页背景色配置
class SetConf {
  static const bgColor = [
    Color.fromRGBO(237, 226, 199, 1),
    Color.fromRGBO(202, 223, 199, 1),
    Color.fromRGBO(214, 188, 136, 1),
    Color.fromRGBO(235, 235, 235, 1),
    Color.fromRGBO(219, 194, 193, 1),
    Color.fromRGBO(102, 113, 126, 1),
    Color.fromRGBO(57, 60, 56, 1),
    Color.fromRGBO(134, 125, 124, 1),
    Color.fromRGBO(115, 125, 105, 1),
    Color.fromRGBO(12, 12, 12, 1)
  ];

  static const fontColor = [
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(32, 19, 3, 1),
    Color.fromRGBO(240, 240, 240, 1),
    Color.fromRGBO(37, 37, 37, 1),
    Color.fromRGBO(20, 47, 16, 1),
    Color.fromRGBO(210, 210, 210, 1),
  ];

  static const Map<eBgColorRGB, List<double>> bgColorRGB = {
    eBgColorRGB.R: [178, 214, 190, 12],
    eBgColorRGB.G: [171, 214, 217, 12],
    eBgColorRGB.B: [153, 214, 186, 12],
  };
}

enum eBgColorRGB { R, G, B }

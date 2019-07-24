import 'package:flutter/material.dart';
import 'package:ns/analysis/ZSData.dart';
import 'package:ns/config/StoreFilterConfig.dart';
import 'package:ns/notifier/store/FilterNotifier.dart';
import 'package:ns/notifier/store/StoreParamsNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:provide/provide.dart';

class ComFilter extends StatefulWidget {
  final String _type;
  final String _catelog;
  ComFilter(this._type, this._catelog);

  @override
  _ComFilterState createState() => _ComFilterState();
}

class _ComFilterState extends State<ComFilter> {
  @override
  Widget build(BuildContext context) {
    return Provide<FilterNotifier>(
      builder: (context, child, nFilter) {
        return Offstage(
          offstage: !nFilter.show,
          child: Container(
            height: 82.0,
            alignment: Alignment.topCenter,
            color: ColorUtils.WHITE,
            child: FutureBuilder(
              future: ZSData.getSubCateList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text("无法获得子菜单列表，请稍后再试。"));
                List catelogs = snapshot.data[widget._type];
                var catelog = catelogs.firstWhere(
                  (catelog) => catelog["major"] == widget._catelog,
                );
                return Column(
                  children: [
                    _buildFilterItem(),
                    _divider(),
                    _buildZSFilterItem(["全部"]..addAll(catelog["mins"])),
                    _divider(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _divider() {
    return Divider(height: 1.0, color: ColorUtils.DIVIDER);
  }

  Widget _buildZSFilterItem(List datas) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Provide<StoreParamsNotifier>(
        builder: (context, child, nParams) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: datas.map((data) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      data,
                      style: TextStyle(
                        color: data == nParams.params.minor
                            ? ColorUtils.MAIN
                            : ColorUtils.FONT_LABEL,
                      ),
                    ),
                  ),
                  onTap: () => nParams.setSubcate(data),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterItem() {
    var types = StoreFilterConfig.config;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Provide<StoreParamsNotifier>(
        builder: (context, child, nParams) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: types.map((type) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      type.title,
                      style: TextStyle(
                        color: type.code == nParams.params.type
                            ? ColorUtils.MAIN
                            : ColorUtils.FONT_LABEL,
                      ),
                    ),
                  ),
                  onTap: () => nParams.setFilterType(type.code),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

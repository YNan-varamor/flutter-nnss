import 'package:flutter/material.dart';
import 'package:ns/analysis/ZSData.dart';
import 'package:ns/pages/Store/StoreListPage.dart';
import 'package:ns/utils/const/ColorUtils.dart';

class CatelogPage extends StatelessWidget {
  final String _type;
  CatelogPage(this._type);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.WHITE,
      child: FutureBuilder(
        future: ZSData.getCateList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Center(child: Text("书库接口不稳定，请稍后再试。"));
            }
            var datas = snapshot.data;
            List catelogs = datas[_type];
            return ListView.separated(
              itemCount: catelogs.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(catelogs[i]["name"]),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StoreListPage(
                        _type,
                        catelogs[i]["name"],
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (context, i) => Divider(
                height: 1.0,
                color: ColorUtils.DIVIDER,
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ns/notifier/store/FilterNotifier.dart';
import 'package:ns/notifier/store/StoreParamsNotifier.dart';
import 'package:ns/utils/const/ColorUtils.dart';
import 'package:ns/widgets/components/store/ComFilter.dart';
import 'package:ns/widgets/components/store/ComStoreBookList.dart';

import 'package:ns/widgets/custom/CAppBar.dart';
import 'package:provide/provide.dart';

class StoreListPage extends StatefulWidget {
  final String _type;
  final String _catelog;
  StoreListPage(this._type, this._catelog);

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  @override
  Widget build(BuildContext context) {
    //隐藏过滤栏
    var nFilter = Provide.value<FilterNotifier>(context)..hide();
    //初始化参数
    Provide.value<StoreParamsNotifier>(context).setParams(
      widget._type,
      widget._catelog,
    );

    return Scaffold(
      appBar: CAppBar(
        context,
        Text(widget._catelog),
        true,
        actions: [
          IconButton(
            icon: ImageIcon(
              AssetImage("images/filter.png"),
              color: ColorUtils.WHITE,
              size: 25.0,
            ),
            onPressed: () => nFilter.toggle(),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ComStoreBookList(),
        ComFilter(widget._type, widget._catelog),
      ],
    );
  }
}

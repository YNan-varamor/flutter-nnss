import 'package:flutter/material.dart';
import 'package:ns/notifier/rank/RankParamsNotifier.dart';
import 'package:ns/widgets/components/rank/ComMenu.dart';
import 'package:ns/widgets/components/rank/ComRankBookList.dart';
import 'package:ns/widgets/custom/CAppBar.dart';

import 'package:provide/provide.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context,
        Provide<RankParamsNotifier>(
          builder: (context, child, nParams) {
            return Text("排行榜 - " + nParams.params.title);
          },
        ),
        false,
      ),
      body: Row(
        children: [ComMenu(), Expanded(child: ComRankBookList())],
      ),
    );
  }
}

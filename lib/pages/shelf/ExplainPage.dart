import 'package:flutter/material.dart';
import 'package:ns/utils/common/HttpUtils.dart';
import 'package:ns/utils/const/UrlUtils.dart';

class ExplainPage extends StatelessWidget {
  final String title;
  final String url;
  ExplainPage(this.title, this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 143, 214, 1),
        elevation: 0,
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: HttpUtils.getHtml("${UrlUtils.oss_explain}$url.txt"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(snapshot.data),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

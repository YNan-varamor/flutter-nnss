class DbConf {
  //数据库
  static const String dbName = "db0.db";
  //添加书架表语句
  static const String sqlShelf = '''create table tShelf(
    bookId text primary key,
    unionId text not null,
    bookName text,
    avatar text,
    author text,
    code text,
    follow int,
    cTitle text,
    cUrl text,
    cPage int
  )''';
  //添加设置表语句
  static const String sqlReadSet = '''create table tSet(
    bgColor int,
    fontSize double
  )''';
}

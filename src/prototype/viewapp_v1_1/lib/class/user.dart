// ignore_for_file: camel_case_types, non_constant_identifier_names

/*使用者資訊*/
class userData {
  final String? serverSource;
  final String? username;
  final String? LoginName;

  userData({this.serverSource, this.username, this.LoginName});
}

/*忘記密碼時*/
class userMeta {
  final String? serverSource;
  final String? username;
  final String? LoginName;
  final String? email;

  userMeta({this.serverSource, this.username, this.LoginName, this.email});
}

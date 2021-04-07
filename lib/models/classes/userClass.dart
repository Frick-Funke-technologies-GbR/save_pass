
class UserClass {
  String username;
  String lastname;
  String firstname;
  String email;
  String password;
  String userIdent;
  int id;

  UserClass(this.username, this.lastname, this.firstname, this.email, this.password, this.id, this.userIdent);

  factory UserClass.fromJson(Map<String, dynamic> parsedJson) {
    return UserClass(
      parsedJson['username'],
      parsedJson['lastname'],
      parsedJson['firstname'],
      parsedJson['emailadress'],
      parsedJson['password'],
      parsedJson['id'],
      parsedJson['user_ident']
      );
  }

}
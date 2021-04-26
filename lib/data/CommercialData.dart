class User {
  int userId;
  String firstName;
  String lastName;

  User({this.userId, this.firstName, this.lastName});

  static List<User> getUsers() {
    return <User>[
      User(
          userId: 1,
          firstName: "Office Move / Commercial Move",
          lastName: "Jackson"),
      User(
          userId: 2,
          firstName: "Industrial / Factory / Plant Relocation",
          lastName: "John"),
      User(
          userId: 3,
          firstName: "Heavy Equipment and Machinery Move",
          lastName: "Brown"),
    ];
  }
}

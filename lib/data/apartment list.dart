import 'Item Choices.dart';

class Apartment {
  bool selected;
  String name;
  List<PreDefinedItems> items;

  Apartment({this.selected, this.name, this.items});

  Apartment.fromJson(Map<String, dynamic> json) {
    name = json['type'];
    // selected = json['id'];
    // items = json['custom'];
  }

  // static List<Apartment> getApartments() {
  //   return <Apartment>[
  //     Apartment(
  //       apartmentId: 0,
  //       name: "Single Items",
  //     ),
  //     Apartment(
  //       apartmentId: 1,
  //       name: "1 BHK Apartment",
  //     ),
  //     Apartment(
  //       apartmentId: 2,
  //       name: "2 BHK Apartment",
  //     ),
  //     Apartment(
  //       apartmentId: 3,
  //       name: "3 BHK Apartment",
  //     ),
  //     Apartment(
  //       apartmentId: 4,
  //       name: "3+ BHK Apartment",
  //     ),
  //   ];
  //}
}

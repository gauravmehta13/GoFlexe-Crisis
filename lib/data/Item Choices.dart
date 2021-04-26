class AdditionalItems {
  int id;
  String name;
  String description;
  String dimensions;
  String imgUrl;
  int value;

  AdditionalItems(
      {this.name, this.description, this.value, this.dimensions, this.imgUrl});

  static List<AdditionalItems> getAdditionalItems() {
    return <AdditionalItems>[
      AdditionalItems(
          name: "AC",
          description: "Large appliances",
          imgUrl: "assets/AC.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Single Bed",
          description: "Furniture",
          imgUrl: "assets/Single Bed.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Dressing Table",
          description: "Furniture",
          imgUrl: "assets/Dressing Table.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Folding Table",
          description: "Furniture",
          imgUrl: "assets/Folding Table.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Music System",
          description: "Large appliances",
          imgUrl: "assets/Music System.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Piano",
          description: "Misc",
          imgUrl: "assets/Piano.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Treadmill",
          description: "Large appliances",
          imgUrl: "assets/Treadmill.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
      AdditionalItems(
          name: "Extra Boxes",
          description: "Misc",
          imgUrl: "assets/box.png",
          dimensions: "23 x 45 x 2 feet",
          value: 1),
    ];
  }

  static List<AdditionalItems> getFixedItems() {
    return <AdditionalItems>[
      AdditionalItems(
          name: "Bed",
          description: "Furniture",
          imgUrl: "assets/bed.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "Cupboard",
          description: "Furniture",
          imgUrl: "assets/cupboard.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "TV",
          description: "Large appliances",
          imgUrl: "assets/TV.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "Fridge",
          description: "Large appliances",
          imgUrl: "assets/Refridgerator.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "Washing Machine",
          description: "Large appliances",
          imgUrl: "assets/Washing Machine.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "Dining Table",
          description: "Furniture",
          imgUrl: "assets/Dining Table.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
      AdditionalItems(
          name: "Sofa",
          description: "Furniture",
          imgUrl: "assets/Sofa.png",
          dimensions: "23 x 45 x 2 feet",
          value: 0),
    ];
  }
}

// Map<dynamic, dynamic> OneBHK = {
//   'items': {
//     'bed': {
//       "name": "bed",
//       "description": "Large appliances",
//       "imgUrl": "assets/AC.png",
//       "dimensions": "23 x 45 x 2 feet",
//       "value": 0
//     }
//   }
// };

// class Items {
//   List<CategoryMapping> categoryMapping;
//   List<Null> allItems;

//   Items({this.categoryMapping, this.allItems});

//   Items.fromJson(Map<String, dynamic> json) {
//     if (json['categoryMapping'] != null) {
//       categoryMapping = new List<CategoryMapping>();
//       json['categoryMapping'].forEach((v) {
//         categoryMapping.add(new CategoryMapping.fromJson(v));
//       });
//     }
//     if (json['allItems'] != null) {
//       allItems = new List<Null>();
//       json['allItems'].forEach((v) {
//         allItems.add(new Null.fromJson(v));
//       });
//     }
//   }
// }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.categoryMapping != null) {
//       data['categoryMapping'] =
//           this.categoryMapping.map((v) => v.toJson()).toList();
//     }
//     if (this.allItems != null) {
//       data['allItems'] = this.allItems.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class CategoryMapping {
  String type;
  List<Custom> custom;

  CategoryMapping({this.type, this.custom});

  CategoryMapping.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['custom'] != null) {
      custom = [];
      json['custom'].forEach((v) {
        custom.add(new Custom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.custom != null) {
      data['custom'] = this.custom.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Custom {
  String categoryName;
  List<PreDefinedItems> custom;

  Custom({this.categoryName, this.custom});

  Custom.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    if (json['custom'] != null) {
      custom = [];
      json['custom'].forEach((v) {
        custom.add(new PreDefinedItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    if (this.custom != null) {
      data['custom'] = this.custom.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreDefinedItems {
  String itemName;
  String quantity;
  String category;
  AdditionalDetails additionalDetails;
  List<String> custom;

  PreDefinedItems(
      {this.itemName,
      this.category,
      this.quantity,
      this.additionalDetails,
      this.custom});

  PreDefinedItems.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    category = json['category'];
    quantity = json['quantity'];
    additionalDetails = json['additionalDetails'] != null
        ? new AdditionalDetails.fromJson(json['additionalDetails'])
        : null;
    custom = json['custom'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['quantity'] = this.quantity;
    if (this.additionalDetails != null) {
      data['additionalDetails'] = this.additionalDetails.toJson();
    }
    data['custom'] = this.custom;
    return data;
  }
}

class AdditionalDetails {
  String description;
  String image;

  AdditionalDetails({this.description, this.image});

  AdditionalDetails.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

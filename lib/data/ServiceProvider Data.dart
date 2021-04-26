class ServiceProviders {
  String name;
  String imgUrl;
  String description;
  String contactNo;
  String rating;
  String price;
  String location;

  ServiceProviders(
      {this.contactNo,
      this.rating,
      this.price,
      this.name,
      this.imgUrl,
      this.description,
      this.location});

  static List<ServiceProviders> getServiceProviders() {
    return <ServiceProviders>[
      ServiceProviders(
        name: "Shyam Transporters",
        imgUrl:
            "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
        description: "Mainly deals with intercity packing and moving",
        rating: "⭐⭐⭐⭐⭐",
        price: "₹ 13034",
        contactNo: "8340283299",
        location: "jaipur",
      ),
      ServiceProviders(
        name: "Meet Transporters",
        imgUrl:
            "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
        description: "Mainly deals with intercity packing and moving",
        rating: "⭐⭐⭐⭐",
        price: "₹ 12313",
        contactNo: "8340283299",
        location: "Hyderabad",
      ),
      ServiceProviders(
        name: "Raghav Transporters",
        imgUrl:
            "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
        description: "Mainly deals with intercity packing and moving",
        rating: "⭐⭐⭐⭐",
        price: "₹ 18433",
        contactNo: "8340283299",
        location: "Bhopal",
      ),
      ServiceProviders(
        name: "JK Transporters",
        imgUrl:
            "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
        description: "Mainly deals with intercity packing and moving",
        rating: "⭐⭐⭐",
        price: "",
        contactNo: "8340283299",
        location: "Banglore",
      ),
      ServiceProviders(
        name: "Aggarwal Transporters",
        imgUrl:
            "https://images-na.ssl-images-amazon.com/images/I/61u%2BNKkFnmL._SL1000_.jpg",
        description: "Mainly deals with intercity packing and moving",
        rating: "⭐⭐",
        price: "₹ 10000",
        contactNo: "8340283299",
        location: "Himachal Pradesh",
      )
    ];
  }
}

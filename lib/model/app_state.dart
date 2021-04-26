class AppState {
  String movementType;
  String shiftType;
  String spId;
  String pickupCity;
  String dropCity;
  String price;
  String pickupStreetAddress;
  String dropStreetAddress;
  List<dynamic> additionalItems;
  List<dynamic> singleServices;
  List<dynamic> vehicles;
  List<dynamic> multiServices;
  bool car;
  bool bike;
  String pickupAddress;
  String dropAddress;
  String selectedServiceProvider;
  String pickupDate;
  String dropDate;
  bool packingRequirement;
  bool warehousing;
  String pickupFloor;
  bool pickupLift;
  String dropFloor;
  bool dropLift;

  AppState({
    this.spId,
    this.movementType,
    this.pickupCity,
    this.dropCity,
    this.shiftType,
    this.price,
    this.vehicles,
    this.pickupStreetAddress,
    this.dropStreetAddress,
    this.bike,
    this.additionalItems,
    this.car,
    this.dropAddress,
    this.dropDate,
    this.dropFloor,
    this.dropLift,
    this.packingRequirement,
    this.pickupAddress,
    this.pickupDate,
    this.pickupFloor,
    this.pickupLift,
    this.singleServices,
    this.multiServices,
    this.selectedServiceProvider,
    this.warehousing,
  });

  AppState.fromAppState(AppState another) {
    spId = another.spId;
    movementType = another.movementType;
    pickupCity = another.pickupCity;
    dropCity = another.dropCity;
    price = another.price;
    shiftType = another.shiftType;
    vehicles = another.vehicles;
    additionalItems = another.additionalItems;
    pickupStreetAddress = another.pickupStreetAddress;
    dropStreetAddress = another.dropStreetAddress;
    bike = another.bike;
    singleServices = another.singleServices;
    multiServices = another.multiServices;
    car = another.car;
    dropAddress = another.dropAddress;
    dropDate = another.dropDate;
    dropFloor = another.dropFloor;
    dropLift = another.dropLift;
    packingRequirement = another.packingRequirement;
    pickupAddress = another.pickupAddress;
    pickupDate = another.pickupDate;
    pickupFloor = another.pickupFloor;
    pickupLift = another.pickupLift;
    selectedServiceProvider = another.selectedServiceProvider;
    warehousing = another.warehousing;
  }
}

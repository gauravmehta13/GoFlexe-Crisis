import 'package:crisis/model/app_state.dart';
import 'actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is ShiftType) {
    newState.shiftType = action.payload;
  } else if (action is SpId) {
    newState.spId = action.payload;
  } else if (action is MovementType) {
    newState.movementType = action.payload;
  } else if (action is PickupCity) {
    newState.pickupCity = action.payload;
  } else if (action is DropCity) {
    newState.dropCity = action.payload;
  } else if (action is PickupStreetAddress) {
    newState.pickupStreetAddress = action.payload;
  } else if (action is Price) {
    newState.price = action.payload;
  } else if (action is DropStreetAddress) {
    newState.dropStreetAddress = action.payload;
  } else if (action is Items) {
    newState.additionalItems = action.payload;
  } else if (action is SingleServices) {
    newState.singleServices = action.payload;
  } else if (action is MultiServices) {
    newState.multiServices = action.payload;
  } else if (action is Car) {
    newState.car = action.payload;
  } else if (action is Bike) {
    newState.bike = action.payload;
  } else if (action is PickupAddress) {
    newState.pickupAddress = action.payload;
  } else if (action is PickupDate) {
    newState.pickupDate = action.payload;
  } else if (action is PickupFloor) {
    newState.pickupFloor = action.payload;
  } else if (action is DropAddress) {
    newState.dropAddress = action.payload;
  } else if (action is DropDate) {
    newState.dropDate = action.payload;
  } else if (action is DropFloor) {
    newState.dropFloor = action.payload;
  } else if (action is Packingrequirement) {
    newState.packingRequirement = action.payload;
  } else if (action is Warehousing) {
    newState.warehousing = action.payload;
  } else if (action is Vehicles) {
    newState.vehicles = action.payload;
  } else if (action is SelectedServiceProvider) {
    newState.selectedServiceProvider = action.payload;
  } else if (action is PickupLift) {
    newState.pickupLift = action.payload;
  } else if (action is DropLift) {
    newState.dropLift = action.payload;
  } else if (action is StateName) {
    newState.stateName = action.payload;
  } else if (action is DistrictName) {
    newState.districtName = action.payload;
  } else if (action is Usecase) {
    newState.usecase = action.payload;
  }

  return newState;
}

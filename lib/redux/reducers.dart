import 'package:crisis/model/app_state.dart';
import 'actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is StateName) {
    newState.stateName = action.payload;
  } else if (action is DistrictName) {
    newState.districtName = action.payload;
  } else if (action is Usecase) {
    newState.usecase = action.payload;
  }

  return newState;
}

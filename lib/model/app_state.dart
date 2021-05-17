class AppState {
  String stateName;
  String districtName;
  String usecase;

  AppState({this.districtName, this.stateName, this.usecase});

  AppState.fromAppState(AppState another) {
    stateName = another.stateName;
    districtName = another.districtName;
    usecase = another.usecase;
  }
}

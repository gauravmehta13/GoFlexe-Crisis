class States {
  List<IndiaState> states;
  States({this.states});

  States.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = [];
      json['states'].forEach((v) {
        states.add(new IndiaState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IndiaState {
  int value;
  String label;

  IndiaState({this.value, this.label});

  IndiaState.fromJson(Map<String, dynamic> json) {
    value = json['state_id'];
    label = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.value;
    data['state_name'] = this.label;
    return data;
  }
}

class District {
  List<Districts> districts;

  District({this.districts});

  District.fromJson(Map<String, dynamic> json) {
    if (json['districts'] != null) {
      districts = [];
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  int value;
  String label;

  Districts({this.value, this.label});

  Districts.fromJson(Map<String, dynamic> json) {
    value = json['district_id'];
    label = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.value;
    data['district_name'] = this.label;
    return data;
  }
}

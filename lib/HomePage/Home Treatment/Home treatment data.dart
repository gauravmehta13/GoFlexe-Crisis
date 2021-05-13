class DevicesRequired {
  String name;
  String url;

  DevicesRequired({this.name, this.url});
  static List<DevicesRequired> getDevicesRequired() {
    return <DevicesRequired>[
      DevicesRequired(name: "Thermometer", url: "thermometer.png"),
      DevicesRequired(name: "Oximeter", url: "pulseOximeter.png"),
      DevicesRequired(
          name: "Blood Pressure Monitor (Optional)", url: "bloodPressure.png"),
      DevicesRequired(
          name: "Blood Glucose Monitor (for those with Diabetes)",
          url: "glucometer.png"),
    ];
  }
}

class Meds {
  String name;
  List<Medications> meds;

  Meds({this.meds, this.name});
  static List<Meds> getMeds() {
    return <Meds>[
      Meds(name: "Basic Medication", meds: Medications.getBasicMedications()),
    ];
  }
}

class Medications {
  String name;
  String url;
  String description;

  Medications({this.name, this.url, this.description});
  static List<Medications> getBasicMedications() {
    return <Medications>[
      Medications(
          name: "Tab Ivermactin (200mcg/kg)",
          url: "medicine.png",
          description:
              "(Once a day for 3 days). Avoid in pregnant and lactating women."),
      Medications(
          name: "Tab Paracetamol 650 mg",
          url: "medicine.png",
          description: "For Fever (Can be taken every 6-8 hours.)"),
      Medications(
          name: "Inhaled Budesonide",
          url: "inhaler.png",
          description: "Depending on your symptoms, Your doctor may ask you"),
      Medications(
          name: "Vitamins",
          url: "vitamins.png",
          description:
              " Vitamins B, C and D, as well as zinc may be helpful in boosting your immune system."),
    ];
  }
}

class Warnings {
  String name;
  bool serious;

  Warnings({this.serious, this.name});
  static List<Warnings> getWarnings() {
    return <Warnings>[
      Warnings(
          name:
              "PLEASE DO NOT SELF MEDICATE. CONSULT YOUR PHYSICIAN BEFORE TAKING ANY NEW MEDICATION",
          serious: true),
      Warnings(
          name:
              "Schedule an RTPCR Test and seek a medical opinion. Mild cases might not require any of these routine tests.",
          serious: false),
      Warnings(
          name:
              "DO NOT GOOGLE AND SELF INTERPRET.\n Consult with your doctor for further course of action.",
          serious: false),
    ];
  }
}

class IsolationTab {
  String name;
  String url;
  List<Tips> tips;

  IsolationTab({this.tips, this.name, this.url});
  static List<IsolationTab> getIsolationTab() {
    return <IsolationTab>[
      IsolationTab(
          name: "Isolation",
          url: "isolation.png",
          tips: Tips.getIsolationTips()),
      IsolationTab(
          name: "Diet & Nutrition", url: "diet.png", tips: Tips.getDietTips()),
      IsolationTab(
          name: "Good Hygiene", url: "safe.png", tips: Tips.getHygieneTips()),
    ];
  }
}

class Tips {
  String tip;

  Tips({
    this.tip,
  });

  static List<Tips> getIsolationTips() {
    return <Tips>[
      Tips(tip: "Stay in an isloated place"),
      Tips(tip: "Wear a mask and ask your Family members to wear one."),
      Tips(tip: "Use a seperate bathroom"),
      Tips(
          tip:
              "Use seperate dishes. Those who are cleaning your dishes should wear a mask and wash hands throughly"),
      Tips(tip: "Open windows for Ventilation. Do not use common AC."),
    ];
  }

  static List<Tips> getDietTips() {
    return <Tips>[
      Tips(tip: "Keep yourself hydrated."),
      Tips(tip: "Eat green leafy vegetables and citrus fruits."),
      Tips(tip: "Eat Paneer, low fat meat, e.g., Chicken, Fish."),
      Tips(tip: "Avoid using processed foods."),
      Tips(tip: "Avoid eating deep fried foods."),
      Tips(tip: "Eat Lemon Pickle etc to simulate your taste buds."),
    ];
  }

  static List<Tips> getHygieneTips() {
    return <Tips>[
      Tips(
          tip:
              "Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water."),
      Tips(
          tip:
              "Avoid touching your eyes, nose and mouth. Hands touch many surfaces and can pick up viruses."),
      Tips(
          tip:
              "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately into a closed bin and wash your hands."),
      Tips(
          tip:
              "Clean and disinfect surfaces frequently especially those which are regularly touched, such as door handles, faucets and phone screens.")
    ];
  }

  static List<Tips> getRedFlags() {
    return <Tips>[
      Tips(tip: "Difficulty in breathing"),
      Tips(tip: "Dip in oxygen saturation (SpO2 < 94% on room air)"),
      Tips(tip: "Persistent pain/pressure in the chest"),
      Tips(tip: "Mental confusion or inability to arouse")
    ];
  }
}

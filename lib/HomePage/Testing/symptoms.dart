class Symptoms {
  String heading;
  List<String> symptoms;

  Symptoms({this.heading, this.symptoms});
  static List<Symptoms> getSymptoms() {
    return <Symptoms>[
      Symptoms(
          heading: "Most common symptoms",
          symptoms: ["fever", "dry cough", "tiredness"]),
      Symptoms(heading: "Less common symptoms", symptoms: [
        "aches and pains",
        "sore throat",
        "diarrhoea",
        "conjunctivitis",
        "headache",
        "loss of taste or smell",
        "a rash on skin, or discolouration of fingers or toes"
      ]),
      Symptoms(heading: "Serious symptoms", symptoms: [
        "difficulty breathing or shortness of breath",
        "chest pain or pressure",
        "loss of speech or movement"
      ]),
    ];
  }
}

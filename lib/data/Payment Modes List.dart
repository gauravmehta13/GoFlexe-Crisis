class PaymentMode {
  int paymentId;
  String name;
  String description;

  PaymentMode({this.paymentId, this.name, this.description});

  static List<PaymentMode> getPaymentModes() {
    return <PaymentMode>[
      PaymentMode(
          paymentId: 0,
          name: "BHIM UPI",
          description: "Pay Using BHIM UPI via any UPI App"),
      PaymentMode(
          paymentId: 2,
          name: "Pay on Delivery",
          description: "Pay after the shipment gets completed"),
    ];
  }
}

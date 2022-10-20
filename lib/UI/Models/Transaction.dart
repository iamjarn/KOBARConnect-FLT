class Transaction {
  String visit_date,
      name,
      identity_number,
      email,
      phone_number,
      address,
      adult_quantity,
      child_quantity,
      is_use_transport,
      tour_id;

  Transaction(
      {required this.tour_id,
      required this.visit_date,
      required this.name,
      required this.identity_number,
      required this.email,
      required this.phone_number,
      required this.address,
      required this.adult_quantity,
      required this.child_quantity,
      required this.is_use_transport});
}

class FlightModel {
  int id;
  double price;
  String departuretime,
      arrivaltime,
      saleprice,
      image,
      title,
      duration,
      location_to,
      location_from,
      airport_from,
      airport_to;
  List<FlighSeattModel>? seats;

  FlightModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.saleprice,
      required this.departuretime,
      required this.arrivaltime,
      required this.duration,
      required this.location_to,
      required this.location_from,
      required this.airport_from,
      required this.airport_to,
      this.seats});
  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        price: json['price'] ?? 0.0,
        saleprice: json['sale_price'] ?? "",
        arrivaltime: json['arrival_time'] ?? "2022-03-11T08:58:50.000000Z",
        departuretime: json['departure_time'] ?? "2022-03-11T08:58:50.000000Z",
        duration: json['duration'] ?? "3",
        location_from: json['location_from'] ?? "",
        location_to: json['location_to'] ?? "",
        airport_from: json['airport_from'] ?? "",
        airport_to: json['airport_to'] ?? "",
        seats: json['seats'] ?? []);
  }
}

class FlighSeattModel {
  int id;
  double price;
  String max_passenger, seat_type, person, baggage_check_in, baggage_cabin;
  int? number;
  dynamic? seattypes;
  double? calprice;

  FlighSeattModel(
      {required this.id,
      required this.max_passenger,
      required this.seat_type,
      required this.price,
      required this.person,
      required this.baggage_check_in,
      required this.baggage_cabin,
      this.number,
      this.seattypes,
      this.calprice});
  factory FlighSeattModel.fromJson(Map<String, dynamic> json) {
    return FlighSeattModel(
        id: json['id'],
        max_passenger: json['max_passengers'],
        seat_type: json['seat_type']['name'],
        price: json['price'],
        person: json['person'],
        baggage_check_in: json['baggage_check_in'],
        baggage_cabin: json['baggage_cabin'],
        number: json['number'] ?? 0,
        seattypes: json['seattypes']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'max_passenger': max_passenger,
        'seat_type': seattypes,
        'price': price,
        'person': person,
        'baggage_check_in': baggage_check_in,
        'baggage_cabin': baggage_cabin,
        'number': number ?? 0
      };
}

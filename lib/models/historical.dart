class Historical {
  String date;
  int confirmed;
  int deaths;
  int recovered;

  Historical({this.date, this.confirmed, this.deaths, this.recovered});

  Historical.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}
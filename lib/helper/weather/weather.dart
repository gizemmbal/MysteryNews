class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double humidity;
  final double high;
  final String description;
  //final String country;

  Weather(
      { //this.country,
      this.humidity,
      this.temp,
      this.feelsLike,
      this.low,
      this.high,
      this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      //country: json['type']['0']['country'](),
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

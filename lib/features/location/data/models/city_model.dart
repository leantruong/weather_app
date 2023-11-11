class CityModel {
  final String city;
  final String country;

  CityModel({required this.city, required this.country});

  //List of Cities data
  static List<CityModel> citiesList = <CityModel>[
    //CityModel(city: 'London', country: 'United Kindgom'),
    CityModel(
      city: 'Tokyo',
      country: 'Japan',
    ),
    CityModel(
      city: 'Delhi',
      country: 'India',
    ),
    CityModel(
      city: 'Beijing',
      country: 'China',
    ),
    CityModel(
      city: 'Paris',
      country: 'Paris',
    ),
    CityModel(
      city: 'Rome',
      country: 'Italy',
    ),
    CityModel(
      city: 'Lagos',
      country: 'Nigeria',
    ),
    CityModel(
      city: 'Amsterdam',
      country: 'Netherlands',
    ),
    CityModel(
      city: 'Barcelona',
      country: 'Spain',
    ),
    CityModel(
      city: 'Miami',
      country: 'United States',
    ),
    CityModel(
      city: 'Vienna',
      country: 'Austria',
    ),
    CityModel(
      city: 'Berlin',
      country: 'Germany',
    ),
    CityModel(
      city: 'Toronto',
      country: 'Canada',
    ),
    CityModel(
      city: 'Brussels',
      country: 'Belgium',
    ),
    CityModel(
      city: 'Nairobi',
      country: 'Kenya',
    ),
    CityModel(
      city: 'New York',
      country: 'USA',
    ),
  ];
}

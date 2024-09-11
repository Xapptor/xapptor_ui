import 'package:xapptor_ui/values/country/countries.dart';
import 'package:xapptor_ui/values/country/countries_phone_codes.dart';

class Country {
  String name;
  String secondary_name;
  String alpha_2;
  String alpha_3;
  String code;
  String iso_31662;
  String region;
  String sub_region;
  String intermediate_region;
  String region_code;
  String sub_region_code;
  String intermediate_region_code;
  String dial_code;

  Country({
    required this.name,
    required this.secondary_name,
    required this.alpha_2,
    required this.alpha_3,
    required this.code,
    required this.iso_31662,
    required this.region,
    required this.sub_region,
    required this.intermediate_region,
    required this.region_code,
    required this.sub_region_code,
    required this.intermediate_region_code,
    required this.dial_code,
  });

  factory Country.from_map({
    required Map<String, dynamic> main_map,
    required Map<String, dynamic> secondary_map,
  }) {
    return Country(
      name: main_map['name'],
      secondary_name: secondary_map['name'] ?? '',
      alpha_2: main_map['alpha-2'],
      alpha_3: main_map['alpha-3'],
      code: main_map['country-code'],
      iso_31662: main_map['iso_3166-2'],
      region: main_map['region'],
      sub_region: main_map['sub-region'],
      intermediate_region: main_map['intermediate-region'],
      region_code: main_map['region-code'],
      sub_region_code: main_map['sub-region-code'],
      intermediate_region_code: main_map['intermediate-region-code'],
      dial_code: secondary_map['dial_code'] ?? '',
    );
  }
}

List<Country> countries_list = countries
    .map(
      (country) => Country.from_map(
        main_map: country,
        secondary_map: countries_phone_codes.firstWhere(
          (countries_phone_code) => countries_phone_code['code'] == country['alpha-2'],
          orElse: () => {},
        ),
      ),
    )
    .toList();

List<Country> countries_list_without_dial_code = countries_list.where((country) => country.dial_code == '').toList();

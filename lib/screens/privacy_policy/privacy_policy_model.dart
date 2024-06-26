class PrivacyPolicyModel {
  final String app_name;
  final String company_name;
  final String company_address;
  final String company_country;
  final String website;
  final String email;
  final String? phone_number;

  const PrivacyPolicyModel({
    required this.app_name,
    required this.company_name,
    required this.company_address,
    required this.company_country,
    required this.website,
    required this.email,
    this.phone_number,
  });
}

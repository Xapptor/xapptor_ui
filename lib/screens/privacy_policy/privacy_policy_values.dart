import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_text.dart';
import 'package:xapptor_ui/screens/privacy_policy/custom_title.dart';

DateFormat label_date_formatter = DateFormat.yMMMMd('en_US');

var margin = const EdgeInsets.only(top: 10, bottom: 10);
var margin_text_2 = const EdgeInsets.only(bottom: 20);

class PrivacypolicyValues {
  Widget introduction({
    required DateTime last_update_date,
  }) {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Privacy Policy",
          ),
          custom_text(
            "Last updated: ${label_date_formatter.format(last_update_date)}",
          ),
          custom_text(
            "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.",
          ),
          custom_text(
            "We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.",
          ),
        ],
      ),
    );
  }

  Widget interpretation() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Interpretation and Definitions",
          ),
          custom_title_2(
            "Interpretation",
          ),
          custom_text(
            "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
          ),
        ],
      ),
    );
  }

  Widget definitions({
    required String app_name,
    required String company_name,
    required String company_address,
    required String company_country,
    required String website,
  }) {
    String definitions() {
      return "For the purposes of this Privacy Policy:\nAccount means a unique account created for You to access our Service or parts of our Service.\nAffiliate means an entity that controls, is controlled by or is under common control with a party, where control means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\nApplication means the software program provided by the Company downloaded by You on any electronic device, named $app_name\nCompany (referred to as either the Company, We, Us or Our in this Agreement) refers to $company_name, $company_address.\nCountry refers to: $company_country\nDevice means any device that can access the Service such as a computer, a cellphone or a digital tablet.\nPersonal Data is any information that relates to an identified or identifiable individual.\nService refers to the Application or the Website or both.\nService Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.\nUsage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).\nWebsite refers to $app_name, accessible from $website\nYou means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.";
    }

    Widget current_widget = Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Definitions",
          ),
          custom_text(
            definitions(),
          ),
        ],
      ),
    );

    return current_widget;
  }

  Widget usage_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_3(
            "Usage Data",
          ),
          custom_text(
            "Usage Data is collected automatically when using the Service.",
          ),
          custom_text(
            "Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.",
          ),
          custom_text(
            "When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.",
          ),
          custom_text(
            "We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.",
          ),
        ],
      ),
    );
  }

  Widget retention_personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Retention of Your Personal Data",
          ),
          custom_text(
            "The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.",
          ),
          custom_text(
            "The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.",
          ),
        ],
      ),
    );
  }

  Widget transfer_personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Transfer of Your Personal Data",
          ),
          custom_text(
            "Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.",
          ),
          custom_text(
            "Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.",
          ),
          custom_text(
            "The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.",
          ),
        ],
      ),
    );
  }

  Widget security_personal_data() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_2(
            "Security of Your Personal Data",
          ),
          custom_text(
            "The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.",
          ),
        ],
      ),
    );
  }

  Widget children_privacy() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Children's Privacy",
          ),
          custom_text(
            "Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.",
          ),
          custom_text(
            "If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.",
          ),
        ],
      ),
    );
  }

  Widget links_to_other_websites() {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Links to Other Websites",
          ),
          custom_text(
            "Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.",
          ),
          custom_text(
            "We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.",
          ),
        ],
      ),
    );
  }

  Widget changes({
    bool we_will_notify = false,
  }) {
    return Container(
      color: Colors.white,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          custom_title_1(
            "Changes to this Privacy Policy",
          ),
          custom_text(
            "We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.",
          ),
          we_will_notify
              ? custom_text(
                  "We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the Last updated date at the top of this Privacy Policy.",
                )
              : Container(
                  color: Colors.white,
                ),
          custom_text(
            "You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.",
          ),
        ],
      ),
    );
  }
}

# **Xapptor UI**
[![pub package](https://img.shields.io/pub/v/xapptor_ui?color=blue)](https://pub.dartlang.org/packages/xapptor_ui)
### UI Module for a variety of useful Widgets.

## **Let's get started**

### **1 - Depend on it**
##### Add it to your package's pubspec.yaml file
```yml
dependencies:
    xapptor_ui: ^0.0.3
```

### **2 - Install it**
##### Install packages from the command line
```sh
flutter pub get
```

### **3 - Learn it like a charm**

#### **Privacy Policy**
```dart
PrivacyPolicy(
    base_url: "https://www.yourdomain.com",
    use_topbar: false,
    topbar_color: Colors.blue,
);
```

#### **QR Scanner**
```dart
QRScanner(
    descriptive_text: "Scan the QR code\nof the Machine",
    update_qr_value: update_qr_value_function,
    border_color: Colors.pink,
    border_radius: 4,
    border_length: 40,
    border_width: 8,
    cut_out_size: MediaQuery.of(context).size.width * 0.65,
    button_linear_gradient: LinearGradient(
      colors: [
        Colors.blue.withOpacity(0.4),
        Colors.green.withOpacity(0.4),
      ],
    ),
    permission_message: "You must give permission to the camera to capture QR codes",
    permission_label_no: "Cancel",
    permission_label_yes: "Accept",
    enter_code_text: "Enter your code",
    validate_button_text: "Validate",
    fail_message: "You must enter a code",
    textfield_color: Colors.green,
    login_button_text: "Log in",
    show_login_button: true,
);
```

#### **Unknow Screen**
```dart
UnknownScreen(
    logo_path: "assets/images/your_logo.png",
);
```

#### **Resume**
```dart
Resume(
    resume: Resume(
        image_src: "assets/images/resume_photo.png",
        name: "Javier Jesus Garcia Contreras",
        job_title: "Software Developer",
        email: "info@xapptor.com",
        url: "https://xapptor.com",
        skills: [
            ResumeSkill(
            name: "Experience: 5 years",
            percentage: 0.5,
            color: color_turquoise,
            ),
            ResumeSkill(
            name: "Communication",
            percentage: 0.8,
            color: color_purple,
            ),
            ResumeSkill(
            name: "Cognitive Flexibility",
            percentage: 0.8,
            color: color_magenta,
            ),
            ResumeSkill(
            name: "Negotiation",
            percentage: 0.7,
            color: Colors.amberAccent,
            ),
            ResumeSkill(
            name: "Health",
            percentage: 0.9,
            color: Colors.red,
            ),
            ResumeSkill(
            name: "Mana",
            percentage: 0.8,
            color: Colors.blueAccent,
            ),
        ],
        sections: [
            ResumeSection(
            icon: Icons.badge,
            code_point: 0xea67,
            title: "Profile",
            description:
                "I am a software developer passionate about Apps and artificial intelligence, I have participated in 3 projects implementing cognitive services of Microsoft Azure. I love working with Flutter and Firebase for the analysis, design and implementation of libraries to speed up the development of multi platform applications.",
            ),
            ResumeSection(
            icon: Icons.dvr_rounded,
            code_point: 0xe1b2,
            title: "Employment History",
            subtitle: "Software Developer at Keydok, Mexico City",
            begin: DateTime(2019, 10),
            end: DateTime.now(),
            description:
                "Design, development and implementation of software in the mobile applications area (Android and IOS). Use of native and cross-platform frameworks such as IOS Native, Kotlin Native, Flutter and Kotlin Multi-platform. Implementing development methodologies like Safe, Agile and Scrum.",
            ),
            ResumeSection(
            subtitle: "Software Developer at Ike Asistencia, Mexico City",
            begin: DateTime(2019, 4),
            end: DateTime(2019, 10),
            description:
                "Design, development and implementation of software in the mobile applications area (Android and IOS). Development of Backend and microservices using Spring Boot and Micronaut framework. Implementing development methodologies like Safe, Agile and Scrum.",
            ),
            ResumeSection(
            subtitle: "Game Developer at Visionaria Games, Mexico City",
            begin: DateTime(2018, 1),
            end: DateTime(2019, 4),
            description:
                "Design, development and implementation of software in the mobile applications area (Android and IOS). Development of video games, and web application Flow package used for the application of artificial intelligence in characters and their behaviors.",
            ),
            ResumeSection(
            subtitle:
                "Software Design Professor at Universidad Mexicana de Innovación en Negocios, Metepec",
            begin: DateTime(2017, 6),
            end: DateTime(2018, 1),
            description:
                "Teaching high school level students on mobile applications and video games.",
            ),
            ResumeSection(
            subtitle: "Freelance Software Developer, Metepec",
            begin: DateTime(2016, 2),
            end: DateTime(2017, 6),
            description:
                "Development of custom software for the administration of scheduled educational events.",
            ),
            ResumeSection(
            icon: Icons.history_edu_rounded,
            code_point: 0xea3e,
            title: "Education",
            subtitle:
                "Digital Business Engineer, Universidad Mexicana de Innovación en Negocios, Metepec",
            begin: DateTime(2014, 7),
            end: DateTime(2018, 7),
            ),
            ResumeSection(
            icon: Icons.bar_chart_rounded,
            code_point: 0xe26b,
            title: "Technologies",
            description:
                "Java, JavaScript, C#, Kotlin, Swift, Dart, Flutter, Android Compose, SwiftUI, Micronaut, NodeJs, Google cloud Platform, Firebase, Mysql, Stripe, Playcanvas, Unity, Unreal Engine.",
            ),
        ],
        icon_color: color_turquoise,
    ),
    visible: true,
);
```

#### **Webview**
```dart
Webview(
    id: Uuid().v4(),
    src: image_src,
);
```

#### **App Version Container**
```dart
AppVersionContainer(
    text_color: Colors.blue,
    background_color: Colors.white,
);
```

#### **Background Image with Gradient Color**
```dart
BackgroundImageWithGradientColor(
    height: height,
    box_fit: BoxFit.cover,
    image_path: null,
    linear_gradient: LinearGradient(
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        colors: widget.linear_gradient_colors,
        stops: [0.0, 1.0],
    ),
    child: Container(
        ...
    ),
);
```

#### **BottomBar Container**
```dart
BottomBarContainer(
    current_page_callback: update_current_page_function,
    initial_page: 0,
    bottom_bar_buttons: [
        BottomBarButton(
            icon: Icons.microwave_outlined,
            text: "Machines",
            foreground_color: Colors.white,
            background_color: color_lum_green,
            page: Container(
                color: Colors.white,
                child: vending_machines_widgets.length == 0
                    ? Center(
                        child: Text(
                            "You don't have any vending machine",
                            style:
                                Theme.of(context).textTheme.subtitle2,
                            ),
                    )
                    : SingleChildScrollView(
                        child: Column(
                            children: vending_machines_widgets,
                    ),
                ),
            ),
        ),
        BottomBarButton(
            icon: Icons.insights,
            text: "Analytics",
            foreground_color: Colors.white,
            background_color: Colors.blue,
            page: AdminAnalytics(
                text_color: Colors.blue,
                icon_color: Colors.green,
            ),
        ),
    ],
);
```

#### **Card Holder**
```dart
CardHolder(
    image_src: "assets/images/courses.jpg",
    title: title,
    subtitle: subtitle,
    background_image_alignment: Alignment.center,
    icon: null,
    icon_background_color: null,
    on_pressed: () {
        open_screen("home/courses");
    },
    elevation: elevation,
    border_radius: border_radius,
    is_focused: true,
);
```

#### **Characteristic Container Item**
```dart
CharacteristicsContainerItem(
    title: title,
    description: description,
    icon: Icons.hourglass_empty,
    color: Theme.of(context).primaryColor,
    title_color: Colors.white,
    subtitle_color: Colors.white,
    icon_color: Colors.orange.shade300,
    side_icon: false,
    large_description: false,
    align_to_left_description: false,
);
```

#### **Characteristic Container**
```dart
CharacteristicsContainer(
    texts: text_list,
);
```

#### **Check Permission**
```dart
check_permission(
    context: context,
    message: permission_message,
    label_no: permission_label_no,
    label_yes: permission_label_yes,
    permission_type: Permission.camera,
);

encourage_give_permission(
    context: context,
    message: message,
    label_no: label_no,
    label_yes: label_yes,
);
```

#### **Comming Soon Container**
```dart
ComingSoonContainer(
    text: "Coming Soon",
    enable_cover: true,
);
```

#### **Contact Us Container**
```dart
ContactUsContainer(
    texts: text_list_contact_us,
    landing_class: this,
    icon_color: Colors.blue,
    container_background_image:
        "assets/images/background_building.jpg",
    facebook_url: url_facebook,
    facebook_url_fallback: url_facebook_fallback,
    youtube_url: url_youtube,
    instagram_url: url_instagram,
    twitter_url: url_twitter,
    email: "email@yourdomain.com",
    feedback_message: "✉️ Message sent! 👍",
    card_background_image: "",
    container_background_color: Colors.white,
    card_background_color: Colors.white,
    linear_gradient_colors: [
        Colors.black.withOpacity(0.6),
        Colors.black.withOpacity(0.6),
    ],
    border_radius: 10,
);
```

#### **Crop Widget**
```dart
CropWidget(
    child: Image.asset(
        "assets/images/logo.png",
        color: Color.blue.withOpacity(0.40),
        fit: BoxFit.cover,
    ),
    general_alignment: Alignment.bottomLeft,
    vertical_alignment: Alignment.topCenter,
    horizontal_alignment: Alignment.centerRight,
    height_factor: 0.8,
    width_factor: 0.75,
);
```

#### **Custom Card**
```dart
CustomCard(
    on_pressed: () async {
        ...
    },
    border_radius: 1000,
    splash_color: Colors.blue.withOpacity(0.3),
    child: Center(
        child: Text(
            your_text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
            ),
        ),
    ),
);
```

#### **Description Card**
```dart
description_card(
    description_card: DescriptionCard(
        image_src: "assets/images/module_auth.png",
        title: "Xapptor Auth",
        description:
            "Get easy screen integration to manage your login, registration and password recovery processes.",
        url: "https://github.com/Xapptor/xapptor_auth",
        url_title: "Github Repo",
        text_color: color_turquoise,
        direction: Axis.horizontal,
        reversed: false,
        current_offset: _scroll_position,
        visible_offset: screen_height + ((screen_height * 0.7) * 2),
    ),
    context: context,
);
```

#### **Download Apps Container**
```dart
DownloadAppsContainer(
    texts: text_list,
    title_color: Colors.black,
    subtitle_color: Colors.grey,
    image_1: 'assets/images/image_1.jpg',
    image_2: 'assets/images/image_2.jpg',
    android_url: apk_url,
    ios_url: ios_url,
    background_image: "",
    button_background_color: [
        Colors.cyan,
        Colors.blue,
    ],
);
```

#### **Expandable FAB**
```dart
floatingActionButton: ExpandableFab(
    distance: 112.0,
    background_color: Colors.white,
    children: [
        ActionButton(
            on_pressed: () {
                ...
            },
            icon: Icon(
                FontAwesome.twitter,
                color: Colors.white,
                size: 16,
            ),
            icon_color: color_twitter,
        ),
        ActionButton(
            on_pressed: () {
                ...
            },
            icon: Icon(
                FontAwesome.youtube,
                color: Colors.white,
                size: 16,
            ),
            icon_color: color_youtube,
        ),
        ActionButton(
            on_pressed: () {
                ...
            },
            icon: Icon(
                FontAwesome.instagram,
                color: Colors.white,
                size: 16,
            ),
            icon_color: color_instagram,
        ),
        ActionButton(
            on_pressed: () {
                ...
            },
            icon: Icon(
                FontAwesome.facebook,
                color: Colors.white,
                size: 16,
            ),
            icon_color: color_facebook,
        ),
    ],
),
```

#### **Introduction Container**
```dart
IntroductionContainer(
    texts: text_list_introduction,
    text_color: Colors.white,
    background_image: "assets/images/introduction_container.jpg",
    logo_image: "assets/images/logo.png",
    scroll_icon: Icons.keyboard_arrow_down,
    scroll_icon_color: Colors.orangeAccent,
    height: MediaQuery.of(context).size.height,
);
```

#### **Show Custom Dialog**
```dart
show_custom_dialog(
    context: context,
    title: "Failed",
    message: "The passwords do not match",
    button_text: "Close",
);
```

#### **Switch Button**
```dart
switch_button(
    text: "Enabled",
    value: dispenser_enabled,
    enabled: enable_dispenser_edit,
    active_track_color: main_color,
    active_color: Colors.lightGreen,
    inactive_color: Colors.red,
    background_color: Colors.blue,
    callback: switch_button_callback_function,
    border_radius: MediaQuery.of(context).size.width,
);
```

#### **Topbar**
```dart
appBar: TopBar(
    context: context,
    background_color: Colors.blue,
    has_back_button: false,
    actions: [
        Container(
            width: 150,
            margin: EdgeInsets.only(right: 20),
            child: widget.language_picker
                ? LanguagePicker(
                    translation_stream_list: translation_stream_list,
                    language_picker_items_text_color:
                        widget.language_picker_items_text_color,
                )
                : Container(),
        ),
    ],
    custom_leading: null,
    logo_path: "assets/images/logo.png",
),
```

#### **URL Text**
```dart
UrlText(
    text: "myemail@domain.com",
    url: "mailto:myemail@domain.com",
);
```

#### **Video Visualizer**
```dart
WebVideoVisualizer(
    src: video_url,
);
```

#### **Why Us Container**
```dart
WhyUsContainer(
    texts: text_list_why_us,
    background_color: Colors.white,
    characteristic_icon_1: Icons.shutter_speed,
    characteristic_icon_2: Icons.message,
    characteristic_icon_3: Icons.compare,
    characteristic_icon_color_1: Colors.orangeAccent,
    characteristic_icon_color_2: Colors.lightBlueAccent,
    characteristic_icon_color_3: Colors.redAccent,
    title_color: Colors.black,
    subtitle_color: Colors.grey,
    background_image: '',
),
```

#### **Widgets Carousel**
```dart
List<Widget> carousel_items = [
    CardHolder(
        image_src: "assets/images/logo_abeinstitute.jpg",
        image_fit: BoxFit.fitWidth,
        title: "Abeinstitute",
        subtitle: "",
        background_image_alignment: Alignment.center,
        icon: null,
        icon_background_color: null,
        on_pressed: () {
        launchUrl("https://www.abeinstitute.com");
        },
        elevation: elevation,
        border_radius: border_radius,
        is_focused: is_focused_1,
    ),
    CardHolder(
        image_src: "assets/images/logo_lum.jpg",
        image_fit: BoxFit.fitWidth,
        title: "Lum",
        subtitle: "",
        background_image_alignment: Alignment.center,
        icon: null,
        icon_background_color: null,
        on_pressed: () {
        launchUrl("https://apps.apple.com/mx/app/lum/id1582217429?l=en");
        },
        elevation: elevation,
        border_radius: border_radius,
        is_focused: is_focused_2,
    ),
    CardHolder(
        image_src: "assets/images/logo_mobilecard.jpeg",
        image_fit: BoxFit.fitWidth,
        title: "Mobilecard",
        subtitle: "",
        background_image_alignment: Alignment.center,
        icon: null,
        icon_background_color: null,
        on_pressed: () {
        launchUrl("https://apps.apple.com/mx/app/mo/id1530448416?l=en");
        },
        elevation: elevation,
        border_radius: border_radius,
        is_focused: is_focused_3,
    ),
    CardHolder(
        image_src: "assets/images/logo_claro_pay.png",
        image_fit: BoxFit.fitWidth,
        title: "Claro Pay",
        subtitle: "",
        background_image_alignment: Alignment.center,
        icon: null,
        icon_background_color: null,
        on_pressed: () {
        launchUrl("https://apps.apple.com/mx/app/claro-pay/id1502765283?l=en");
        },
        elevation: elevation,
        border_radius: border_radius,
        is_focused: is_focused_4,
    ),
];

WidgetsCarousel(
    update_current_page: (current_page) {
        first_current_page = current_page;
        setState(() {});
    },
    auto_scroll: true,
    dot_colors_active: [
        color_purple,
        color_purple,
        color_purple,
        color_purple,
    ],
    dot_color_inactive: color_turquoise,
    children: carousel_items,
);
```

### **4 - Check Abeinstitute Repo for more examples**
[Abeinstitute Repo](https://github.com/Xapptor/abeinstitute)

[Abeinstitute](https://www.abeinstitute.com)
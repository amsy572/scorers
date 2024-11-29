-Development Approach:
The development approach for this Flutter application involved building a UI that aligns with the provided design while maintaining clear and scalable code. The app utilizes Get for easy navigation, Bloc for state management, and a responsive design approach. The core components include a header section, a momentum graph, a penalty shootout section, and a list of match incidents, with mock data provided for initial development.

-Dependencies
The application utilizes the following dependencies:

flutter_bloc: ^8.0.1.
equatable: ^2.0.5.
get: ^4.6.6.
url_launcher: ^6.1.5.
fl_chart: ^0.69.2.


-Instructions for Running the Application:
To run the application on your local development environment, follow these steps:

-Clone the repository:https://github.com/amsy572/scorers.

-IDE: Open the project in an IDE such as Android Studio.

-Install the dependencies: Ensure that you have Flutter installed and configured on your system. Run the following command to get all the required packages:flutter pub get.

-Run the application: To launch the application on an emulator or physical device, use:flutter run.


-Assumptions:
The target deployment version is iOS 16.0 and Android 12.
-Limitations:
Mock Data Only: The application currently uses mock data, which will need to be replaced or extended with real data sources for production use.
Scalability: While the current implementation focuses on the required sections, future scalability might require code refactoring and optimization.
Responsiveness: Although the UI is designed to adapt to different screen sizes, further testing is needed to guarantee consistent behavior across all devices.
Performance: The app's performance has been optimized for typical use cases; however, real-world performance tests are needed for large datasets or heavy user interactions.

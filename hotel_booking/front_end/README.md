# flutter-2024-proj
# Hotel Booking Application

This Flutter project is designed to serve as a hotel booking application, providing users with the ability to book rooms and admins to manage room details. 
The project incorporates various features to enhance user experience and security.

## Key Features

### Authentication
- Secure User Authentication:
  - Users are required to sign up or log in to access the application.
  - Authentication ensures that only registered users can make bookings and admins can manage room details.

### Authorization
- Role-Based Authorization:
  - The application implements role-based authorization to distinguish between regular customers and administrators.
  - Admins have elevated privileges to manage hotel room details, while customers have access to booking functionalities.

### User Registration
- Effortless User Registration:
  - New users can easily sign up for an account within the application.
  - User registration enables personalized experiences and allows users to manage their bookings.

### Role Assignment
- Admin and Customer Roles:
  - Upon registration, users are assigned roles - either customer or admin.
  - Admins have additional capabilities for managing hotel room details.

### Feature 1
- Booking Functionality:
  - Customers can make new bookings for hotel rooms using the mobile app.
  - Bookings include details such as check-in/out dates and room preferences.

### Feature 2
- Room Management:
  - Admins can add new hotel room details through the mobile app.
  - Admins can edit existing room information, including descriptions and images, using the mobile app.
  - Admins have the ability to delete room listings directly from the mobile app.

## Additional Flutter Features

- Mobile Compatibility:
  - The application is built using Flutter to ensure compatibility across both Android and iOS platforms.
  
- Enhanced User Experience:
  - Flutter's widget-based architecture allows for a smooth and native-like user experience.

## Database Choice

For our Flutter project, we continue to utilize MongoDB as our database due to its reliability, structured data management, 
and ability to handle complex relationships within the application.

| Group Members   | Member ID   |
|------------------|-------------|
| Heran Eshetu     | UGR/5016/14 |
| Soliyana Kewani  | UGR/6041/14 |
| Yordanos Melaku  | UGR/8211/14 |
| Yordanos Zegeye  | UGR/6316/14 |


## Usage
### For Customers and Admins
1. Access the application and sign up or log in.
2. For customers, make, edit, or cancel room reservations.
3. For admins, manage hotel room details using the mobile app.

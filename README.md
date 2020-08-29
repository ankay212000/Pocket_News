# Pocket News (PClub Summer of Code Project)
<img src="WhatsApp%20Image%202020-06-26%20at%208.00.13%20PM.jpeg" width=350 height=350>

## Special Thanks to contributors
 <a href="https://github.com/anand-aman">Aman Anand</a>, <a href="https://github.com/tanvibattu">Tanvi Battu</a>
 
A crossplatform app designed to get news after every 1 hour,
It is linked to firebase services at backend.
## Requirements
1. Flutter installed on your system
2. IDE (preferrably VS Code but sometimes exceptions are thrown that can be easily handled by Android Studios)
3. Emulator or Physical Device for debugging
4. Firebase project
## How to run
1. Download the project or clone it
2. Add an emulator or any physical device in developer mode for debugging
3. Run the main.dart file
4. To make changes to login sysytem or user level the app should be connected to firebase services hence firebase project need to be there
5. Run flutter pub get command on your terminal
## Google Sign In
  Package Requirement: <a href="https://pub.dev/packages/firebase_auth">firebase_auth</a> (for Firebase authentication) & <a href="https://pub.dev/packages/google_sign_in">google_sign_in</a> (to implement Google sign-in)
  
  SHA Key is added in the Firebase project for authenticating client (for Debug Mode)<br>
  Documentation: https://developers.google.com/android/guides/client-auth
  
  For Google Sign in Button <a href="https://pub.dev/packages/flutter_auth_buttons">flutter_auth_buttons</a> is used.
## Features
1. Get latest 1 hour news refreshed every time.
2. Firebase authentication login and Registration,Google Sign in (Google sign in implemented by <a href="https://github.com/anand-aman">Aman Anand</a>)
3. Sharing of news via any sharing medium
4. Bookmark feature (implemented by <a href="https://github.com/anand-aman">Aman Anand</a>)
5. Multilingual news (implemented by <a href="https://github.com/anand-aman">Aman Anand</a>)(We have temporarily discarded this feature because we were using a demo api for this and now the site which provides api is down and other services are paid, so whenever we'll find a replacement of existing api,this feature will be added on)
6. Categorized news (implemented by <a href="https://github.com/tanvibattu">Tanvi Battu</a>)
7. Animation(including UI, Navigation,Naviagtion bar)(implemented by <a href="https://github.com/tanvibattu">Tanvi Battu</a>) 

# Future Features
1. Recommended for you feature.

## SplashPage
<img src="Screenshot_2020-05-31-20-50-12-373_com.example.news.jpg" width=300 height=600>
## LoginPage
<img src="Screenshot_2020-05-31-20-50-16-346_com.example.news.jpg" width=300 height=600>
## RegistrationPage
<img src="Screenshot_2020-05-31-20-50-50-288_com.example.news.jpg" width=300 height=600>
## HomePage
<img src="Screenshot_2020-05-31-20-50-37-015_com.example.news.jpg" width=300 height=600>
## Drawer
<img src="Screenshot_2020-05-31-20-51-09-269_com.example.news.jpg" width=300 height=600>

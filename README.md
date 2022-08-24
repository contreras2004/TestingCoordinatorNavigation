
# TestingCoordinatorNavigation

Testing navigation coordinator example. Requires iOS 16 and tested with **Xcode 14.0 Beta 5**

This is my first attempt of creating a complete SwiftUI app with complex navigation, reusable components and well separated modules for each of the layers simulating a real environment.

This structure works well assuming that you choose to use **MVVM** in your app.

# How to run the project

The project uses Wiremock to mock the server response.

https://wiremock.org/

After installing Wiremock, go to the wiremock folder and run `make mock`. This will put up a local server.

# How to test Push notifications in the simulator:

Go to the folder `APNS simulator tests` and drag and drop each of the `.apns` files into the simulator.

# How to test deeplinks in simulator:

Execute one of the following lines in the terminal while the simulator is runing the app:

`xcrun simctl openurl booted "tcn://matiascontreras.TestingCoordinatorNavigation/exampleModal"`
`xcrun simctl openurl booted "tcn://matiascontreras.TestingCoordinatorNavigation/notification?notificationId=4"`

# WIP and Known issues

- There are many corrections to be made in the Networking module.
- There are still some changes being made to the navigation stack.
- There is no way of hiding the TabBar once you are logged in
- I'm working on a way of passing Namespaces between views to enable smooth animations
- You are welcome to open any PRs if you want to contribute

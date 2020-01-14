# NavigationDemo

This is a demo app for showing use-case of the ideas described in the [article](https://medium.com/me/stats).

To run the project open `NavigationDemo.xcodeproj`, build and run the app for the desired device.

You also can try to open URL links with scheme `navdemo://` to test the navigation. URL format should be like

- `navdemo://chat?chatId=<id>`
- `navdemo://contacts`
- `navdemo://profile`
  
Alternatively you can manually create `ViewControllerContext` and pass it to the `navigate(to:)` function of the `ViewControllerContextRouter` object.

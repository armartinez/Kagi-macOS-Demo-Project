<img src="https://github.com/armartinez/Kagi-macOS-Demo-Project/blob/main/.github/256-mac.png?raw=true" height="128">

# Kagi macOS Demo Project


Project requirements: https://hackmd.io/@kagi/S1hXCgYFkg

## Folder structure

- Features
    - Content : **Image loading functionality.**
    - Main : **Main window and toolbar functionality.**
    - Shared : **Shared functionality across the app.**
    - SideBar: **Global sidebar functionality.**
        - TabBar: **Icon tab bar functionality.**
        - Worskpace: **Workspace icons and items functionality.**

- Model: **Data model.**
- Resources: **App resources.**

## Highlights

This was a pretty fun project that covered a lot more ground than I initially expected. These are some of the most interesting parts: 

- Most of the functionality is defined programmatically, since in my experience Storyboard is rarely used because it becomes cumbersome with a shared code repository. The only parts I defined in it are the MainViewController and the SplitViewController.
- Delegation is used for communication between the `SideBarViewController` and the `TabBarViewController` via a `TabBarDelegate` protocol in order to load the workspaces. Communication between `TabBarViewController` which selects the workspace and the `ContentViewController` which loads the image is done via NotificationCenter.
- I found a problem with `NSPanGestureRecognizer` and other click events so I had to use a `NSGestureRecognizerDelegate` to allow simultaneos recognition
- In `TabBarView`, I had to add a flag to prevent re-evaluating the layout since a change that triggers collapsing into a compact view causes the layout to change.


## Known Issues

- The tab bar icon animation doesn't match the project requirement description since the scale up animation starts from the bottom corner instead of the center. I tried CATransform3DMakeScale, CGAffineTransformMakeScale and the `animator()` proxy object without success, so that's an area I need to investigate further.
- NSViewController transitions don't work well with empty NSViewController to start from, so some animations like closing the last workspace don't look great. In order to improve those situations I would switch to using `NSViewControllerPresentationAnimator` to present and dismiss the controllers.

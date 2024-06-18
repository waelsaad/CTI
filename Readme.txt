Introduction:
------------
Thank you for the opportunity of doing this code challenge. In my humble opinion I believe many developers could learn from this coding challenge as I have :]

Instructions:
------------
Version 15.3 (15E204a) Targeting iOS 17.4.

1- Ensure you have SwiftLint Installed on your machine - use brew install swiftlint
2- double click on JSONSuite.xcworkspace
3- Simply Run the app and enjoy looking at an elegant UI + Features.

You may review the .swiftlint.yml to check all enforced rules to force best practice.

JSONSuite
-----------------------------------------

This iOS App is designed to display to fetch data from JSONPlaceholder's REST API and display data in an elegant UI with a presentable flow for the screens.
It fulfills the requirements outlined in the technical task provided and contains additional features such as highlighted below including MVVM design pattern implementation, scalable layouts, testing, and accessibility support including documentation.

Important Note:-
To easily visually test the business rules simply uncomment this line to see only 3 items // self.posts = posts.topThreeSortedByTitle
If you are editing the full list of post titles, since we are sorting alphabetically the post might go to the bottom so you will not see it because its a long list.

Introduced business rules:-
- Whenever user triggers pull to refresh, a fresh fetch happens and essentially generating new dates every time a pull to refresh is triggered.
- If user deletes all posts and terminates the app it will do an automatic fresh fetch.
- When the app starts it will load existing records if available otherwise it will do a fresh fetch.
- If user edits the post title then click close without clicking update button, the post will not be updated, it will be reset.
- When user deletes an item from the edit view, the app will pop to root.

Features:-
- Implemented generic re-usable router for handling all routes.
- Designed elegant UI easy on the eye for the post list view and post details view and edit post screens.
- Utilizes scalable endpoint patterns for handling API requests and responses efficiently.
- MVVM Design Pattern with clear architecture of the App.
- Effective utilization of Swift's concurrency features to handle asynchronous operations seamlessly.
- Established a highly organized and structured architecture for the application, including a well-defined directory hierarchy.
- Fetch all posts async
- Fetch the author of the post and display the author details.
- Fetch all comments for the post and display then in an nice presentation.
- Delete button is disabled once you have deleted all posts.
- Delete each post using a press gesture and a context menu will popup
- Add Localized Strings
- Display alert messages when deleting all posts and when deleting an individual post from edit screen.
- Implement pull to refresh to perform fetching of posts
- Implement CRUD operations using SwiftData for Posts title and comment (Insert logic is implemented but no UI)
- Implemented PostsDataManager to handle all CRUD operations for Post.
- Added formatted date as required.
- Displays an error screen when there is no network connectivity.
- Interpret decodable error response from server to human readable format.
- Designed a nice error screen.
- Implements network connectivity checks to provide a seamless user experience.
- Implements generic API services and repositories for data fetching and management.
- Reusable Easy to use Font implementation for any and I used Montserrat
- Clean and decoupled code for views and methods for improved maintainability and readability.
- Utilizes fully decodable objects for parsing the JSON response from the API.
- Used SwiftLint to enforce best practice with Zero errors or warnings.
- Added comments and some documentation across the app source code.
- Implemented All Required Business Rules + Additional Features.
- Added re-usable modules, extensions and view modifiers in my Library.
- Added Unit Tests.

Decision on local storage solution:
I learnt SwiftData yesterday and I wanted to challange myself to use it in this code challange because its the Future of data persistence in Swift. It was incredably easy to use I found that SwiftData is a lightweight, fast, and easy-to-use database library. My backup approach was going to be CoreData. So please keep this in mind that this was my first attempt at using SwiftData with SwiftUI :].

If I had more time:-
- I would have liked to finish off the implementation to mark a post as a favorite and manage these posts.
- Add a success popup to inform the user when a post has been updated.
- Use my network monitor to detect when wifi is back on and do an automatic refresh when on an error screen.

Thank you again.

Wael

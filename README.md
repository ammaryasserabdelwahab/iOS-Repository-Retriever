# Simple GitHub Repository Retriever #
A Simple Repository Retriever that utilizes a __TableView__ with __custom cells__ and the __SDWebImage__ Framework to load avatar images from the GitHub repositories API.
Also uses __infinite scrolling__ so the user doesn't need to tap any buttons to go to next/previous pages, pages are loaded in automatically as user scrolls (10 repositories per page).
Redirects user to an external browser window on selecting a repository to view.

## Getting Started ##
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* A macOS Machine that can run Monterey or newer macOS versions
* Xcode 14.2 (or above)
* [CocoaPods](https://cocoapods.org/)
* Optionally an iPhone on iOS 13 or above if you want to run on your own iPhone

### How to run the project?
If you want to run the project on your machine you'll need to do the following:

```
1. Open Xcode
2. Choose Clone an existing project
   *You can optionally create a new Xcode Project and then clone through "Source Control -> Clone" and paste in the repository URL
3. Paste in the repository URL and click Clone
4. Open a terminal window and navigate to the project folder
5. run 'pod install'
6. Open 'Repository Retriever.xcworkspace'
7. You're all done! the project should now be on your machine and you should be able to run it on a simulator or your actual iPhone.
```

### Preview ###
![app preview](RepoRetriever.gif)


### Built With

* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [Xcode 14.2](https://developer.apple.com/documentation/xcode-release-notes/xcode-14_2-release-notes)


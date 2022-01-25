# ComicsReader
Available at https://github.com/marcoG82/ComicsReader

## Features

- [x] The app allows the user to visualize comics from https://xkcd.com/
- [x] The user, on app start, will see a list of 9-11 comics ordered by issue fetched randomly from 
        the list available via the xkcd.com API
- [x] Every comic preview is composed by issue, title, small comic preview, and comic explanation 
- [x] The user will be able to visualize in full screen every comic 
- [x] The user will be able to save locally the comics getting the same experience online and 
        offline
- [x] The user will be able to search through the presented comics, by issue and by text (search by
        text is performed on comic title, explanation and transcript; this last one is not showed 
        in the app) 
- [x] Implemented with Swift, Combine and SwiftUI
- [x] Making usage of Dependency Injection by kind allowance from Shortcut ... Thanks a lot

## Requirements

- **iOS 13.0+**
- **Xcode 12+**
- **SwiftUI**
- **Combine**
- **Swiftlint** ```brew install swiftlint```


## Style Guide

Following the LifesumStyleGuide ... and Gabriel's teachings:

* Make it easier to read and begin understanding the unfamiliar code.
* Make code easier to maintain.
* Reduce simple programmer errors.
* Reduce cognitive load while coding.

[Check the Style Guide] Not sure if I can post the link to the styleguide due to privacy issues

## Installation

####Via Github

Clone the repository in a local folder and open it with XCode 12+

Repository link:

HTTPS      --> https://github.com/marcoG82/ComicsReader.git

SSH        --> git@github.com:marcoG82/ComicsReader.git

GitHub CLI --> gh repo clone marcoG82/ComicsReader


## Contributing to the library

1. Clone the repository
2. Create your feature branch
3. Open the `ComicsReader.xcodeproj` file
4. Perform your changes, debug, run the unit tests
5. Make sure that all the tests pass and there are no Xcode warnings or lint issues
6. Open a pull request

7............ In case you want to help with UnitTesting Combine functions well, I'll just be happy

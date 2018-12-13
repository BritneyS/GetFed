# GetFed
**Last Updated: 12-13-18**

## Project Setup

- After cloning, navigate to directory `GetFed/GetFed` and run `pod install`
- Remove old 'Constants.swift' file in 'Helpers' directory of the project (it appears in red in XCode).

## Opening the project and running the app

- Open a free developer account (for the Food API) at https://www.edamam.com
- In XCode, open the `GetFed.xcworkspace` file
- In the `Constants-example.swift` file, replace the values for `EdamamAppID` and `EdamamAppKey` with those provided with the Edamam developer account, found in the Dashboard. The Application ID and Application Key that come with the initial 'API Signup' sample app should be fine to use.
- Change the name of this file to `Constants.swift`
- App should be ready to run!

# GetFed
**README Last Updated: 3-7-19**

## Project Setup

- After cloning, run `pod install`

## Opening the project and running the app

- Open a free developer account (for the **Food API**) at https://www.edamam.com
- In XCode, open the `GetFed.xcworkspace` file
- In the `Constants.swift` file, replace the string values for `EdamamAppID` and `EdamamAppKey` with those provided with the Edamam developer account, found in the Dashboard. The Application ID and Application Key that come with the initial 'API Signup' sample app should be fine to use.
- App should be ready to run!

## Troubleshooting

**Tests won't run!**

- Check the deployment target: `GetFed in Project Navigator > GetFed Target > General > Deployment Info`, then make sure the `Deployment Target` value is set to at least `12.0`

- Check the scheme: `GetFed > Edit Scheme... > Test` OR `Product > Scheme > Edit Scheme... > Test`, then click `+` and select `GetFedTests`

See this link for more details: https://stackoverflow.com/questions/30481630/scheme-is-not-configured-for-the-test-action-ios-xcode-project

## Credits
- `user-created.png` - icon used to indicate custom user food entry: made by [Becris](https://www.flaticon.com/authors/becris) from [www.flaticon.com](https://www.flaticon.com/free-icon/creativity_349382)

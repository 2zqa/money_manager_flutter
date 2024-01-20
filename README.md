> [!WARNING]
> This project is archived. I recommend using [oinkoin](https://github.com/emavgl/oinkoin).

# <img src="/android/app/src/main/res/mipmap-mdpi/ic_launcher.png" height="32px" width="32px" alt="App icon"></img> Money Manager

[![Build and release APKs](https://github.com/2zqa/money_manager_flutter/actions/workflows/build_and_release.yml/badge.svg)](https://github.com/2zqa/money_manager_flutter/actions/workflows/build_and_release.yml)

Keep track of income and expenses

## Description

Money Manager is an app that allows users to track their income and expenses. You can log the name and the amount of the transaction, and whether it is an income or an expense. You can view all income and expenses in a list view, along with the total balance.

## Screenshots

Coming soon.
<!-- 
<div>
    <img width="20%" src="/screenshots/1.png" alt="" title=""></img>
    <img width="20%" src="/screenshots/2.png" alt="" title=""></img>
    <img width="20%" src="/screenshots/3.png" alt="" title=""></img>
    <img width="20%" src="/screenshots/4.png" alt="" title=""></img>
</div> -->

## Installing

* Download the appropiate APK for your device from the [releases page](https://github.com/2zqa/money_manager_flutter/releases). If you don't know which to choose, you'll probably want to pick **app-arm64-v8a-release.apk**.
* If prompted, give permission to install from unknown sources
* Google Play Protect will warn you that the author of the app is not verified. You can ignore this warning by clicking **Details** and then **Install Anyway**.

## Help and feedback

If you run into any problems, or have a suggestion for a new feature, please first check if someone else has already reported/suggested it in the [issues page](https://github.com/2zqa/money_manager_flutter/issues). If not, feel free to open a new issue.

## Building from source

### Prerequisites

* Flutter >= 3.13.5
* Dart >= 3.1.2
* Java >= 17

A full tutorial on how to get started with Flutter is available at https://docs.flutter.dev/get-started/install

### Building

* Clone and open this repository: `git clone https://github.com/2zqa/money_manager_flutter.git && cd mediary`
* Run `flutter pub get`
* Setup a keystore for signing the app. You can follow [this guide](https://docs.flutter.dev/deployment/android#signing-the-app) to do so.
* Run `flutter build apk --split-per-abi`

## Contributing

Thanks for considering contributing! To get started:

1. Create an issue describing what you want to change
2. Fork this repository and clone it
3. Make your changes
4. Submit a pull request, referencing the issue you created with "Closes \#\<issue-number\>" in the description

## License

Mediary is licensed under the [GNU GPLv3](LICENSE) license.

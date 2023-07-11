
<div align="center">

  <a href=""><img src="bringit-logo.gif" alt="Brin'Git" width="200"></a>

  **A didactic and transparent GUI for Git using Gamification**

  <a href="#key-features">Key Features</a> •
  <a href="#how-to-install">How To Install</a> •
  <a href="#roadmap">Roadmap</a> •
  <a href="#how-to-contribute">How to contribute</a> •
  <a href="#troubleshooting">Troubleshooting</a>

  <a href="https://www.gnu.org/licenses/gpl-3.0"><img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="licence"/></a>
  <a href="code_of_conduct.md"><img src="https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg" alt="Contributor Covenant"/></a>
  <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Build_with-Flutter-0553B1" alt="Contributor Covenant"/></a>

  <img src="bringit-screen.gif" width="75%"/>
</div>
<br><br>

# Ambition

This project aims to develop a comprehensive graphical interface for Git that consistently let the user know what is really happening.

To accomplish this, the interface will blend the simplicity offered by Git GUIs with the control ensured by the command line.

Gamification is employed to guide users and ensure they gain a thorough understanding of how Git works.

# Key Features

> :construction: This project is under construction, those feature are planned as a MVP version

- [ ] **Create a new Git project**
- [ ] **Visualize staging area and diffs**
- [ ] **Visualize Git History**
- [ ] **Add and Restore, Stash, Commit modifications**
- [ ] **Fetch and Push branches**
- [ ] **Visualize commit details**

# How To Install

## Prerequisite

- [Flutter (>=2.2)](https://flutter.dev/docs/get-started/install) installed
- [Flutter Desktop](https://flutter.dev/desktop) enabled

```bash
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
```

> Additional steps for Windows
>
> ```bash
> flutter channel dev
> flutter upgrade
> flutter config --enable-windows-uwp-desktop
> ```

## Build from sources
1. Clone the project
2. `flutter pub get` *download dependencies*
3. `flutter devices` *list devices, ensure your OS is available*
4. `flutter run -d <device>` *run the project on \<device>, linux, windows or macos*

**:thumbsup: You are Ready to Go!**

# Gamification

> Coming soon...

# Roadmap

## MVP

- [ ] Create a new Git Project
- [ ] Display working tree state
- [ ] Display current diff (staged & modified)
- [ ] Display commits log (list version)
- [ ] Add & Restore
- [ ] Commit
- [ ] Fetch, Rebase & Push
- [ ] Create new branches

# Contributors

- Jules Chevalier
- Sami Sheikh
- Nathanael Schmitt
- Ludovic Reus
- Mégane Foussa
- Thibault Rousset
- Noémie Allouche

# How to contribute

1. Clone the project

2. Enable project specific git hooks

   ```bash
   cd bringit/
   git config core.hooksPath .githooks
   ```

3. Resolve the issue/bug following the [Developer's guide](CONTRIBUTE.md)

4. Push your code on the corresponding branch

   ```bash
   git switch -c <issue-number>-<issue-name>
   git commit
   git push
   ```

5. Submit your Merge Request !

## Directory Structure

- `lib/`
  - `screen/` contains all *screens*, *i.e.* all widgets that are displayed on their own on the screen (not included in another widget)
  - `widget/` contains all project custom widgets
    - `button/`
  - `utils/` miscellaneous classes for utility methods
  - `git/` lib to access the git layer
- `assets/`
  - `fonts/`
- `test/`
  - `test_repository` empty folder, can be used as repository folder for tests
  
## Application Structure

In order to keep the application code maintainable we decided to separate the code dedicated to print
the User Interface (Widgets) from the code interacting with the Git application. This allows us to
separate the code as if we were having a Front-End manipulating a library. It does even more by making
our "library" available from any Widget context.

This was achieved with the InheritedWidget technology made easier with the package [Provider](https://pub.dev/packages/provider).
The GitProxy abstract class defines a facade injected in the Flutter framework thanks to the
ChangeNotifierProvider Widget. Every widget is now able to interact with GitProxy thanks to Consumer
and Provider widgets. See [the official Flutter state management documentation](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)
to learn more about these Widgets.

## Project commands

- `make test` will run all unit and component tests located in /test directory
- `make clean` will analyze and format your code to keep it to the upper standards

## Tests based on git command results

As the project need to execute commands with Git and adapt their results it is
essential to be able to test project elements fulfilling this purpose.
Test tagged with `file-system-dependent` are expected to run on an isolated environment
of the file system created by the script [git_interpreter_fixtures.sh](test/scripts/git_interpreter_fixtures.sh)
located in `/tmp` directory on linux and macOS systems.

## Testing Consumer and Provider widgets

Class [GitDependentLoader](test/git_dependent_loader.dart) provides a simple way to load any widget
in a test application: It will provide in its context an instance of GitProxy as a ChangeNotifier.
You just need to instantiate the tested widget and pass it to GitDependentLoader.

```dart
// import flutter_test and git_dependent_loader.

testWidgets('my git dependent test', (WidgetTester tester) async {
  final GitDependentLoader loader = GitDependentLoader();
  final Widget app = loader.loadAppWithWidget(const MyTestedWidget());
```

If no GitProxy is provided, loader will provide a new instance of [GitProxyMock](test/mock/git_proxy_mock.dart)
but you may also pass a reference to your own GitProxy to manipulate it in your test.

```dart
  final GitProxy git = GitProxyMock();
  final Widget app = loader.loadAppWithWidget(const MyTestedWidget(), git);

```

You will then be able to "pump" application and test your widget's behavior.

```dart
  await tester.pumpWidget(app);

  // Do your tests
  // expect(..., ...);
});
```

## Integration tests

Directory integration_test contains tests that are not triggered with th command `make test`for
performance purpose. See [flutter integration test documentation](https://docs.flutter.dev/cookbook/testing/integration/introduction)
to learn more on them. They can be launched with the command:
`flutter test integration_test/[your-integration-test].dart`

# License

Brin'Git is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.html) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Please see the [COPYING](COPYING) file in our repository for the full text.

# Troubleshooting

## CMake error on flutter run

If you encounter a C++ compiler error when running `flutter -d linux` command, try to update your C++  
related packages, then clear the build and .dart_tool directories:

```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev  
flutter clean
```

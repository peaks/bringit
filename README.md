<h1 align="center">A Practical/Tutoring Git Interface</h1>
<p align="center">A Git GUI that teach you git on the fly.</p>

[![build status](https://project.peaks.fr/peaks-ri/git-ihm/badges/master/pipeline.svg)]() [![code coverage](https://img.shields.io/gitlab/coverage/internal/mdc/master)]()
[![licence](https://img.shields.io/badge/licence-Copyright%20%C2%A9%20Peaks%202021-blue)]() [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](code_of_conduct.md)

## Ambition

The main goal of this project is to provide a full featured Git graphical interface that always let the user know what is really hapenning.

To achieve this, the interface shall mix both the simplicity provided by Git GUIs and the control ensured by the command line.



## Features

> :construction: This project is under construction, those feature are planned as a MVP version

Use Git easily and graphically without loosing the core of its complexity.

- **Clone, commit, rebase, merge... Use every feature of Git**

- **Visualize every important information in real time**

- **Always have an eye on the terminal, see exactly what is happening**

- **Build complex commands from the GUI, and learn how to use Git like a pro**

## Prerequisite

- [Flutter (>=2.2)](https://flutter.dev/docs/get-started/install) installed
- [Flutter Desktop](https://flutter.dev/desktop) enabled

```bash
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop
```

> Additional steps for Windows
> ```bash
> flutter channel dev
> flutter upgrade
> flutter config --enable-windows-uwp-desktop
> ```

## Installation

### Build from sources

1. `git clone git@git.peaks.fr:peaks-ri/git-ihm.git` *clone the project*
2. `flutter pub get` *download dependencies*
3. `flutter devices` *list devices, ensure your OS is available*
4. `flutter run -d <device>` *run the project on \<device>, linux, windows or macos*

**:thumbsup: You are Ready to Go!**

## Quick startup

> Coming soon...

## Documentation

Full documentation will be available [here](https://project.peaks.fr/peaks-ri/git-ihm/-/wikis/home)

## Future Updates

- [ ] Display current state of the repository
- [ ] Display the project folders/files hierarchy and their state through Git
- [ ] Add options to Git commands with GUI only
- [ ] Multi-repository
- [ ] Commits graph

## For developers

### Directory Structure

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

### Run tests

`make test`

## test based on git command results
As the project need to execute commands with Git and adapt their results it is 
essential to be able to test project elements fulfilling this purpose.
Test tagged with `git-interpreter` are expected to run on an isolated environment 
of the file system created by the script [git_interpreter_fixtures.sh](./test/scripts/git_interpreter_fixtures.sh)
located in `/tmp` directory on linux and macOS systems.

### How to contribute 💪

1. Clone the project
```
git clone git@git.peaks.fr:peaks-ri/git-ihm.git
```
2. Configure git locally to use our custom hooks
```
cd git-ihm/
git config core.hooksPath .githooks
```
3. Choose your issue from the [project's board](https://project.peaks.fr/peaks-ri/git-ihm/-/boards)
4. Create a Merge Request from the issue (and get the branch name)
5. Resolve the issue following the [Developer's guide](https://project.peaks.fr/peaks-ri/charte-projets-ri)
6. Push your code on the corresponding branch
```
git checkout -b <issue-number>-<issue-name>
git commit
git push
```
6. Submit your Merge Request !

## Troubleshooting

### CMake error on flutter run:

If you encounter a C++ compiler error when running `flutter -d linux` command, try to update your C++  
related packages, then clear the build and .dart_tool directories:
```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev  
flutter clean
```

## 🧑🏻 Contributors

- Jules Chevalier ([@jchevalier](https://project.peaks.fr/jchevalier))
- Ludovic Réus ([@lreus](https://project.peaks.fr/lreus))

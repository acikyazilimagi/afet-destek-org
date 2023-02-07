# Yardım Ağı

## Getting Started

### Here's the steps you should take to run the project:

#### using flutter commands
1. install the dependencies 
  - terminal: `flutter pub get`
  - vsc task: press `F1`, search for `Tasks: run task` and select `pub get main`
2. run code generator
  - terminal: `bash scripts/build_runner.sh` or `flutter pub run build_runner build --delete-conflicting-outputs`
  - vsc task: press `F1`, search for `Tasks: run task` and select `build_runner main`

#### using fvm
1. install the dependencies 
  - terminal: `fvm flutter pub get`
  - vsc task: press `F1`, search for `Tasks: run task` and select `pub get main (fvm)`
2. run code generator
  - terminal: `bash scripts/build_runner_fvm.sh` or `fvm flutter pub run build_runner build --delete-conflicting-outputs`
  - vsc task: press `F1`, search for `Tasks: run task` and select `build_runner main (fvm)`
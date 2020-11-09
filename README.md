# wenn_flutter_poc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to run app

1. Initial Environment config

In this project we have 3 environment configurations:
- dev
- stag
- prod

To setup them correctly please go to Edit Configuration next to green button to run project on simulator.
Then add 3 new Flutter configurations.
Name them dev, stag and prod respectively.

In dart entrypoint set main dart file. That is main_$ENV.dart
In "Additional arguments" field add: --flavor=$ENV
In Build flavor add: $ENV

Where $ENV is dev, stag or prod


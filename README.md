# Enţrirç

Enţrirç (New Ithkuil word for "an utility set", pronounced `/enθɾiɾç/`, also written as
"enthrirhc") is a tool that aims to make it easier to learn the New Ithkuil.

## Supported Platforms

| Platform | Status |
| -------- | ------ |
| Android  | ✅     |
| Web (PWA) | ✅     |
| Linux    | 🆗     |
| Windows  | 🆗     |
| macOS    | ❌     |
| iOS      | ❌     |

> **Note**
>
> For macOS & iOS users: Open [Enţrirç](https://yuorb.github.io/enthrirhc/) in Safari and install it as a [PWA](https://en.wikipedia.org/wiki/Progressive_web_app) instead. This project does not offer the source code for macOS & iOS, because the developer(@lomirus) has no macOS device to get the Enţrirç adapted for, and after all, it's not a small amount of money to spend $99 per year to be an Apple Developer just in order to publish a free & open source App :P

## Build

Before building, run:

```command
flutter pub get
dart run build_runner build
dart run vector_graphics_compiler --input-dir assets/icons --out-dir assets/icons_compiled
```

### Android

```command
flutter build apk --split-per-abi
```

### Web

```command
flutter build web
```

### Windows

```command
flutter build windows
```

### Linux

```command
flutter build linux
```

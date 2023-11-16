# Enţrirç

Enţrirç (New Ithkuil word for "an utility set", pronounced `/enθɾiɾç/`, like
"enthrirch") is a tool that aims to make it easier to learn the New Ithkuil.

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
> For Linux & Windows users: Use [Web version](https://yuorb.github.io/enthrirch/) instead. This project offers the source code for Windows & Linux, so you can also build this project yourself manually.
>
> For macOS users: Use [Web version](https://yuorb.github.io/enthrirch/) instead. This project does not offer the source code for macOS.
>
> For iOS users: Open [Enţrirç](https://yuorb.github.io/enthrirch/) in Safari
> and install it as a PWA instead.

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

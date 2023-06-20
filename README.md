# Enţrirç

Enţrirç (Ithkuil IV word for "an utility set", pronounced `/enθɾiɾç/`, like "enthrirch") is a tool that aims to make it easier to learn the Ithkuil IV.

## Supported Platforms

| Platform  | Status |
| --------- | ------ |
| Android   | ✅     |
| Web(PWA) | ✅     |
| Linux     | 🆗     |
| Windows   | 🆗     |
| macOS     | ❌     |
| iOS       | ❌     |

✅ = First Class Support, 🆗 = Support, ❌ = Not Support

## Build

Before building, run:

```command
flutter pub get
dart run build_runner build
```

### Android

```command
flutter build apk --split-per-abi
```

### Web

```command
flutter build web
```

<center><img src="https://cdn.projetretro.io/github/fxo.png" alt="Flutter and OpenMoji logos"></center>

[OpenMoji](https://openmoji.org) is an open-source project of 50+ students and 2 professors of the [HfG Schwäbisch Gmünd](http://www.hfg-gmuend.de/) (Design University) and external contributers.

This package bring those handcrafted magnciient emojis into your flutter projects.

This project is not affiliated nor endorsed by the OpenMoji team.

## Features

- Almost all the icons [OpenMoji](https://openmoji.org) avaible inside your flutter project and compatible with the Icon widget

## Getting started

Run 
```bash
 flutter pub add flutter_openmoji
```
## Usage

```dart
const IconButton(onPress: () => print('OpenMoji'), icon: Icon(OpenmojiIcons.airplane));
```

Keep in mid some icons names have to be changed to be usable in Flutter and some icons have to be prefixed because they had the same name 

Example : 
The `microbe` emoji  exists into two categories `animal-bug` (<img src="https://www.openmoji.org/php/download_asset.php?type=emoji&emoji_hexcode=1F9A0&emoji_variant=color" height="32px">) and `extras-openmoji` (<img src="https://www.openmoji.org/php/download_asset.php?type=emoji&emoji_hexcode=E011&emoji_variant=color" height="32px">).

To avoid conflict icons under `extras-*`categories are prefixed with `extras_` .

AS well icon using Dart / Flutter keyword as name (e.g. : switch, return, etc.) are suffixed with `_icon`. 



## Build

The build process target the `main` branch of [OpenMoji Github repo ](https://github.com/hfg-gmuend/openmoji)

Running
```bash
    dart run tool\generate_openmoji.dart
```

will trigger the building process erasing the content of `lib/src/openmoji_icons.dart` and `assets\fonts\OpenMoji-Black.ttf` with cotent from the repo.

You can customize the ouputted class by modiying the `tool\openmoji_icons.partial` file. 

## Additional information

[OpenMoji](https://openmoji.org) is an open-source project of 50+ students and 2 professors of the [HfG Schwäbisch Gmünd](http://www.hfg-gmuend.de/) (Design University) and external contributers.

**All emojis designed by [OpenMoji](https://openmoji.org) – the open-source emoji and icon project. License: CC BY-SA 4.0**    
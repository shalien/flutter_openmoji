import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';

/// This tool will generate

const List<String> reservedKeyword = <String>['switch', 'return'];

const List<String> files = <String>[
  'cbdt',
  'colr0_svg',
  'colr1_svg',
  'glyf_colr_0',
  'glyf_colr_1',
  'picosvgz',
  'sbix',
  'untouchedsvgz'
];

const List<String> extensions = ['ttf'];

final Directory fontsDirctory = Directory('lib${separator}fonts');

final File openmojiMetadataFile =
    File('${Directory.systemTemp.path}${separator}openmoji.json');

const String openmojiMetadataUrl =
    'https://github.com/hfg-gmuend/openmoji/raw/master/data/openmoji.json';

final File partialOpenmojiIconsClass =
    File('tool${separator}openmoji_icons.partial');

Future<void> main() async {
  stdout.writeln('Creating assets directory');

  stdout.writeln('Creating fonts directory');
  if (!await fontsDirctory.exists()) {
    await fontsDirctory.create();
  }

  stdout.writeln('Downloading Openmoji metadata file');
  Uri metadataFileUri = Uri.parse(openmojiMetadataUrl);

  var openmojiMetadataFileResponse = await get(metadataFileUri);

  if (openmojiMetadataFileResponse.statusCode != 200) {
    stderr.writeln('Unable to download metadata file !');
    exit(-1);
  }

  await openmojiMetadataFile
      .writeAsBytes(openmojiMetadataFileResponse.bodyBytes);

  for (String filesName in files) {
    final File openmojiIconsClass = File(
        'lib${separator}src${separator}openmoji_icons_color_${filesName.toLowerCase().replaceAll('-', '_')}.dart');

    for (String extension in extensions) {
      final url =
          'https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/font/OpenMoji-color-$filesName/OpenMoji-color-$filesName.$extension';

      final File fontFile = File(
          '${fontsDirctory.path}${separator}OpenMoji-color-$filesName.$extension');

      if (await fontFile.exists()) {
        await fontFile.delete();
      }

      Uri fileUri = Uri.parse(url);

      var response = await get(fileUri);

      switch (response.statusCode) {
        case 200:
        case 204:
          await fontFile.writeAsBytes(response.bodyBytes);
          break;
      }
    }

    if (await openmojiIconsClass.exists()) {
      await openmojiIconsClass.delete();
    }

    StringBuffer stringBuffer = StringBuffer();

    stdout.writeln('Generating icons class');

    List<dynamic> jsonData =
        jsonDecode(await openmojiMetadataFile.readAsString());

    for (Map<String, dynamic> data in jsonData) {
      String prefix = '';

      var hexCode = data['hexcode'].toString();

      if (hexCode.contains('-')) {
        continue;
      }

      var category = data['group'].toString();
      if (category.trim().toLowerCase().startsWith('extras')) {
        prefix = 'extras_';
      }

      var annotation = data['annotation'];

      if (reservedKeyword.contains(annotation)) {
        annotation = '${annotation}_icon';
      }

      var author = data['openmoji_author'].toString().trim();

      var formmatedAnnotation = annotation
          .toLowerCase()
          .replaceAll('-', '_')
          .replaceAll(' ', '_')
          .replaceAll('!', '')
          .replaceAll('“', '')
          .replaceAll('”', '')
          .replaceAll(':', '')
          .replaceAll('.', '')
          .replaceAll('ä', 'a')
          .replaceAll('ü', 'u')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('’', '')
          .replaceAll('ñ', 'n')
          .replaceAll('1st', 'first')
          .replaceAll('2nd', 'second')
          .replaceAll('3rd', 'third');

      stringBuffer.writeln(
          '/// <img src="https://www.openmoji.org/data/color/svg/${hexCode.toUpperCase()}.svg" width="24" height="24"/> Icon $hexCode named $annotation (use [$formmatedAnnotation]');
      if (author.isNotEmpty) {
        stringBuffer.writeln('/// Created by $author');
      }
      stringBuffer.writeln(
          'static const IconData $prefix$formmatedAnnotation = IconData(0x$hexCode, fontFamily: \'OpenMoji-Color-$filesName\', fontPackage: _kFontPkg);');
      stringBuffer.writeln();
    }

    String partialFile = await partialOpenmojiIconsClass.readAsString();
    String classContent = partialFile
        .replaceAll('@icons', stringBuffer.toString())
        .replaceAll('OpenmojiIcons',
            'OpenmojiIcons${filesName.replaceAll('_', '').replaceAll('-', '').toUpperCase()}');

    await openmojiIconsClass.writeAsString(classContent);
  }

  stdout.writeln('Deleting metadata file');
  await openmojiMetadataFile.delete();
}

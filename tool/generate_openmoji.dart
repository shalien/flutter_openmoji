import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';

/// This tool will generate

const List<String> reservedKeyword = <String>['switch', 'return'];

const List<String> files = <String>[
  'cbdt',
  'glyf_colr_0',
  'glyf_colr_1',
  'picosvgz',
  'sbix',
  'untouchedsvgz'
];

final Directory assetsDirectory = Directory('assets');
final Directory fontsDirctory =
    Directory('${assetsDirectory.path}${separator}fonts');

final File openmojiBlackFontFile =
    File('${fontsDirctory.path}${separator}OpenMoji-Black.ttf');

final File openmojiColorFontFile =
    File('${fontsDirctory.path}${separator}OpenMoji-Color.ttf');

final File openmojiMetadataFile =
    File('${Directory.systemTemp.path}${separator}openmoji.json');

const String openmojiMetadataUrl =
    'https://github.com/hfg-gmuend/openmoji/raw/master/data/openmoji.json';

const String openmojiBlackFontFileUrl =
    'https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/font/OpenMoji-Black.ttf';

const String openmojiColorFontFileUrl =
    'https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/font/OpenMoji-Color.ttf';

final File openmojiIconsClass =
    File('lib${separator}src${separator}openmoji_icons.dart');

final File partialOpenmojiIconsClass =
    File('tool${separator}openmoji_icons.partial');

Future<void> main() async {
  if (await openmojiIconsClass.exists()) {
    await openmojiIconsClass.delete();
  }

  stdout.writeln('Creating assets directory');

  if (!await assetsDirectory.exists()) {
    await assetsDirectory.create();
  }

  stdout.writeln('Creating fonts directory');
  if (!await fontsDirctory.exists()) {
    await fontsDirctory.create();
  }

  stdout.writeln('Downloading Openmoji black font file');
  Uri blackFontFileUri = Uri.parse(openmojiBlackFontFileUrl);

  var openmojiBlackFontFileResponse = await get(blackFontFileUri);

  if (openmojiBlackFontFileResponse.statusCode != 200) {
    stderr.writeln('Unable to download font file !');
    exit(-1);
  }

  await openmojiBlackFontFile
      .writeAsBytes(openmojiBlackFontFileResponse.bodyBytes);

  stdout.writeln('Downloading Openmoji color font file');
  Uri colorFontFileUri = Uri.parse(openmojiColorFontFileUrl);

  var openmojiColorFontFileResponse = await get(colorFontFileUri);

  if (openmojiColorFontFileResponse.statusCode != 200) {
    stderr.writeln('Unable to download font file !');
    exit(-1);
  }

  await openmojiColorFontFile
      .writeAsBytes(openmojiColorFontFileResponse.bodyBytes);

  stdout.writeln('Downloading Openmoji metadata file');
  Uri metadataFileUri = Uri.parse(openmojiMetadataUrl);

  var openmojiMetadataFileResponse = await get(metadataFileUri);

  if (openmojiMetadataFileResponse.statusCode != 200) {
    stderr.writeln('Unable to download metadata file !');
    exit(-1);
  }

  await openmojiMetadataFile
      .writeAsBytes(openmojiMetadataFileResponse.bodyBytes);

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
        'static const IconData $prefix$formmatedAnnotation = IconData(0x$hexCode, fontFamily: \'OpenMoji-Color\', fontPackage: _kFontPkg);');
    stringBuffer.writeln();
  }

  String partialFile = await partialOpenmojiIconsClass.readAsString();
  String classContent =
      partialFile.replaceAll('@icons', stringBuffer.toString());

  await openmojiIconsClass.writeAsString(classContent);

  stdout.writeln('Deleting metadata file');
  await openmojiMetadataFile.delete();
}

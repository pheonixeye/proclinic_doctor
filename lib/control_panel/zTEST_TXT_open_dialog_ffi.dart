import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:localstorage/localstorage.dart';

void opendialogTXT() {
  //TODO:use file picker windows

  // MAX_PATH may truncate early if long filename support is enabled
  final pathRes = '/';
  final textpathstreamput = LocalStorageTextPath();
  textpathstreamput.addTextPathLocalStorage(textPath: pathRes);
  print('Result: $pathRes');
}

//class for path of print file + add path to local storage
class LocalStorageTextPath {
  LocalStorageTextPath() {
    textLocalStoragePath.listen((event) {
      _controller.add(event);
    });
  }

  Future addTextPathLocalStorage({required String textPath}) async {
    final storage = LocalStorage('TextPath.json');
    await storage.ready;
    await storage.setItem('textpath', textPath);
  }

  Future<File> get _localFile async {
    Stream<String> printFilePath = await textLocalStoragePath;
    String filePath = await printFilePath.first.then((value) {
      return value;
    });
    print('file Path from stream => ${filePath}');
    // final path = await _localPath;
    return File(filePath);
  }

  Stream<String> get textLocalStoragePath async* {
    LocalStorage storage = LocalStorage('TextPath.json');
    await storage.ready;
    String path = storage.getItem('textpath');
    printtextfileglobalpath = storage.getItem('textpath');
    yield path.toString();
  }

  StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get textPath => _controller.stream;
}

String? printtextfileglobalpath;

//TODO: control print format in file
//print file creation
class CreateFileForPrint {
  String data;
  LocalStorageTextPath textpathlocalstorage = LocalStorageTextPath();
  CreateFileForPrint({required this.data});

  Future<File> get _localFile async {
    Stream<String> printFilePath = await textpathlocalstorage.textPath;
    String filePath = await printFilePath.first.then((value) {
      return value;
    });
    print('file Path from stream => ${filePath}');
    // final path = await _localPath;
    return File(filePath);
  }

  Future<File> writeData() async {
    final file = await _localFile;
    // await print('data written to print file');
    // Write the file.
    return file.writeAsString(data);
  }

  Future printDocAfterAddData() async {
    // await print('printDocAfterAddData called');
    LocalStorage storage = LocalStorage('TextPath.json');
    await storage.ready;
    String path = storage.getItem('textpath');
    // await print('print process started');

    // ShellExecute(1, TEXT('print'), TEXT(path), nullptr, nullptr, SW_SHOW);
    //TODO: test / find a printing package

    // await print('print process finished');
  }
}

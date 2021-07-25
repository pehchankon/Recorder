import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  FlutterSoundRecorder? _audioRecorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  IconData icon = Icons.mic;

  Future init() async {
    if (await Permission.microphone.request().isDenied) {
      Fluttertoast.showToast(
        msg: "Mic permission not granted",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  Future disp() async {
    await _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  void record() async {
    !_isRecorderInitialized ? init() : null;
    if (await Permission.microphone.request().isGranted) {
      if (_audioRecorder!.isRecording) {
        await _audioRecorder!.stopRecorder();
      } else {
        DateTime now = new DateTime.now();
        String path = now.hour.toString() +
            '-' +
            now.minute.toString() +
            '-' +
            now.second.toString() +
            '.aac';
        await _audioRecorder!
            .startRecorder(toFile: '/storage/emulated/0/Download/' + path);
      }
      setState(() {});
    } else {
      Fluttertoast.showToast(
        msg: "Mic permission not granted",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    disp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    icon = _audioRecorder!.isRecording ? Icons.stop : Icons.mic;
    return ElevatedButton(
      onPressed: record,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Icon(
          icon,
          size: 60,
          color: const Color(0xFFEDEDED),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: const Color(0xFFDA0037),
      ),
    );
  }
}

import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();
  static Future<void> playCorrectSound() async {
    await _player.play(AssetSource('sound/correct-answer.mp3'));
  }

  static Future<void> playWrongSound() async {
    await _player.play(AssetSource('sound/wrong-answer.wav'));
  }
}

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class AudioVisualizerScreen extends StatefulWidget {
  @override
  _AudioVisualizerScreenState createState() => _AudioVisualizerScreenState();
}

class _AudioVisualizerScreenState extends State<AudioVisualizerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<double> waveformData = [];
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  Future<void> loadAudio() async {
    // Load and play an audio file (replace with your audio URL or local path)
    await _audioPlayer.setSource(UrlSource(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"));

    // Listen for waveform data updates
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        waveformData = List.generate(
            30, (index) => (index % 2 == 0 ? 0.8 : 0.3)); // Simulated waveform
      });
    });
  }

  void playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(

              // child: AudioWaveforms(
              //   waveStyle: WaveStyle(
              //     waveColor: Colors.blue,
              //     showTop: true,
              //     showBottom: true,
              //     spacing: 6.0,
              //     extendWaveform: true,
              //   ),
              //   size: Size(MediaQuery.of(context).size.width, 100),
              //   waveformData: waveformData,
              // ),
              ),
          SizedBox(height: 20),
          IconButton(
            icon: Icon(
                isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 50,
                color: Colors.white),
            onPressed: playPauseAudio,
          ),
        ],
      ),
    );
  }
}

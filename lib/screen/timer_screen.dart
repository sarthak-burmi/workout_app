import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/contants/color.dart';
import 'package:workout_app/contants/constant.dart';
import 'package:workout_app/model/exercise_modal.dart';
import 'package:workout_app/provider/user_provider.dart';

class ExerciseCountdownScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCountdownScreen({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  _ExerciseCountdownScreenState createState() =>
      _ExerciseCountdownScreenState();
}

class _ExerciseCountdownScreenState extends State<ExerciseCountdownScreen> {
  String _quote = '';
  String _quoteAuthor = '';
  late Timer _timer;
  int _countdown = 10;
  final AudioPlayer _player = AudioPlayer();
  bool _backgroundMusicEnabled = true;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
    _startCountdown();
    _initPlayer();
    _loadBackgroundMusicSetting();
  }

  @override
  void dispose() {
    _timer.cancel();
    _player.dispose();
    super.dispose();
  }

  void _initPlayer() async {
    try {
      await _player.setAsset('assets/audio/backgroundmusic.mp3');
      _player.setLoopMode(LoopMode.one);
      if (_backgroundMusicEnabled) {
        await _player.play();
      }
    } catch (e) {
      print('Error initializing player: $e');
    }
  }

  void _loadBackgroundMusicSetting() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      _backgroundMusicEnabled =
          userProvider.user?.enableBackgroundMusic ?? true;
      if (_backgroundMusicEnabled) {
        _playBackgroundMusic();
      }
    });
  }

  Future<void> _fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(Constants.quoteApiUrl));
      if (response.statusCode == 200) {
        final jsonData = response.body;
        final dynamic data = jsonDecode(jsonData);
        if (data is Map<String, dynamic> && data.containsKey('quotes')) {
          final quotes = data['quotes'] as List;
          if (quotes.isNotEmpty) {
            final randomIndex =
                DateTime.now().millisecondsSinceEpoch % quotes.length;
            final quoteData = quotes[randomIndex];
            if (mounted) {
              setState(() {
                _quote = quoteData['quote'];
                _quoteAuthor = quoteData['author'];
              });
            }
          }
        } else {
          throw Exception('Invalid quote response format');
        }
      } else {
        throw Exception('Failed to fetch quote');
      }
    } catch (e) {
      print('Error fetching quote: $e');
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            _timer.cancel();
            _showCongratulationDialog();
          }
        });
      }
    });
  }

  void _showCongratulationDialog() {
    showDialog(
      //barrierColor: Colors.grey.withOpacity(10),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Congratulations!',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You have completed the exercise.',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mainColor),
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.completeExercise(widget.exercise.name);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exercise.name,
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  widget.exercise.imageUrl,
                  fit: BoxFit.contain,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Text(
                '$_countdown',
                style: GoogleFonts.roboto(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                '$_quote',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 18),
              ),
              Text(
                '- $_quoteAuthor -',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Background Music',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: mainColor,
                    value: _backgroundMusicEnabled,
                    onChanged: (value) {
                      setState(() {
                        _backgroundMusicEnabled = value;
                      });
                      if (value) {
                        _playBackgroundMusic();
                      } else {
                        _stopBackgroundMusic();
                      }
                      userProvider.toggleBackgroundMusic(value);
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    _addExtraTime(10); // Add 10 seconds
                  },
                  child: Text(
                    'Add 10 Seconds',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addExtraTime(int seconds) {
    setState(() {
      _countdown += seconds;
    });
  }

  Future<void> _playBackgroundMusic() async {
    try {
      await _player.play();
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> _stopBackgroundMusic() async {
    try {
      await _player.stop();
    } catch (e) {
      print('Error stopping background music: $e');
    }
  }
}

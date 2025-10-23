import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailScreen extends StatefulWidget {
  final Map<String, dynamic> lesson;

  const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isMuted = false;
  bool _isPlaying = false;
  double _playbackRate = 1.0;
  bool _isDisposing = false;
  bool _isFullScreen = true;
  bool _showControls = true;
  Timer? _controlsTimer;

  @override
  void initState() {
    super.initState();
    _enterFullScreenMode();
    _initializeYouTubePlayer();
    _startControlsTimer();
  }

  void _enterFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _exitFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _initializeYouTubePlayer() {
    try {
      String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';

      if (videoUrl != null && videoUrl.isNotEmpty) {
        String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              enableCaption: true,
              captionLanguage: 'ar',
              hideControls: true,
              controlsVisibleAtStart: false,
              useHybridComposition: true,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: true,
              startAt: 0,
            ),
          );

          _controller!.addListener(_videoListener);

          if (mounted) {
            setState(() {
              _isPlayerReady = true;
            });
          }

        } else {
          _setErrorState('رابط الفيديو غير صالح');
        }
      } else {
        _setErrorState('لا يتوفر فيديو لهذا الدرس');
      }
    } catch (e) {
      _setErrorState('خطأ في تهيئة مشغل الفيديو: $e');
    }
  }

  void _videoListener() {
    if (!mounted || _isDisposing) return;

    if (_controller != null) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  void _setErrorState(String message) {
    if (mounted && !_isDisposing) {
      setState(() {
        _hasError = true;
        _errorMessage = message;
        _isPlayerReady = false;
      });
    }
  }

  void _stopVideoBeforeExit() {
    if (_controller != null && _isPlayerReady) {
      _controller!.pause();
      _controller!.seekTo(Duration.zero);
    }
  }

  Future<bool> _onWillPop() async {
    _exitFullScreenMode();
    _stopVideoBeforeExit();
    await Future.delayed(Duration(milliseconds: 200));
    return true;
  }

  void _togglePlayPause() {
    if (_isPlayerReady && _controller != null && !_isDisposing) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _showControlsTemporarily();
    }
  }

  void _toggleMute() {
    if (_controller != null && !_isDisposing) {
      if (_isMuted) {
        _controller!.unMute();
      } else {
        _controller!.mute();
      }
      setState(() {
        _isMuted = !_isMuted;
      });
      _showControlsTemporarily();
    }
  }

  void _seekForward(int seconds) {
    if (_controller != null && !_isDisposing) {
      final newPosition = _controller!.value.position + Duration(seconds: seconds);
      _controller!.seekTo(newPosition);
      _showControlsTemporarily();
    }
  }

  void _seekBackward(int seconds) {
    if (_controller != null && !_isDisposing) {
      final newPosition = _controller!.value.position - Duration(seconds: seconds);
      _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
      _showControlsTemporarily();
    }
  }

  void _changePlaybackRate(double rate) {
    if (_controller != null && !_isDisposing) {
      _controller!.setPlaybackRate(rate);
      setState(() {
        _playbackRate = rate;
      });
      _showControlsTemporarily();
    }
  }

  void _showControlsTemporarily() {
    setState(() {
      _showControls = true;
    });
    _startControlsTimer();
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(Duration(seconds: 3), () {
      if (mounted && !_isDisposing && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  Widget _buildYouTubeLikeControls() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            // زر التشغيل/الإيقاف في المنتصف
            if (!_isPlaying || _showControls)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 40.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // التحكم السفلي (مثل اليوتيوب)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // شريط التقدم
                    Container(
                      height: 3.h,
                      child: ProgressBar(
                        isExpanded: true,
                        controller: _controller!,
                        colors: ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.red,
                          backgroundColor: Colors.grey[800]!,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // أزرار التحكم
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            // زر التشغيل/الإيقاف
                            IconButton(
                              onPressed: _togglePlayPause,
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),

                            // الوقت المنقضي
                            Text(
                              _formatDuration(_controller?.value.position ?? Duration.zero),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),

                            // زر الكتم/فك الكتم
                            IconButton(
                              onPressed: _toggleMute,
                              icon: Icon(
                                _isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),

                            // سرعة التشغيل
                            PopupMenuButton<double>(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onSelected: _changePlaybackRate,
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 0.5, child: Text('0.5x')),
                                PopupMenuItem(value: 0.75, child: Text('0.75x')),
                                PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
                                PopupMenuItem(value: 1.25, child: Text('1.25x')),
                                PopupMenuItem(value: 1.5, child: Text('1.5x')),
                                PopupMenuItem(value: 1.75, child: Text('1.75x')),
                                PopupMenuItem(value: 2.0, child: Text('2.0x')),
                              ],
                            ),

                            Spacer(),

                            // الوقت المتبقي
                            Text(
                              '-${_formatDuration((_controller?.value.metaData.duration ?? Duration.zero) - (_controller?.value.position ?? Duration.zero))}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),

                            SizedBox(width: 16.w),

                            // زر الشاشة الكاملة
                            IconButton(
                              onPressed: () async {
                                if (await _onWillPop()) {
                                  Navigator.of(context).pop();
                                }
                              },
                              icon: Icon(
                                Icons.fullscreen_exit,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // التحكم العلوي (العنوان وزر العودة)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      // زر العودة
                      IconButton(
                        onPressed: () async {
                          if (await _onWillPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),

                      // عنوان الفيديو
                      Expanded(
                        child: Text(
                          widget.lesson['title'] ?? 'عرض الدرس',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Tajawal',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // زر إعادة 10 ثواني
                      IconButton(
                        onPressed: () => _seekBackward(10),
                        icon: Icon(
                          Icons.replay_10,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),

                      // زر تقدم 10 ثواني
                      IconButton(
                        onPressed: () => _seekForward(10),
                        icon: Icon(
                          Icons.forward_10,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  Widget _buildErrorScreen() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              _errorMessage,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                _exitFullScreenMode();
                Navigator.of(context).pop();
              },
              child: Text(
                'العودة',
                style: TextStyle(fontFamily: 'Tajawal'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              'جاري تحميل الفيديو...',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _buildErrorScreen(),
        ),
      );
    }

    if (_controller == null && !_hasError) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _buildLoadingScreen(),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showControls = !_showControls;
            });
            if (_showControls) {
              _startControlsTimer();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                // الفيديو يملأ الشاشة بالكامل
                Positioned.fill(
                  child: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: false,
                    progressIndicatorColor: Colors.red,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.red,
                      backgroundColor: Colors.grey[800]!,
                    ),
                    onReady: () {
                      if (mounted && !_isDisposing) {
                        setState(() {
                          _isPlayerReady = true;
                        });
                      }
                    },
                    onEnded: (metaData) {
                      if (mounted && !_isDisposing) {
                        setState(() {
                          _isPlaying = false;
                          _showControls = true;
                        });
                      }
                    },
                  ),
                ),

                // عناصر التحكم (تظهر وتختفي مثل اليوتيوب)
                if (_isPlayerReady) _buildYouTubeLikeControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposing = true;
    _controlsTimer?.cancel();
    _stopVideoBeforeExit();
    _exitFullScreenMode();

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
    });

    super.dispose();
  }
}

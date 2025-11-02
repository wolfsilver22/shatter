import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailScreen extends StatefulWidget {
  final Map<String, dynamic> lesson;
  final String courseId;
  final String subjectName;

  const LessonDetailScreen({
    Key? key,
    required this.lesson,
    required this.courseId,
    required this.subjectName,
  }) : super(key: key);

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isMuted = false;
  double _volume = 100;
  bool _isPlaying = false;
  double _playbackRate = 1.0;
  bool _isFullScreen = false;
  bool _isLoading = true;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeYouTubePlayer();
    // الانتقال مباشرة إلى وضع ملء الشاشة والوضع الأفقي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _enterFullScreen();
    });
  }

  void _enterFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      _isFullScreen = true;
    });
  }

  void _exitFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setState(() {
      _isFullScreen = false;
    });
  }

  void _initializeYouTubePlayer() {
    try {
      String? videoUrl = widget.lesson['video_url'] ?? '';

      if (videoUrl!.isNotEmpty) {
        String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: true, // التشغيل التلقائي
              mute: false,
              enableCaption: false, // تعطيل الترجمة
              hideControls: false,
              controlsVisibleAtStart: true,
              useHybridComposition: true,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: true,
            ),
          );

          _controller!.addListener(_videoListener);

          // تحديث الموقع الحالي والمدة الكلية
          _controller!.addListener(() {
            if (mounted) {
              setState(() {
                _currentPosition = _controller!.value.position;
                _totalDuration = _controller!.metadata.duration;
              });
            }
          });

          // إخفاء مؤشر التحميل بعد تهيئة المشغل
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _isPlayerReady = true;
              });
            }
          });

        } else {
          _setErrorState('رابط الفيديو غير صالح');
        }
      } else {
        _setErrorState('لا يتوفر فيديو لهذا الدرس');
      }
    } catch (e) {
      _setErrorState('خطأ في تهيئة مشغل الفيديو');
    }
  }

  void _videoListener() {
    if (_controller != null && mounted) {
      setState(() {
        _isPlaying = _controller!.value.isPlaying;
        _currentPosition = _controller!.value.position;
        _totalDuration = _controller!.metadata.duration;
      });
    }
  }

  void _setErrorState(String message) {
    if (mounted) {
      setState(() {
        _hasError = true;
        _errorMessage = message;
        _isPlayerReady = false;
        _isLoading = false;
      });
    }
  }

  void _togglePlayPause() {
    if (_isPlayerReady && _controller != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    }
  }

  void _toggleMute() {
    if (_controller != null) {
      if (_isMuted) {
        _controller!.unMute();
        setState(() {
          _isMuted = false;
          _volume = 100;
        });
      } else {
        _controller!.mute();
        setState(() {
          _isMuted = true;
          _volume = 0;
        });
      }
    }
  }

  void _seekForward(int seconds) {
    if (_controller != null) {
      final newPosition = _currentPosition + Duration(seconds: seconds);
      _controller!.seekTo(newPosition);
    }
  }

  void _seekBackward(int seconds) {
    if (_controller != null) {
      final newPosition = _currentPosition - Duration(seconds: seconds);
      _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
    }
  }

  void _changePlaybackRate(double rate) {
    if (_controller != null) {
      _controller!.setPlaybackRate(rate);
      setState(() {
        _playbackRate = rate;
      });
    }
  }

  void _changeVolume(double volume) {
    setState(() {
      _volume = volume;
      _isMuted = volume == 0;
    });
  }

  void _onVolumeChangeEnd(double volume) {
    if (_controller != null) {
      _controller!.setVolume(volume.round());
    }
  }

  void _onSeekBarChange(double value) {
    if (_controller != null) {
      final newPosition = value * _totalDuration.inMilliseconds;
      _controller!.seekTo(Duration(milliseconds: newPosition.round()));
    }
  }

  Widget _buildCustomProgressBar() {
    final double progress = _totalDuration.inMilliseconds > 0
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
        : 0.0;

    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          // شريط التقدم
          Slider(
            value: progress,
            onChanged: _onSeekBarChange,
            onChangeStart: (_) {
              if (_controller != null && _controller!.value.isPlaying) {
                _controller!.pause();
              }
            },
            onChangeEnd: (_) {
              if (_controller != null && !_controller!.value.isPlaying) {
                _controller!.play();
              }
            },
            activeColor: const Color(0xFF1E88E5),
            inactiveColor: Colors.white54,
          ),

          // الوقت الحالي والوقت المتبقي
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_currentPosition),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  _formatDuration(_totalDuration),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenControls() {
    return Stack(
      children: [
        // عناصر التحكم العلوية
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                  onPressed: () {
                    _exitFullScreen();
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Text(
                    widget.lesson['lesson_title'] ?? 'عرض الدرس',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.fullscreen_exit, color: Colors.white, size: 24.sp),
                  onPressed: _exitFullScreen,
                ),
              ],
            ),
          ),
        ),

        // عناصر التحكم المركزية
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر الرجوع 10 ثواني
              GestureDetector(
                onTap: () => _seekBackward(10),
                child: Container(
                  width: 80.w,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.replay_10, color: Colors.white, size: 40.sp),
                      Text('10', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
              ),

              // زر التشغيل/الإيقاف
              GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 80.w,
                  color: Colors.transparent,
                  child: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 60.sp,
                  ),
                ),
              ),

              // زر التقدم 10 ثواني
              GestureDetector(
                onTap: () => _seekForward(10),
                child: Container(
                  width: 80.w,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.forward_10, color: Colors.white, size: 40.sp),
                      Text('10', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // عناصر التحكم السفلية
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                // شريط التقدم المخصص
                _buildCustomProgressBar(),

                // عناصر التحكم السفلية
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      // زر الصوت
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isMuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            onPressed: _toggleMute,
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: 80.w,
                            child: Slider(
                              value: _volume,
                              min: 0,
                              max: 100,
                              onChanged: _changeVolume,
                              onChangeEnd: _onVolumeChangeEnd,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white54,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // زر سرعة التشغيل
                      PopupMenuButton<double>(
                        icon: Icon(Icons.speed, color: Colors.white, size: 20.sp),
                        onSelected: _changePlaybackRate,
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 0.25, child: Text('0.25x')),
                          PopupMenuItem(value: 0.5, child: Text('0.5x')),
                          PopupMenuItem(value: 0.75, child: Text('0.75x')),
                          PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
                          PopupMenuItem(value: 1.25, child: Text('1.25x')),
                          PopupMenuItem(value: 1.5, child: Text('1.5x')),
                          PopupMenuItem(value: 1.75, child: Text('1.75x')),
                          PopupMenuItem(value: 2.0, child: Text('2.0x')),
                        ],
                      ),

                      // زر الإعدادات (مع تعطيل الترجمة)
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.white, size: 20.sp),
                        onSelected: (value) {
                          if (value == 'quality') {
                            // يمكن إضافة اختيار الجودة هنا
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'quality', child: Text('جودة الفيديو')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // مؤشر التحميل
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: const Color(0xFF1E88E5),
                      strokeWidth: 3.w,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'جاري تحميل الفيديو...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
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
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _initializeYouTubePlayer,
                child: const Text('إعادة المحاولة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: const Color(0xFF1E88E5)),
              SizedBox(height: 16.h),
              Text(
                'جاري تهيئة مشغل الفيديو...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        _exitFullScreen();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // مشغل اليوتيوب
            Positioned.fill(
              child: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: false, // إخفاء شريط التقدم الافتراضي
                progressIndicatorColor: const Color(0xFF1E88E5),
                progressColors: const ProgressBarColors(
                  playedColor: Color(0xFF1E88E5),
                  handleColor: Color(0xFF1E88E5),
                  backgroundColor: Colors.white54,
                ),
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
                onEnded: (metaData) {
                  // العودة إلى البداية عند انتهاء الفيديو
                  _controller!.seekTo(Duration.zero);
                  _controller!.pause();
                },
              ),
            ),

            // عناصر التحكم المخصصة
            if (_isPlayerReady) _buildFullScreenControls(),

            // مؤشر التحميل
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: const Color(0xFF1E88E5),
                          strokeWidth: 3.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'جاري تحميل الفيديو...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
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

  @override
  void dispose() {
    _controller?.dispose();
    // استعادة الوضع العمودي عند الخروج
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}

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
  double _volume = 100;
  bool _isPlaying = false;
  double _playbackRate = 1.0;
  bool _isDisposing = false;
  bool _isFullScreen = true;

  @override
  void initState() {
    super.initState();

    // ✅ التعديل: الانتقال المباشر إلى وضع ملء الشاشة
    _enterFullScreenMode();
    _initializeYouTubePlayer();
  }

  void _enterFullScreenMode() {
    // ✅ إخفاء شريط الحالة وزر التنقل
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // ✅ إجبار الوضع الأفقي
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _exitFullScreenMode() {
    // ✅ إعادة شريط الحالة وزر التنقل
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // ✅ العودة للوضع الرأسي
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
              autoPlay: true, // ✅ التشغيل التلقائي
              mute: false,
              enableCaption: true,
              captionLanguage: 'ar',
              hideControls: true, // ✅ إخفاء عناصر التحكم الافتراضية
              controlsVisibleAtStart: false,
              useHybridComposition: true,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: true, // ✅ إجبار الجودة العالية
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
    }
  }

  void _toggleMute() {
    if (_controller != null && !_isDisposing) {
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
    if (_controller != null && !_isDisposing) {
      final newPosition = _controller!.value.position + Duration(seconds: seconds);
      _controller!.seekTo(newPosition);
    }
  }

  void _seekBackward(int seconds) {
    if (_controller != null && !_isDisposing) {
      final newPosition = _controller!.value.position - Duration(seconds: seconds);
      _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
    }
  }

  void _changePlaybackRate(double rate) {
    if (_controller != null && !_isDisposing) {
      _controller!.setPlaybackRate(rate);
      setState(() {
        _playbackRate = rate;
      });
    }
  }

  void _changeVolume(double volume) {
    if (!_isDisposing) {
      setState(() {
        _volume = volume;
        _isMuted = volume == 0;
      });
    }
  }

  void _onVolumeChangeEnd(double volume) {
    if (_controller != null && !_isDisposing) {
      _controller!.setVolume(volume.round());
    }
  }

  Widget _buildCustomPlaybackSpeedButton() {
    return PopupMenuButton<double>(
      icon: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Color(0xFF1E88E5),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.speed, color: Colors.white, size: 18.sp),
      ),
      tooltip: 'سرعة التشغيل',
      onSelected: (speed) {
        _changePlaybackRate(speed);
      },
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
    );
  }

  Widget _buildFullScreenControls() {
    return Positioned(
      bottom: 20.h,
      left: 20.w,
      right: 20.w,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Column(
            children: [
              // شريط التقدم
              Row(
                children: [
                  Text(
                    _formatDuration(_controller?.value.position ?? Duration.zero),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ProgressBar(
                      isExpanded: true,
                      controller: _controller!,
                      colors: ProgressBarColors(
                        playedColor: Color(0xFF1E88E5),
                        handleColor: Color(0xFF1E88E5),
                        backgroundColor: Colors.grey[600]!,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    _formatDuration(_controller?.value.metaData.duration ?? Duration.zero),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // أزرار التحكم الرئيسية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFullScreenControlButton(
                    icon: Icons.replay_10,
                    onPressed: () => _seekBackward(10),
                    color: Color(0xFF1E88E5),
                  ),
                  _buildFullScreenControlButton(
                    icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: _togglePlayPause,
                    color: Color(0xFF1E88E5),
                    isMain: true,
                  ),
                  _buildFullScreenControlButton(
                    icon: _isMuted ? Icons.volume_off : Icons.volume_up,
                    onPressed: _toggleMute,
                    color: Color(0xFFFFA726),
                  ),
                  _buildFullScreenControlButton(
                    icon: Icons.forward_10,
                    onPressed: () => _seekForward(10),
                    color: Color(0xFF1E88E5),
                  ),
                  _buildFullScreenControlButton(
                    icon: Icons.speed,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.black.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
                        ),
                        builder: (context) => _buildSpeedSelector(),
                      );
                    },
                    color: Color(0xFF4CAF50),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullScreenControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    bool isMain = false,
  }) {
    return Container(
      width: isMain ? 50.w : 40.w,
      height: isMain ? 50.h : 40.h,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8.w,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: isMain ? 22.sp : 18.sp,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildSpeedSelector() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سرعة التشغيل',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
              return ChoiceChip(
                label: Text(
                  '${speed}x',
                  style: TextStyle(
                    color: _playbackRate == speed ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
                selected: _playbackRate == speed,
                selectedColor: Color(0xFF1E88E5),
                backgroundColor: Colors.grey[300],
                onSelected: (selected) {
                  if (selected) {
                    _changePlaybackRate(speed);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
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
                backgroundColor: Color(0xFF1E88E5),
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
            CircularProgressIndicator(color: Color(0xFF1E88E5)),
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

    if (_controller == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              'خطأ في تحميل الفيديو',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // ✅ الفيديو يملأ الشاشة بالكامل
              Positioned.fill(
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: false,
                  progressIndicatorColor: Color(0xFF1E88E5),
                  progressColors: ProgressBarColors(
                    playedColor: Color(0xFF1E88E5),
                    handleColor: Color(0xFF1E88E5),
                    backgroundColor: Colors.grey[600]!,
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
                      });
                    }
                  },
                ),
              ),

              // ✅ عناصر التحكم العائمة
              if (_isPlayerReady) _buildFullScreenControls(),

              // ✅ زر العودة في الزاوية
              Positioned(
                top: 30.h,
                left: 20.w,
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
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
                ),
              ),

              // ✅ عنوان الفيديو
              Positioned(
                top: 30.h,
                left: 74.w,
                right: 20.w,
                child: Text(
                  widget.lesson['title'] ?? 'عرض الدرس',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposing = true;
    _stopVideoBeforeExit();
    _exitFullScreenMode();

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
    });

    super.dispose();
  }
}

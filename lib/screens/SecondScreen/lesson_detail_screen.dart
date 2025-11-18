import 'dart:async';

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
  bool _isPlaying = false;
  double _playbackRate = 1.0;
  bool _isDisposing = false;
  bool _showControls = true;
  Timer? _controlsTimer;

  // ✅ متغيرات محسنة للأداء
  bool _previousPlayingState = false;
  bool _previousControlsState = true;
  bool _isFirstPlay = true;
  bool _showInitialLoader = true;
  bool _showEndDialog = false; // ✅ جديد: للتحكم في عرض الدايلوج

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  void _initializeScreen() {
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
              enableCaption: false,
              captionLanguage: 'ar',
              hideControls: true,
              controlsVisibleAtStart: false,
              useHybridComposition: true,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: false,
              startAt: 0,
            ),
          );

          _controller!.addListener(_optimizedVideoListener);
          _preloadVideo();

          _setupQualityMonitoring();

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

  void _setupQualityMonitoring() {
    Future.delayed(Duration(seconds: 3), () {
      if (_controller != null && mounted && !_isDisposing) {
        try {
          _controller!.setPlaybackRate(1.0);
        } catch (e) {
          print('Error in quality setup: $e');
        }
      }
    });
  }

  void _preloadVideo() {
    if (_controller != null && !_isDisposing && mounted) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  void _optimizedVideoListener() {
    if (!mounted || _isDisposing || _controller == null) return;

    final currentPlayingState = _controller!.value.isPlaying;

    if (currentPlayingState != _previousPlayingState) {
      _previousPlayingState = currentPlayingState;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isDisposing) {
          setState(() {
            _isPlaying = currentPlayingState;

            if (_isPlaying && _showInitialLoader) {
              _showInitialLoader = false;
            }

            if (_isPlaying && _isFirstPlay) {
              _isFirstPlay = false;
              Future.delayed(Duration(seconds: 2), () {
                if (mounted && !_isDisposing) {
                  setState(() {
                    _showControls = false;
                  });
                }
              });
            }
          });
        }
      });
    }
  }

  // ✅ جديد: دالة التعامل مع انتهاء الفيديو
  void _handleVideoEnd() {
    if (mounted && !_isDisposing && !_showEndDialog) {
      setState(() {
        _showEndDialog = true;
        _isPlaying = false;
        _showControls = true;
      });

      // ✅ عرض الدايلوج بعد تأخير بسيط
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted && !_isDisposing) {
          _showEndOfVideoDialog();
        }
      });
    }
  }

  // ✅ جديد: دالة عرض الدايلوج عند انتهاء الفيديو
  void _showEndOfVideoDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _EndOfVideoDialog(
          lessonTitle: widget.lesson['title'] ?? 'الدرس',
          onReplay: _replayVideo,
          onExit: _exitToLessons,
        );
      },
    ).then((value) {
      if (mounted && !_isDisposing) {
        setState(() {
          _showEndDialog = false;
        });
      }
    });
  }

  // ✅ جديد: دالة إعادة تشغيل الفيديو
  void _replayVideo() {
    if (_controller != null && !_isDisposing) {
      _controller!.seekTo(Duration.zero);
      _controller!.play();
      setState(() {
        _showEndDialog = false;
        _isPlaying = true;
        _showControls = false;
      });
      _startControlsTimer();
    }
  }

  // ✅ جديد: دالة الخروج إلى صفحة الدروس
  void _exitToLessons() {
    _exitFullScreenMode();
    _stopVideoBeforeExit();
    Navigator.of(context).pop();
  }

  void _setErrorState(String message) {
    if (mounted && !_isDisposing) {
      setState(() {
        _hasError = true;
        _errorMessage = message;
        _isPlayerReady = false;
        _showInitialLoader = false;
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
    await Future.delayed(Duration(milliseconds: 100));
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isMuted = !_isMuted;
          });
        }
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
      Future.delayed(Duration(milliseconds: 50), () {
        if (mounted) {
          setState(() {
            _playbackRate = rate;
          });
        }
      });
      _showControlsTemporarily();
    }
  }

  void _showControlsTemporarily() {
    if (_showControls != true) {
      setState(() {
        _showControls = true;
        _previousControlsState = true;
      });
    }
    _startControlsTimer();
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(Duration(seconds: 3), () {
      if (mounted && !_isDisposing && _isPlaying && _showControls) {
        setState(() {
          _showControls = false;
          _previousControlsState = false;
        });
      }
    });
  }

  Widget _buildInitialLoader() {
    return AnimatedOpacity(
      opacity: _showInitialLoader ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10.w,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: 32.w,
                height: 32.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3.w,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                  backgroundColor: Colors.grey[100],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYouTubeLikeControls() {
    return _VideoControlsOverlay(
      showControls: _showControls,
      isPlaying: _isPlaying,
      isMuted: _isMuted,
      playbackRate: _playbackRate,
      controller: _controller,
      lessonTitle: widget.lesson['title'] ?? 'عرض الدرس',
      courseTitle: widget.subjectName,
      onTogglePlayPause: _togglePlayPause,
      onToggleMute: _toggleMute,
      onSeekForward: _seekForward,
      onSeekBackward: _seekBackward,
      onChangePlaybackRate: _changePlaybackRate,
      onExit: _onWillPop,
    );
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
            if (_showControls != !_showControls) {
              setState(() {
                _showControls = !_showControls;
              });
            }
            if (_showControls) {
              _startControlsTimer();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                // الفيديو الرئيسي
                if (_isPlayerReady)
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
                        _handleVideoEnd(); // ✅ التعديل: استدعاء الدالة الجديدة
                      },
                    ),
                  ),

                // عناصر التحكم
                if (_isPlayerReady) _buildYouTubeLikeControls(),

                // دائرة التحميل
                if (_showInitialLoader) _buildInitialLoader(),
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
      _controller?.removeListener(_optimizedVideoListener);
      _controller?.dispose();
    });

    super.dispose();
  }
}

// ✅ جديد: دايلوج نهاية الفيديو
class _EndOfVideoDialog extends StatelessWidget {
  final String lessonTitle;
  final VoidCallback onReplay;
  final VoidCallback onExit;

  const _EndOfVideoDialog({
    required this.lessonTitle,
    required this.onReplay,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20.w,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة النجاح
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 50.w,
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // عنوان التهنئة
            Text(
              'أحسنت!',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Tajawal',
              ),
            ),
            
            SizedBox(height: 8.h),
            
            // نص التهنئة
            Text(
              'لقد أنهيت مشاهدة الدرس',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
                fontFamily: 'Tajawal',
              ),
            ),
            
            SizedBox(height: 4.h),
            
            // اسم الدرس
            Text(
              lessonTitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFF1E88E5),
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: 30.h),
            
            // أزرار التحكم
            Row(
              children: [
                // زر إعادة التشغيل
                Expanded(
                  child: Container(
                    height: 50.h,
                    child: OutlinedButton(
                      onPressed: onReplay,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF1E88E5),
                        side: BorderSide(color: Color(0xFF1E88E5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.replay, size: 20.w),
                          SizedBox(width: 8.w),
                          Text(
                            'إعادة المشاهدة',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                SizedBox(width: 12.w),
                
                // زر العودة للدروس
                Expanded(
                  child: Container(
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: onExit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E88E5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list_alt, size: 20.w),
                          SizedBox(width: 8.w),
                          Text(
                            'العودة للدروس',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 10.h),
            
            // زر إغلاق بسيط
            TextButton(
              onPressed: onExit,
              child: Text(
                'إغلاق',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ واجهة التحكم المحسنة (بدون تغيير)
class _VideoControlsOverlay extends StatelessWidget {
  final bool showControls;
  final bool isPlaying;
  final bool isMuted;
  final double playbackRate;
  final YoutubePlayerController? controller;
  final String lessonTitle;
  final String courseTitle;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onToggleMute;
  final Function(int) onSeekForward;
  final Function(int) onSeekBackward;
  final Function(double) onChangePlaybackRate;
  final Future<bool> Function() onExit;

  const _VideoControlsOverlay({
    required this.showControls,
    required this.isPlaying,
    required this.isMuted,
    required this.playbackRate,
    required this.controller,
    required this.lessonTitle,
    required this.courseTitle,
    required this.onTogglePlayPause,
    required this.onToggleMute,
    required this.onSeekForward,
    required this.onSeekBackward,
    required this.onChangePlaybackRate,
    required this.onExit,
  });

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

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showControls ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            // التحكم السفلي
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
                        controller: controller!,
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
                              onPressed: onTogglePlayPause,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),

                            // الوقت الحالي
                            Text(
                              _formatDuration(controller?.value.position ?? Duration.zero),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(width: 16.w),

                            // زر الكتم
                            IconButton(
                              onPressed: onToggleMute,
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),

                            // سرعة التشغيل
                            PopupMenuButton<double>(
                              icon: Icon(
                                Icons.speed,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onSelected: onChangePlaybackRate,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0.5,
                                  child: Text('0.5x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 0.75,
                                  child: Text('0.75x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 1.0,
                                  child: Text('عادي (1.0x)', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 1.25,
                                  child: Text('1.25x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 1.5,
                                  child: Text('1.5x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 1.75,
                                  child: Text('1.75x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                                PopupMenuItem(
                                  value: 2.0,
                                  child: Text('2.0x', style: TextStyle(fontFamily: 'Tajawal')),
                                ),
                              ],
                            ),

                            Spacer(),

                            // الوقت المتبقي
                            Text(
                              '-${_formatDuration((controller?.value.metaData.duration ?? Duration.zero) - (controller?.value.position ?? Duration.zero))}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal',
                              ),
                            ),

                            SizedBox(width: 16.w),

                            // زر الخروج من وضع الملء
                            IconButton(
                              onPressed: () async {
                                if (await onExit()) {
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

            // التحكم العلوي
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: showControls ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: 80.h,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        // زر العودة
                        IconButton(
                          onPressed: () async {
                            if (await onExit()) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),

                        // معلومات الدرس
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseTitle,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12.sp,
                                  fontFamily: 'Tajawal',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                lessonTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Tajawal',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // أزرار التقديم السريع
                        IconButton(
                          onPressed: () => onSeekBackward(10),
                          icon: Icon(
                            Icons.replay_10,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),

                        IconButton(
                          onPressed: () => onSeekForward(10),
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
            ),
          ],
        ),
      ),
    );
  }
}

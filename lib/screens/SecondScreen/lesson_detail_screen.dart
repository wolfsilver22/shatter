// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// //
// // class LessonDetailScreen extends StatefulWidget {
// //   final Map<String, dynamic> lesson;
// //
// //   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
// //
// //   @override
// //   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// // }
// //
// // class _LessonDetailScreenState extends State<LessonDetailScreen> {
// //   YoutubePlayerController? _controller;
// //   bool _isPlayerReady = false;
// //   bool _hasError = false;
// //   String _errorMessage = '';
// //   bool _isMuted = false;
// //   double _volume = 100;
// //   bool _isPlaying = false;
// //   double _playbackRate = 1.0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeYouTubePlayer();
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //     ]);
// //   }
// //
// //   void _initializeYouTubePlayer() {
// //     try {
// //       String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';
// //
// //       if (videoUrl != null && videoUrl.isNotEmpty) {
// //         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
// //
// //         if (videoId != null) {
// //           _controller = YoutubePlayerController(
// //             initialVideoId: videoId,
// //             flags: YoutubePlayerFlags(
// //               autoPlay: false,
// //               mute: false,
// //               enableCaption: true,
// //               captionLanguage: 'ar',
// //               hideControls: false,
// //               controlsVisibleAtStart: true,
// //               useHybridComposition: true,
// //               disableDragSeek: false,
// //               loop: false,
// //               isLive: false,
// //               forceHD: true,
// //             ),
// //           );
// //
// //           _controller!.addListener(_videoListener);
// //
// //           if (mounted) {
// //             setState(() {
// //               _isPlayerReady = true;
// //             });
// //           }
// //
// //         } else {
// //           _setErrorState('رابط الفيديو غير صالح');
// //         }
// //       } else {
// //         _setErrorState('لا يتوفر فيديو لهذا الدرس');
// //       }
// //     } catch (e) {
// //       _setErrorState('خطأ في تهيئة مشغل الفيديو: $e');
// //     }
// //   }
// //
// //   void _videoListener() {
// //     if (!mounted) return;
// //
// //     if (_controller != null) {
// //       setState(() {
// //         _isPlaying = _controller!.value.isPlaying;
// //       });
// //     }
// //   }
// //
// //   void _setErrorState(String message) {
// //     if (mounted) {
// //       setState(() {
// //         _hasError = true;
// //         _errorMessage = message;
// //         _isPlayerReady = false;
// //       });
// //     }
// //   }
// //
// //   void _togglePlayPause() {
// //     if (_isPlayerReady && _controller != null) {
// //       if (_controller!.value.isPlaying) {
// //         _controller!.pause();
// //       } else {
// //         _controller!.play();
// //       }
// //     }
// //   }
// //
// //   void _toggleMute() {
// //     if (_controller != null) {
// //       if (_isMuted) {
// //         _controller!.unMute();
// //         setState(() {
// //           _isMuted = false;
// //           _volume = 100;
// //         });
// //       } else {
// //         _controller!.mute();
// //         setState(() {
// //           _isMuted = true;
// //           _volume = 0;
// //         });
// //       }
// //     }
// //   }
// //
// //   void _seekForward(int seconds) {
// //     if (_controller != null) {
// //       final newPosition = _controller!.value.position + Duration(seconds: seconds);
// //       _controller!.seekTo(newPosition);
// //     }
// //   }
// //
// //   void _seekBackward(int seconds) {
// //     if (_controller != null) {
// //       final newPosition = _controller!.value.position - Duration(seconds: seconds);
// //       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
// //     }
// //   }
// //
// //   void _changePlaybackRate(double rate) {
// //     if (_controller != null) {
// //       _controller!.setPlaybackRate(rate);
// //       setState(() {
// //         _playbackRate = rate;
// //       });
// //     }
// //   }
// //
// //   void _changeVolume(double volume) {
// //     setState(() {
// //       _volume = volume;
// //       _isMuted = volume == 0;
// //     });
// //   }
// //
// //   void _onVolumeChangeEnd(double volume) {
// //     if (_controller != null) {
// //       _controller!.setVolume(volume.round());
// //     }
// //   }
// //
// //   Widget _buildCustomPlaybackSpeedButton() {
// //     return PopupMenuButton<double>(
// //       icon: Icon(Icons.speed, color: Colors.white),
// //       tooltip: 'سرعة التشغيل',
// //       onSelected: (speed) {
// //         _changePlaybackRate(speed);
// //       },
// //       itemBuilder: (context) => [
// //         PopupMenuItem(value: 0.25, child: Text('0.25x')),
// //         PopupMenuItem(value: 0.5, child: Text('0.5x')),
// //         PopupMenuItem(value: 0.75, child: Text('0.75x')),
// //         PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
// //         PopupMenuItem(value: 1.25, child: Text('1.25x')),
// //         PopupMenuItem(value: 1.5, child: Text('1.5x')),
// //         PopupMenuItem(value: 1.75, child: Text('1.75x')),
// //         PopupMenuItem(value: 2.0, child: Text('2.0x')),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildVideoControls() {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 16.w),
// //       padding: EdgeInsets.all(16.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildControlButton(
// //                 icon: Icons.replay_10,
// //                 text: 'رجوع 10ث',
// //                 onPressed: () => _seekBackward(10),
// //                 color: Color(0xFF1E88E5),
// //               ),
// //               _buildControlButton(
// //                 icon: _isPlaying ? Icons.pause : Icons.play_arrow,
// //                 text: _isPlaying ? 'إيقاف' : 'تشغيل',
// //                 onPressed: _togglePlayPause,
// //                 color: Color(0xFF1E88E5),
// //               ),
// //               _buildControlButton(
// //                 icon: _isMuted ? Icons.volume_off : Icons.volume_up,
// //                 text: _isMuted ? 'كتم' : 'صوت',
// //                 onPressed: _toggleMute,
// //                 color: Color(0xFFFFA726),
// //               ),
// //               _buildControlButton(
// //                 icon: Icons.forward_10,
// //                 text: 'تقدم 10ث',
// //                 onPressed: () => _seekForward(10),
// //                 color: Color(0xFF1E88E5),
// //               ),
// //             ],
// //           ),
// //
// //           SizedBox(height: 16.h),
// //
// //           Row(
// //             children: [
// //               Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
// //               SizedBox(width: 12.w),
// //               Expanded(
// //                 child: Slider(
// //                   value: _volume,
// //                   min: 0,
// //                   max: 100,
// //                   divisions: 10,
// //                   onChanged: _changeVolume,
// //                   onChangeEnd: _onVolumeChangeEnd,
// //                   activeColor: Color(0xFF1E88E5),
// //                   inactiveColor: Colors.grey[300],
// //                 ),
// //               ),
// //               SizedBox(width: 12.w),
// //               Text(
// //                 '${_volume.round()}%',
// //                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
// //               ),
// //             ],
// //           ),
// //
// //           SizedBox(height: 12.h),
// //
// //           Row(
// //             children: [
// //               Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
// //               SizedBox(width: 12.w),
// //               Text(
// //                 'السرعة:',
// //                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(width: 8.w),
// //               Expanded(
// //                 child: DropdownButton<double>(
// //                   value: _playbackRate,
// //                   isExpanded: true,
// //                   items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
// //                     return DropdownMenuItem(
// //                       value: speed,
// //                       child: Text(
// //                         '${speed}x',
// //                         style: TextStyle(fontSize: 12.sp),
// //                       ),
// //                     );
// //                   }).toList(),
// //                   onChanged: (speed) {
// //                     if (speed != null) _changePlaybackRate(speed);
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButton({
// //     required IconData icon,
// //     required String text,
// //     required VoidCallback onPressed,
// //     required Color color,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 52.w,
// //           height: 52.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             shape: BoxShape.circle,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: color.withOpacity(0.4),
// //                 blurRadius: 6.w,
// //                 offset: Offset(0, 3.h),
// //               ),
// //             ],
// //           ),
// //           child: IconButton(
// //             icon: Icon(icon, color: Colors.white, size: 22.sp),
// //             onPressed: onPressed,
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           text,
// //           style: TextStyle(
// //             fontSize: 10.sp,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.black87,
// //             fontFamily: 'Tajawal',
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildLessonInfo() {
// //     return Container(
// //       margin: EdgeInsets.all(16.w),
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             'معلومات الدرس',
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF1E88E5),
// //               fontFamily: 'Tajawal',
// //             ),
// //           ),
// //           SizedBox(height: 16.h),
// //           _buildInfoRow(
// //             icon: Icons.school,
// //             label: 'المستوى',
// //             value: widget.lesson['level'] ?? 'مبتدئ',
// //             iconColor: Color(0xFF1E88E5),
// //           ),
// //           SizedBox(height: 12.h),
// //           _buildInfoRow(
// //             icon: Icons.format_list_numbered,
// //             label: 'رقم الدرس',
// //             value: '${widget.lesson['order_number'] ?? '1'}',
// //             iconColor: Color(0xFFFFA726),
// //           ),
// //           if (widget.lesson['description'] != null) ...[
// //             SizedBox(height: 16.h),
// //             Text(
// //               'الوصف:',
// //               style: TextStyle(
// //                 fontSize: 16.sp,
// //                 fontWeight: FontWeight.bold,
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //             SizedBox(height: 8.h),
// //             Text(
// //               widget.lesson['description']!,
// //               style: TextStyle(
// //                 fontSize: 14.sp,
// //                 color: Colors.grey[700],
// //                 fontFamily: 'Tajawal',
// //                 height: 1.5,
// //               ),
// //               textAlign: TextAlign.right,
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildInfoRow({
// //     required IconData icon,
// //     required String label,
// //     required String value,
// //     required Color iconColor,
// //   }) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 20.sp, color: iconColor),
// //         SizedBox(width: 12.w),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 fontSize: 12.sp,
// //                 color: Colors.grey[600],
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //             Text(
// //               value,
// //               style: TextStyle(
// //                 fontSize: 14.sp,
// //                 fontWeight: FontWeight.bold,
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// //
// //   PreferredSizeWidget _buildAppBar() {
// //     return AppBar(
// //       backgroundColor: Color(0xFF1E88E5),
// //       foregroundColor: Colors.white,
// //       leading: IconButton(
// //         icon: Icon(Icons.arrow_back),
// //         onPressed: () => Navigator.pop(context),
// //       ),
// //       title: Text(
// //         widget.lesson['title'] ?? 'عرض الدرس',
// //         style: TextStyle(
// //           fontSize: 18.sp,
// //           fontWeight: FontWeight.bold,
// //           fontFamily: 'Tajawal',
// //         ),
// //         maxLines: 1,
// //         overflow: TextOverflow.ellipsis,
// //       ),
// //       centerTitle: true,
// //       elevation: 0,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_hasError) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //               SizedBox(height: 16.h),
// //               Text(
// //                 _errorMessage,
// //                 style: TextStyle(
// //                   fontSize: 16.sp,
// //                   color: Colors.red[700],
// //                   fontFamily: 'Tajawal',
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     if (_controller == null && !_hasError) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(color: Color(0xFF1E88E5)),
// //               SizedBox(height: 16.h),
// //               Text(
// //                 'جاري تهيئة مشغل الفيديو...',
// //                 style: TextStyle(
// //                   fontSize: 16.sp,
// //                   color: Color(0xFF1E88E5),
// //                   fontFamily: 'Tajawal',
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     if (_controller == null) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Text(
// //             'خطأ في تحميل الفيديو',
// //             style: TextStyle(
// //               fontSize: 16.sp,
// //               color: Colors.red,
// //               fontFamily: 'Tajawal',
// //             ),
// //           ),
// //         ),
// //       );
// //     }
// //
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (_controller != null && _controller!.value.isFullScreen) {
// //           _controller!.toggleFullScreenMode();
// //           return false;
// //         }
// //         return true;
// //       },
// //       child: YoutubePlayerBuilder(
// //         onEnterFullScreen: () {
// //           SystemChrome.setPreferredOrientations([
// //             DeviceOrientation.landscapeRight,
// //             DeviceOrientation.landscapeLeft,
// //           ]);
// //         },
// //         onExitFullScreen: () {
// //           SystemChrome.setPreferredOrientations([
// //             DeviceOrientation.portraitUp,
// //           ]);
// //         },
// //         player: YoutubePlayer(
// //           controller: _controller!,
// //           showVideoProgressIndicator: true,
// //           progressIndicatorColor: Color(0xFF1E88E5),
// //           progressColors: ProgressBarColors(
// //             playedColor: Color(0xFF1E88E5),
// //             handleColor: Color(0xFF1E88E5),
// //             backgroundColor: Colors.grey[300]!,
// //           ),
// //           onReady: () {
// //             if (mounted) {
// //               setState(() {
// //                 _isPlayerReady = true;
// //               });
// //             }
// //           },
// //           onEnded: (metaData) {
// //             if (mounted) {
// //               setState(() {
// //                 _isPlaying = false;
// //               });
// //             }
// //           },
// //           bottomActions: [
// //             CurrentPosition(),
// //             ProgressBar(isExpanded: true),
// //             RemainingDuration(),
// //             _buildCustomPlaybackSpeedButton(),
// //             FullScreenButton(),
// //           ],
// //         ),
// //         builder: (context, player) {
// //           return Scaffold(
// //             backgroundColor: Color(0xFFF5F9FF),
// //             appBar: _buildAppBar(),
// //             body: SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: [
// //                   Container(
// //                     height: MediaQuery.of(context).size.height * 0.4,
// //                     margin: EdgeInsets.all(8.w),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12.w),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black26,
// //                           blurRadius: 12.w,
// //                           offset: Offset(0, 6.h),
// //                         ),
// //                       ],
// //                     ),
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(12.w),
// //                       child: player,
// //                     ),
// //                   ),
// //
// //                   if (_isPlayerReady) ...[
// //                     SizedBox(height: 16.h),
// //                     _buildVideoControls(),
// //                   ],
// //
// //                   SizedBox(height: 16.h),
// //                   _buildLessonInfo(),
// //                   SizedBox(height: 20.h),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //       DeviceOrientation.landscapeRight,
// //       DeviceOrientation.landscapeLeft,
// //     ]);
// //
// //     _controller?.removeListener(_videoListener);
// //     _controller?.dispose();
// //     super.dispose();
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// //
// // class LessonDetailScreen extends StatefulWidget {
// //   final Map<String, dynamic> lesson;
// //
// //   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
// //
// //   @override
// //   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// // }
// //
// // class _LessonDetailScreenState extends State<LessonDetailScreen> {
// //   YoutubePlayerController? _controller;
// //   bool _isPlayerReady = false;
// //   bool _hasError = false;
// //   String _errorMessage = '';
// //   bool _isMuted = false;
// //   double _volume = 100;
// //   bool _isPlaying = false;
// //   double _playbackRate = 1.0;
// //   bool _isDisposing = false; // ✅ منع العمليات أثناء الإغلاق
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeYouTubePlayer();
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //     ]);
// //   }
// //
// //   void _initializeYouTubePlayer() {
// //     try {
// //       String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';
// //
// //       if (videoUrl != null && videoUrl.isNotEmpty) {
// //         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
// //
// //         if (videoId != null) {
// //           _controller = YoutubePlayerController(
// //             initialVideoId: videoId,
// //             flags: YoutubePlayerFlags(
// //               autoPlay: false,
// //               mute: false,
// //               enableCaption: true,
// //               captionLanguage: 'ar',
// //               hideControls: false,
// //               controlsVisibleAtStart: true,
// //               useHybridComposition: true,
// //               disableDragSeek: false,
// //               loop: false,
// //               isLive: false,
// //               forceHD: false, // ✅ تغيير إلى false لتحسين الأداء
// //             ),
// //           );
// //
// //           _controller!.addListener(_videoListener);
// //
// //           if (mounted) {
// //             setState(() {
// //               _isPlayerReady = true;
// //             });
// //           }
// //
// //         } else {
// //           _setErrorState('رابط الفيديو غير صالح');
// //         }
// //       } else {
// //         _setErrorState('لا يتوفر فيديو لهذا الدرس');
// //       }
// //     } catch (e) {
// //       _setErrorState('خطأ في تهيئة مشغل الفيديو: $e');
// //     }
// //   }
// //
// //   void _videoListener() {
// //     if (!mounted || _isDisposing) return;
// //
// //     if (_controller != null) {
// //       setState(() {
// //         _isPlaying = _controller!.value.isPlaying;
// //       });
// //     }
// //   }
// //
// //   void _setErrorState(String message) {
// //     if (mounted && !_isDisposing) {
// //       setState(() {
// //         _hasError = true;
// //         _errorMessage = message;
// //         _isPlayerReady = false;
// //       });
// //     }
// //   }
// //
// //   // ✅ إيقاف الفيديو قبل الخروج من الشاشة
// //   void _stopVideoBeforeExit() {
// //     if (_controller != null && _isPlayerReady) {
// //       // إيقاف الفيديو وإعادة تعيينه
// //       _controller!.pause();
// //       // إرجاع الفيديو إلى البداية
// //       _controller!.seekTo(Duration.zero);
// //     }
// //   }
// //
// //   // ✅ التعامل مع زر الرجوع يدويًا
// //   Future<bool> _onWillPop() async {
// //     // إذا كان في وضع fullscreen، نخرج منه أولاً
// //     if (_controller != null && _controller!.value.isFullScreen) {
// //       _controller!.toggleFullScreenMode();
// //       return false;
// //     }
// //
// //     // إيقاف الفيديو قبل الخروج
// //     _stopVideoBeforeExit();
// //
// //     // انتظار قليل لضمان إيقاف الفيديو
// //     await Future.delayed(Duration(milliseconds: 100));
// //
// //     return true;
// //   }
// //
// //   void _togglePlayPause() {
// //     if (_isPlayerReady && _controller != null && !_isDisposing) {
// //       if (_controller!.value.isPlaying) {
// //         _controller!.pause();
// //       } else {
// //         _controller!.play();
// //       }
// //     }
// //   }
// //
// //   void _toggleMute() {
// //     if (_controller != null && !_isDisposing) {
// //       if (_isMuted) {
// //         _controller!.unMute();
// //         setState(() {
// //           _isMuted = false;
// //           _volume = 100;
// //         });
// //       } else {
// //         _controller!.mute();
// //         setState(() {
// //           _isMuted = true;
// //           _volume = 0;
// //         });
// //       }
// //     }
// //   }
// //
// //   void _seekForward(int seconds) {
// //     if (_controller != null && !_isDisposing) {
// //       final newPosition = _controller!.value.position + Duration(seconds: seconds);
// //       _controller!.seekTo(newPosition);
// //     }
// //   }
// //
// //   void _seekBackward(int seconds) {
// //     if (_controller != null && !_isDisposing) {
// //       final newPosition = _controller!.value.position - Duration(seconds: seconds);
// //       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
// //     }
// //   }
// //
// //   void _changePlaybackRate(double rate) {
// //     if (_controller != null && !_isDisposing) {
// //       _controller!.setPlaybackRate(rate);
// //       setState(() {
// //         _playbackRate = rate;
// //       });
// //     }
// //   }
// //
// //   void _changeVolume(double volume) {
// //     if (!_isDisposing) {
// //       setState(() {
// //         _volume = volume;
// //         _isMuted = volume == 0;
// //       });
// //     }
// //   }
// //
// //   void _onVolumeChangeEnd(double volume) {
// //     if (_controller != null && !_isDisposing) {
// //       _controller!.setVolume(volume.round());
// //     }
// //   }
// //
// //   Widget _buildCustomPlaybackSpeedButton() {
// //     return PopupMenuButton<double>(
// //       icon: Icon(Icons.speed, color: Colors.white),
// //       tooltip: 'سرعة التشغيل',
// //       onSelected: (speed) {
// //         _changePlaybackRate(speed);
// //       },
// //       itemBuilder: (context) => [
// //         PopupMenuItem(value: 0.25, child: Text('0.25x')),
// //         PopupMenuItem(value: 0.5, child: Text('0.5x')),
// //         PopupMenuItem(value: 0.75, child: Text('0.75x')),
// //         PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
// //         PopupMenuItem(value: 1.25, child: Text('1.25x')),
// //         PopupMenuItem(value: 1.5, child: Text('1.5x')),
// //         PopupMenuItem(value: 1.75, child: Text('1.75x')),
// //         PopupMenuItem(value: 2.0, child: Text('2.0x')),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildVideoControls() {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 16.w),
// //       padding: EdgeInsets.all(16.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               _buildControlButton(
// //                 icon: Icons.replay_10,
// //                 text: 'رجوع 10ث',
// //                 onPressed: () => _seekBackward(10),
// //                 color: Color(0xFF1E88E5),
// //               ),
// //               _buildControlButton(
// //                 icon: _isPlaying ? Icons.pause : Icons.play_arrow,
// //                 text: _isPlaying ? 'إيقاف' : 'تشغيل',
// //                 onPressed: _togglePlayPause,
// //                 color: Color(0xFF1E88E5),
// //               ),
// //               _buildControlButton(
// //                 icon: _isMuted ? Icons.volume_off : Icons.volume_up,
// //                 text: _isMuted ? 'كتم' : 'صوت',
// //                 onPressed: _toggleMute,
// //                 color: Color(0xFFFFA726),
// //               ),
// //               _buildControlButton(
// //                 icon: Icons.forward_10,
// //                 text: 'تقدم 10ث',
// //                 onPressed: () => _seekForward(10),
// //                 color: Color(0xFF1E88E5),
// //               ),
// //             ],
// //           ),
// //
// //           SizedBox(height: 16.h),
// //
// //           Row(
// //             children: [
// //               Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
// //               SizedBox(width: 12.w),
// //               Expanded(
// //                 child: Slider(
// //                   value: _volume,
// //                   min: 0,
// //                   max: 100,
// //                   divisions: 10,
// //                   onChanged: _changeVolume,
// //                   onChangeEnd: _onVolumeChangeEnd,
// //                   activeColor: Color(0xFF1E88E5),
// //                   inactiveColor: Colors.grey[300],
// //                 ),
// //               ),
// //               SizedBox(width: 12.w),
// //               Text(
// //                 '${_volume.round()}%',
// //                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
// //               ),
// //             ],
// //           ),
// //
// //           SizedBox(height: 12.h),
// //
// //           Row(
// //             children: [
// //               Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
// //               SizedBox(width: 12.w),
// //               Text(
// //                 'السرعة:',
// //                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(width: 8.w),
// //               Expanded(
// //                 child: DropdownButton<double>(
// //                   value: _playbackRate,
// //                   isExpanded: true,
// //                   items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
// //                     return DropdownMenuItem(
// //                       value: speed,
// //                       child: Text(
// //                         '${speed}x',
// //                         style: TextStyle(fontSize: 12.sp),
// //                       ),
// //                     );
// //                   }).toList(),
// //                   onChanged: (speed) {
// //                     if (speed != null) _changePlaybackRate(speed);
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildControlButton({
// //     required IconData icon,
// //     required String text,
// //     required VoidCallback onPressed,
// //     required Color color,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 52.w,
// //           height: 52.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             shape: BoxShape.circle,
// //             boxShadow: [
// //               BoxShadow(
// //                 color: color.withOpacity(0.4),
// //                 blurRadius: 6.w,
// //                 offset: Offset(0, 3.h),
// //               ),
// //             ],
// //           ),
// //           child: IconButton(
// //             icon: Icon(icon, color: Colors.white, size: 22.sp),
// //             onPressed: onPressed,
// //           ),
// //         ),
// //         SizedBox(height: 8.h),
// //         Text(
// //           text,
// //           style: TextStyle(
// //             fontSize: 10.sp,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.black87,
// //             fontFamily: 'Tajawal',
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildLessonInfo() {
// //     return Container(
// //       margin: EdgeInsets.all(16.w),
// //       padding: EdgeInsets.all(20.w),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.w),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 8.w,
// //             offset: Offset(0, 2.h),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             'معلومات الدرس',
// //             style: TextStyle(
// //               fontSize: 18.sp,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF1E88E5),
// //               fontFamily: 'Tajawal',
// //             ),
// //           ),
// //           SizedBox(height: 16.h),
// //           _buildInfoRow(
// //             icon: Icons.school,
// //             label: 'المستوى',
// //             value: widget.lesson['level'] ?? 'مبتدئ',
// //             iconColor: Color(0xFF1E88E5),
// //           ),
// //           SizedBox(height: 12.h),
// //           _buildInfoRow(
// //             icon: Icons.format_list_numbered,
// //             label: 'رقم الدرس',
// //             value: '${widget.lesson['order_number'] ?? '1'}',
// //             iconColor: Color(0xFFFFA726),
// //           ),
// //           if (widget.lesson['description'] != null) ...[
// //             SizedBox(height: 16.h),
// //             Text(
// //               'الوصف:',
// //               style: TextStyle(
// //                 fontSize: 16.sp,
// //                 fontWeight: FontWeight.bold,
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //             SizedBox(height: 8.h),
// //             Text(
// //               widget.lesson['description']!,
// //               style: TextStyle(
// //                 fontSize: 14.sp,
// //                 color: Colors.grey[700],
// //                 fontFamily: 'Tajawal',
// //                 height: 1.5,
// //               ),
// //               textAlign: TextAlign.right,
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildInfoRow({
// //     required IconData icon,
// //     required String label,
// //     required String value,
// //     required Color iconColor,
// //   }) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 20.sp, color: iconColor),
// //         SizedBox(width: 12.w),
// //         Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 fontSize: 12.sp,
// //                 color: Colors.grey[600],
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //             Text(
// //               value,
// //               style: TextStyle(
// //                 fontSize: 14.sp,
// //                 fontWeight: FontWeight.bold,
// //                 fontFamily: 'Tajawal',
// //               ),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// //
// //   PreferredSizeWidget _buildAppBar() {
// //     return AppBar(
// //       backgroundColor: Color(0xFF1E88E5),
// //       foregroundColor: Colors.white,
// //       leading: IconButton(
// //         icon: Icon(Icons.arrow_back),
// //         onPressed: () async {
// //           // ✅ استخدام الدالة الجديدة للتعامل مع الرجوع
// //           if (await _onWillPop()) {
// //             Navigator.pop(context);
// //           }
// //         },
// //       ),
// //       title: Text(
// //         widget.lesson['title'] ?? 'عرض الدرس',
// //         style: TextStyle(
// //           fontSize: 18.sp,
// //           fontWeight: FontWeight.bold,
// //           fontFamily: 'Tajawal',
// //         ),
// //         maxLines: 1,
// //         overflow: TextOverflow.ellipsis,
// //       ),
// //       centerTitle: true,
// //       elevation: 0,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_hasError) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
// //               SizedBox(height: 16.h),
// //               Text(
// //                 _errorMessage,
// //                 style: TextStyle(
// //                   fontSize: 16.sp,
// //                   color: Colors.red[700],
// //                   fontFamily: 'Tajawal',
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     if (_controller == null && !_hasError) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(color: Color(0xFF1E88E5)),
// //               SizedBox(height: 16.h),
// //               Text(
// //                 'جاري تهيئة مشغل الفيديو...',
// //                 style: TextStyle(
// //                   fontSize: 16.sp,
// //                   color: Color(0xFF1E88E5),
// //                   fontFamily: 'Tajawal',
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     if (_controller == null) {
// //       return Scaffold(
// //         appBar: _buildAppBar(),
// //         body: Center(
// //           child: Text(
// //             'خطأ في تحميل الفيديو',
// //             style: TextStyle(
// //               fontSize: 16.sp,
// //               color: Colors.red,
// //               fontFamily: 'Tajawal',
// //             ),
// //           ),
// //         ),
// //       );
// //     }
// //
// //     return WillPopScope(
// //       onWillPop: _onWillPop, // ✅ استخدام الدالة المحسنة
// //       child: YoutubePlayerBuilder(
// //         onEnterFullScreen: () {
// //           SystemChrome.setPreferredOrientations([
// //             DeviceOrientation.landscapeRight,
// //             DeviceOrientation.landscapeLeft,
// //           ]);
// //         },
// //         onExitFullScreen: () {
// //           SystemChrome.setPreferredOrientations([
// //             DeviceOrientation.portraitUp,
// //           ]);
// //         },
// //         player: YoutubePlayer(
// //           controller: _controller!,
// //           showVideoProgressIndicator: true,
// //           progressIndicatorColor: Color(0xFF1E88E5),
// //           progressColors: ProgressBarColors(
// //             playedColor: Color(0xFF1E88E5),
// //             handleColor: Color(0xFF1E88E5),
// //             backgroundColor: Colors.grey[300]!,
// //           ),
// //           onReady: () {
// //             if (mounted && !_isDisposing) {
// //               setState(() {
// //                 _isPlayerReady = true;
// //               });
// //             }
// //           },
// //           onEnded: (metaData) {
// //             if (mounted && !_isDisposing) {
// //               setState(() {
// //                 _isPlaying = false;
// //               });
// //             }
// //           },
// //           bottomActions: [
// //             CurrentPosition(),
// //             ProgressBar(isExpanded: true),
// //             RemainingDuration(),
// //             _buildCustomPlaybackSpeedButton(),
// //             FullScreenButton(),
// //           ],
// //         ),
// //         builder: (context, player) {
// //           return Scaffold(
// //             backgroundColor: Color(0xFFF5F9FF),
// //             appBar: _buildAppBar(),
// //             body: SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: [
// //                   // ✅ إضافة AnimatedContainer لتحسين الانتقال
// //                   AnimatedContainer(
// //                     duration: Duration(milliseconds: 200),
// //                     height: MediaQuery.of(context).size.height * 0.4,
// //                     margin: EdgeInsets.all(8.w),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(12.w),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black26,
// //                           blurRadius: 12.w,
// //                           offset: Offset(0, 6.h),
// //                         ),
// //                       ],
// //                     ),
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(12.w),
// //                       child: player,
// //                     ),
// //                   ),
// //
// //                   if (_isPlayerReady) ...[
// //                     SizedBox(height: 16.h),
// //                     _buildVideoControls(),
// //                   ],
// //
// //                   SizedBox(height: 16.h),
// //                   _buildLessonInfo(),
// //                   SizedBox(height: 20.h),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _isDisposing = true; // ✅ وضع علامة أننا في حالة إغلاق
// //
// //     // ✅ إيقاف الفيديو أولاً
// //     _stopVideoBeforeExit();
// //
// //     // ✅ الانتظار قليلاً قبل التدمير
// //     Future.delayed(Duration(milliseconds: 50)).then((_) {
// //       _controller?.removeListener(_videoListener);
// //       _controller?.dispose();
// //     });
// //
// //     // ✅ إعادة ضبط اتجاه الشاشة
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.portraitUp,
// //       DeviceOrientation.landscapeRight,
// //       DeviceOrientation.landscapeLeft,
// //     ]);
// //
// //     super.dispose();
// //   }
// // }
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class LessonDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> lesson;
//
//   const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);
//
//   @override
//   _LessonDetailScreenState createState() => _LessonDetailScreenState();
// }
//
// class _LessonDetailScreenState extends State<LessonDetailScreen> {
//   YoutubePlayerController? _controller;
//   bool _isPlayerReady = false;
//   bool _hasError = false;
//   String _errorMessage = '';
//   bool _isMuted = false;
//   bool _isPlaying = false;
//   double _playbackRate = 1.0;
//   bool _isDisposing = false;
//   bool _showControls = true;
//   Timer? _controlsTimer;
//
//   bool _previousPlayingState = false;
//   bool _previousControlsState = true;
//   bool _isFirstPlay = true;
//   bool _showInitialLoader = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeScreen();
//   }
//
//   void _initializeScreen() {
//     _enterFullScreenMode();
//     _initializeYouTubePlayer();
//     _startControlsTimer();
//   }
//
//   void _enterFullScreenMode() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }
//
//   void _exitFullScreenMode() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//   }
//
//   void _initializeYouTubePlayer() {
//     try {
//       // ✅ التعديل: دعم هيكل Firebase للبيانات
//       String? videoUrl = widget.lesson['video_url'] ??
//           widget.lesson['youtube_url'] ??
//           'https://youtu.be/UB1O30fR-EE';
//
//       if (videoUrl != null && videoUrl.isNotEmpty) {
//         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//         if (videoId != null) {
//           _controller = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: true,
//               mute: false,
//               enableCaption: true,
//               captionLanguage: 'ar',
//               hideControls: true,
//               controlsVisibleAtStart: false,
//               useHybridComposition: true,
//               disableDragSeek: false,
//               loop: false,
//               isLive: false,
//               forceHD: true,
//               startAt: 0,
//             ),
//           );
//
//           _controller!.addListener(_optimizedVideoListener);
//           _preloadVideo();
//
//         } else {
//           _setErrorState('رابط الفيديو غير صالح');
//         }
//       } else {
//         _setErrorState('لا يتوفر فيديو لهذا الدرس');
//       }
//     } catch (e) {
//       _setErrorState('خطأ في تهيئة مشغل الفيديو: $e');
//     }
//   }
//
//   void _preloadVideo() {
//     if (_controller != null && !_isDisposing && mounted) {
//       setState(() {
//         _isPlayerReady = true;
//       });
//     }
//   }
//
//   void _optimizedVideoListener() {
//     if (!mounted || _isDisposing || _controller == null) return;
//
//     final currentPlayingState = _controller!.value.isPlaying;
//
//     if (currentPlayingState != _previousPlayingState) {
//       _previousPlayingState = currentPlayingState;
//
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted && !_isDisposing) {
//           setState(() {
//             _isPlaying = currentPlayingState;
//
//             if (_isPlaying && _showInitialLoader) {
//               _showInitialLoader = false;
//             }
//
//             if (_isPlaying && _isFirstPlay) {
//               _isFirstPlay = false;
//               Future.delayed(Duration(seconds: 2), () {
//                 if (mounted && !_isDisposing) {
//                   setState(() {
//                     _showControls = false;
//                   });
//                 }
//               });
//             }
//           });
//         }
//       });
//     }
//   }
//
//   void _setErrorState(String message) {
//     if (mounted && !_isDisposing) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = message;
//         _isPlayerReady = false;
//         _showInitialLoader = false;
//       });
//     }
//   }
//
//   void _stopVideoBeforeExit() {
//     if (_controller != null && _isPlayerReady) {
//       _controller!.pause();
//       _controller!.seekTo(Duration.zero);
//     }
//   }
//
//   Future<bool> _onWillPop() async {
//     _exitFullScreenMode();
//     _stopVideoBeforeExit();
//     await Future.delayed(Duration(milliseconds: 100));
//     return true;
//   }
//
//   void _togglePlayPause() {
//     if (_isPlayerReady && _controller != null && !_isDisposing) {
//       if (_controller!.value.isPlaying) {
//         _controller!.pause();
//       } else {
//         _controller!.play();
//       }
//       _showControlsTemporarily();
//     }
//   }
//
//   void _toggleMute() {
//     if (_controller != null && !_isDisposing) {
//       if (_isMuted) {
//         _controller!.unMute();
//       } else {
//         _controller!.mute();
//       }
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           setState(() {
//             _isMuted = !_isMuted;
//           });
//         }
//       });
//       _showControlsTemporarily();
//     }
//   }
//
//   void _seekForward(int seconds) {
//     if (_controller != null && !_isDisposing) {
//       final newPosition = _controller!.value.position + Duration(seconds: seconds);
//       _controller!.seekTo(newPosition);
//       _showControlsTemporarily();
//     }
//   }
//
//   void _seekBackward(int seconds) {
//     if (_controller != null && !_isDisposing) {
//       final newPosition = _controller!.value.position - Duration(seconds: seconds);
//       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
//       _showControlsTemporarily();
//     }
//   }
//
//   void _changePlaybackRate(double rate) {
//     if (_controller != null && !_isDisposing) {
//       _controller!.setPlaybackRate(rate);
//       Future.delayed(Duration(milliseconds: 50), () {
//         if (mounted) {
//           setState(() {
//             _playbackRate = rate;
//           });
//         }
//       });
//       _showControlsTemporarily();
//     }
//   }
//
//   void _showControlsTemporarily() {
//     if (_showControls != true) {
//       setState(() {
//         _showControls = true;
//         _previousControlsState = true;
//       });
//     }
//     _startControlsTimer();
//   }
//
//   void _startControlsTimer() {
//     _controlsTimer?.cancel();
//     _controlsTimer = Timer(Duration(seconds: 3), () {
//       if (mounted && !_isDisposing && _isPlaying && _showControls) {
//         setState(() {
//           _showControls = false;
//           _previousControlsState = false;
//         });
//       }
//     });
//   }
//
//   Widget _buildInitialLoader() {
//     return AnimatedOpacity(
//       opacity: _showInitialLoader ? 1.0 : 0.0,
//       duration: Duration(milliseconds: 300),
//       child: Container(
//         color: Colors.transparent,
//         child: Center(
//           child: Container(
//             width: 80.w,
//             height: 80.w,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 10.w,
//                   offset: Offset(0, 2.h),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: SizedBox(
//                 width: 32.w,
//                 height: 32.w,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 3.w,
//                   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
//                   backgroundColor: Colors.grey[100],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildYouTubeLikeControls() {
//     return _VideoControlsOverlay(
//       showControls: _showControls,
//       isPlaying: _isPlaying,
//       isMuted: _isMuted,
//       playbackRate: _playbackRate,
//       controller: _controller,
//       // ✅ التعديل: دعم أسماء الحقول المختلفة في Firebase
//       lessonTitle: widget.lesson['lesson_title'] ??
//           widget.lesson['title'] ??
//           'عرض الدرس',
//       onTogglePlayPause: _togglePlayPause,
//       onToggleMute: _toggleMute,
//       onSeekForward: _seekForward,
//       onSeekBackward: _seekBackward,
//       onChangePlaybackRate: _changePlaybackRate,
//       onExit: _onWillPop,
//     );
//   }
//
//   Widget _buildErrorScreen() {
//     return Container(
//       color: Colors.black,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//             SizedBox(height: 16.h),
//             Text(
//               _errorMessage,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.white,
//                 fontFamily: 'Tajawal',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20.h),
//             ElevatedButton(
//               onPressed: () {
//                 _exitFullScreenMode();
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'العودة',
//                 style: TextStyle(fontFamily: 'Tajawal'),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoadingScreen() {
//     return Container(
//       color: Colors.black,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.red),
//             SizedBox(height: 16.h),
//             Text(
//               'جاري تحميل الفيديو...',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.white,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           backgroundColor: Colors.black,
//           body: _buildErrorScreen(),
//         ),
//       );
//     }
//
//     if (_controller == null && !_hasError) {
//       return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           backgroundColor: Colors.black,
//           body: _buildLoadingScreen(),
//         ),
//       );
//     }
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: WillPopScope(
//         onWillPop: _onWillPop,
//         child: GestureDetector(
//           onTap: () {
//             if (_showControls != !_showControls) {
//               setState(() {
//                 _showControls = !_showControls;
//               });
//             }
//             if (_showControls) {
//               _startControlsTimer();
//             }
//           },
//           child: Scaffold(
//             backgroundColor: Colors.black,
//             body: Stack(
//               children: [
//                 if (_isPlayerReady)
//                   Positioned.fill(
//                     child: YoutubePlayer(
//                       controller: _controller!,
//                       showVideoProgressIndicator: false,
//                       progressIndicatorColor: Colors.red,
//                       progressColors: ProgressBarColors(
//                         playedColor: Colors.red,
//                         handleColor: Colors.red,
//                         backgroundColor: Colors.grey[800]!,
//                       ),
//                       onReady: () {
//                         if (mounted && !_isDisposing) {
//                           setState(() {
//                             _isPlayerReady = true;
//                           });
//                         }
//                       },
//                       onEnded: (metaData) {
//                         if (mounted && !_isDisposing) {
//                           setState(() {
//                             _isPlaying = false;
//                             _showControls = true;
//                           });
//                         }
//                       },
//                     ),
//                   ),
//
//                 if (_isPlayerReady) _buildYouTubeLikeControls(),
//
//                 if (_showInitialLoader) _buildInitialLoader(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _isDisposing = true;
//     _controlsTimer?.cancel();
//     _stopVideoBeforeExit();
//     _exitFullScreenMode();
//
//     Future.delayed(Duration(milliseconds: 100)).then((_) {
//       _controller?.removeListener(_optimizedVideoListener);
//       _controller?.dispose();
//     });
//
//     super.dispose();
//   }
// }
//
// class _VideoControlsOverlay extends StatelessWidget {
//   final bool showControls;
//   final bool isPlaying;
//   final bool isMuted;
//   final double playbackRate;
//   final YoutubePlayerController? controller;
//   final String lessonTitle;
//   final VoidCallback onTogglePlayPause;
//   final VoidCallback onToggleMute;
//   final Function(int) onSeekForward;
//   final Function(int) onSeekBackward;
//   final Function(double) onChangePlaybackRate;
//   final Future<bool> Function() onExit;
//
//   const _VideoControlsOverlay({
//     required this.showControls,
//     required this.isPlaying,
//     required this.isMuted,
//     required this.playbackRate,
//     required this.controller,
//     required this.lessonTitle,
//     required this.onTogglePlayPause,
//     required this.onToggleMute,
//     required this.onSeekForward,
//     required this.onSeekBackward,
//     required this.onChangePlaybackRate,
//     required this.onExit,
//   });
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     if (duration.inHours > 0) {
//       return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//     } else {
//       return "$twoDigitMinutes:$twoDigitSeconds";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: showControls ? 1.0 : 0.0,
//       duration: Duration(milliseconds: 300),
//       child: Container(
//         color: Colors.transparent,
//         child: Stack(
//           children: [
//             // التحكم السفلي
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 80.h,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.8),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     // شريط التقدم
//                     Container(
//                       height: 3.h,
//                       child: ProgressBar(
//                         isExpanded: true,
//                         controller: controller!,
//                         colors: ProgressBarColors(
//                           playedColor: Colors.red,
//                           handleColor: Colors.red,
//                           backgroundColor: Colors.grey[800]!,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//
//                     // أزرار التحكم
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16.w),
//                         child: Row(
//                           children: [
//                             IconButton(
//                               onPressed: onTogglePlayPause,
//                               icon: Icon(
//                                 isPlaying ? Icons.pause : Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 24.sp,
//                               ),
//                             ),
//
//                             Text(
//                               _formatDuration(controller?.value.position ?? Duration.zero),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//
//                             IconButton(
//                               onPressed: onToggleMute,
//                               icon: Icon(
//                                 isMuted ? Icons.volume_off : Icons.volume_up,
//                                 color: Colors.white,
//                                 size: 20.sp,
//                               ),
//                             ),
//
//                             PopupMenuButton<double>(
//                               icon: Icon(
//                                 Icons.settings,
//                                 color: Colors.white,
//                                 size: 20.sp,
//                               ),
//                               onSelected: onChangePlaybackRate,
//                               itemBuilder: (context) => [
//                                 PopupMenuItem(value: 0.5, child: Text('0.5x')),
//                                 PopupMenuItem(value: 0.75, child: Text('0.75x')),
//                                 PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
//                                 PopupMenuItem(value: 1.25, child: Text('1.25x')),
//                                 PopupMenuItem(value: 1.5, child: Text('1.5x')),
//                                 PopupMenuItem(value: 1.75, child: Text('1.75x')),
//                                 PopupMenuItem(value: 2.0, child: Text('2.0x')),
//                               ],
//                             ),
//
//                             Spacer(),
//
//                             Text(
//                               '-${_formatDuration((controller?.value.metaData.duration ?? Duration.zero) - (controller?.value.position ?? Duration.zero))}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//
//                             SizedBox(width: 16.w),
//
//                             IconButton(
//                               onPressed: () async {
//                                 if (await onExit()) {
//                                   Navigator.of(context).pop();
//                                 }
//                               },
//                               icon: Icon(
//                                 Icons.fullscreen_exit,
//                                 color: Colors.white,
//                                 size: 24.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // التحكم العلوي
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: AnimatedOpacity(
//                 opacity: showControls ? 1.0 : 0.0,
//                 duration: Duration(milliseconds: 300),
//                 child: Container(
//                   height: 60.h,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.8),
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () async {
//                           if (await onExit()) {
//                             Navigator.of(context).pop();
//                           }
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                           size: 24.sp,
//                         ),
//                       ),
//
//                       Expanded(
//                         child: Text(
//                           lessonTitle,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'Tajawal',
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//
//                       IconButton(
//                         onPressed: () => onSeekBackward(10),
//                         icon: Icon(
//                           Icons.replay_10,
//                           color: Colors.white,
//                           size: 24.sp,
//                         ),
//                       ),
//
//                       IconButton(
//                         onPressed: () => onSeekForward(10),
//                         icon: Icon(
//                           Icons.forward_10,
//                           color: Colors.white,
//                           size: 24.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

  @override
  void initState() {
    super.initState();
    _initializeYouTubePlayer();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
              autoPlay: false,
              mute: false,
              enableCaption: true,
              captionLanguage: 'ar',
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

          setState(() {
            _isPlayerReady = true;
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
      });
    }
  }

  void _setErrorState(String message) {
    if (mounted) {
      setState(() {
        _hasError = true;
        _errorMessage = message;
        _isPlayerReady = false;
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
      final newPosition = _controller!.value.position + Duration(seconds: seconds);
      _controller!.seekTo(newPosition);
    }
  }

  void _seekBackward(int seconds) {
    if (_controller != null) {
      final newPosition = _controller!.value.position - Duration(seconds: seconds);
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

  Widget _buildVideoControls() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.w,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: Icons.replay_10,
                text: 'رجوع 10ث',
                onPressed: () => _seekBackward(10),
                color: const Color(0xFF1E88E5),
              ),
              _buildControlButton(
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                text: _isPlaying ? 'إيقاف' : 'تشغيل',
                onPressed: _togglePlayPause,
                color: const Color(0xFF1E88E5),
              ),
              _buildControlButton(
                icon: _isMuted ? Icons.volume_off : Icons.volume_up,
                text: _isMuted ? 'كتم' : 'صوت',
                onPressed: _toggleMute,
                color: const Color(0xFFFFA726),
              ),
              _buildControlButton(
                icon: Icons.forward_10,
                text: 'تقدم 10ث',
                onPressed: () => _seekForward(10),
                color: const Color(0xFF1E88E5),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
              SizedBox(width: 12.w),
              Expanded(
                child: Slider(
                  value: _volume,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: _changeVolume,
                  onChangeEnd: _onVolumeChangeEnd,
                  activeColor: const Color(0xFF1E88E5),
                  inactiveColor: Colors.grey[300],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${_volume.round()}%',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
              SizedBox(width: 12.w),
              Text(
                'السرعة:',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: DropdownButton<double>(
                  value: _playbackRate,
                  isExpanded: true,
                  items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
                    return DropdownMenuItem(
                      value: speed,
                      child: Text('${speed}x', style: TextStyle(fontSize: 12.sp)),
                    );
                  }).toList(),
                  onChanged: (speed) {
                    if (speed != null) _changePlaybackRate(speed);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 52.w,
          height: 52.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 6.w,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 22.sp),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          text,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonInfo() {
    String lessonTitle = widget.lesson['lesson_title'] ?? 'بدون عنوان';
    int orderIndex = widget.lesson['order_index'] ?? 1;
    bool isActive = widget.lesson['is_active'] ?? true;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.w,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الدرس',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E88E5),
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            icon: Icons.menu_book_rounded,
            label: 'المادة',
            value: widget.subjectName,
            iconColor: const Color(0xFF1E88E5),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.school,
            label: 'رقم الدرس',
            value: 'الدرس $orderIndex',
            iconColor: const Color(0xFFFFA726),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.verified,
            label: 'حالة الدرس',
            value: isActive ? 'نشط' : 'غير مفعل',
            iconColor: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
          ),
          if (lessonTitle.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              'عنوان الدرس:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              lessonTitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: iconColor),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    String lessonTitle = widget.lesson['lesson_title'] ?? 'عرض الدرس';

    return AppBar(
      backgroundColor: const Color(0xFF1E88E5),
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        lessonTitle,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        appBar: _buildAppBar(),
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
                  color: Colors.red[700],
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
        appBar: _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: const Color(0xFF1E88E5)),
              SizedBox(height: 16.h),
              Text(
                'جاري تحميل الفيديو...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF1E88E5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      },
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFF1E88E5),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFF1E88E5),
          handleColor: Color(0xFF1E88E5),
          backgroundColor: Colors.grey,
        ),
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F9FF),
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300.h,
                  margin: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12.w,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.w),
                    child: player,
                  ),
                ),
                if (_isPlayerReady) ...[
                  SizedBox(height: 16.h),
                  _buildVideoControls(),
                ],
                SizedBox(height: 16.h),
                _buildLessonInfo(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }
}
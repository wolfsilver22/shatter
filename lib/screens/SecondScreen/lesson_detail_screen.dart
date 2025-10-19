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
//   double _volume = 100;
//   bool _isPlaying = false;
//   double _playbackRate = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeYouTubePlayer();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//   }
//
//   void _initializeYouTubePlayer() {
//     try {
//       String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';
//
//       if (videoUrl != null && videoUrl.isNotEmpty) {
//         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//         if (videoId != null) {
//           _controller = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: false,
//               mute: false,
//               enableCaption: true,
//               captionLanguage: 'ar',
//               hideControls: false,
//               controlsVisibleAtStart: true,
//               useHybridComposition: true,
//               disableDragSeek: false,
//               loop: false,
//               isLive: false,
//               forceHD: true,
//             ),
//           );
//
//           _controller!.addListener(_videoListener);
//
//           if (mounted) {
//             setState(() {
//               _isPlayerReady = true;
//             });
//           }
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
//   void _videoListener() {
//     if (!mounted) return;
//
//     if (_controller != null) {
//       setState(() {
//         _isPlaying = _controller!.value.isPlaying;
//       });
//     }
//   }
//
//   void _setErrorState(String message) {
//     if (mounted) {
//       setState(() {
//         _hasError = true;
//         _errorMessage = message;
//         _isPlayerReady = false;
//       });
//     }
//   }
//
//   void _togglePlayPause() {
//     if (_isPlayerReady && _controller != null) {
//       if (_controller!.value.isPlaying) {
//         _controller!.pause();
//       } else {
//         _controller!.play();
//       }
//     }
//   }
//
//   void _toggleMute() {
//     if (_controller != null) {
//       if (_isMuted) {
//         _controller!.unMute();
//         setState(() {
//           _isMuted = false;
//           _volume = 100;
//         });
//       } else {
//         _controller!.mute();
//         setState(() {
//           _isMuted = true;
//           _volume = 0;
//         });
//       }
//     }
//   }
//
//   void _seekForward(int seconds) {
//     if (_controller != null) {
//       final newPosition = _controller!.value.position + Duration(seconds: seconds);
//       _controller!.seekTo(newPosition);
//     }
//   }
//
//   void _seekBackward(int seconds) {
//     if (_controller != null) {
//       final newPosition = _controller!.value.position - Duration(seconds: seconds);
//       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
//     }
//   }
//
//   void _changePlaybackRate(double rate) {
//     if (_controller != null) {
//       _controller!.setPlaybackRate(rate);
//       setState(() {
//         _playbackRate = rate;
//       });
//     }
//   }
//
//   void _changeVolume(double volume) {
//     setState(() {
//       _volume = volume;
//       _isMuted = volume == 0;
//     });
//   }
//
//   void _onVolumeChangeEnd(double volume) {
//     if (_controller != null) {
//       _controller!.setVolume(volume.round());
//     }
//   }
//
//   Widget _buildCustomPlaybackSpeedButton() {
//     return PopupMenuButton<double>(
//       icon: Icon(Icons.speed, color: Colors.white),
//       tooltip: 'سرعة التشغيل',
//       onSelected: (speed) {
//         _changePlaybackRate(speed);
//       },
//       itemBuilder: (context) => [
//         PopupMenuItem(value: 0.25, child: Text('0.25x')),
//         PopupMenuItem(value: 0.5, child: Text('0.5x')),
//         PopupMenuItem(value: 0.75, child: Text('0.75x')),
//         PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
//         PopupMenuItem(value: 1.25, child: Text('1.25x')),
//         PopupMenuItem(value: 1.5, child: Text('1.5x')),
//         PopupMenuItem(value: 1.75, child: Text('1.75x')),
//         PopupMenuItem(value: 2.0, child: Text('2.0x')),
//       ],
//     );
//   }
//
//   Widget _buildVideoControls() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildControlButton(
//                 icon: Icons.replay_10,
//                 text: 'رجوع 10ث',
//                 onPressed: () => _seekBackward(10),
//                 color: Color(0xFF1E88E5),
//               ),
//               _buildControlButton(
//                 icon: _isPlaying ? Icons.pause : Icons.play_arrow,
//                 text: _isPlaying ? 'إيقاف' : 'تشغيل',
//                 onPressed: _togglePlayPause,
//                 color: Color(0xFF1E88E5),
//               ),
//               _buildControlButton(
//                 icon: _isMuted ? Icons.volume_off : Icons.volume_up,
//                 text: _isMuted ? 'كتم' : 'صوت',
//                 onPressed: _toggleMute,
//                 color: Color(0xFFFFA726),
//               ),
//               _buildControlButton(
//                 icon: Icons.forward_10,
//                 text: 'تقدم 10ث',
//                 onPressed: () => _seekForward(10),
//                 color: Color(0xFF1E88E5),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 16.h),
//
//           Row(
//             children: [
//               Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Slider(
//                   value: _volume,
//                   min: 0,
//                   max: 100,
//                   divisions: 10,
//                   onChanged: _changeVolume,
//                   onChangeEnd: _onVolumeChangeEnd,
//                   activeColor: Color(0xFF1E88E5),
//                   inactiveColor: Colors.grey[300],
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 '${_volume.round()}%',
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 12.h),
//
//           Row(
//             children: [
//               Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Text(
//                 'السرعة:',
//                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: DropdownButton<double>(
//                   value: _playbackRate,
//                   isExpanded: true,
//                   items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
//                     return DropdownMenuItem(
//                       value: speed,
//                       child: Text(
//                         '${speed}x',
//                         style: TextStyle(fontSize: 12.sp),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (speed) {
//                     if (speed != null) _changePlaybackRate(speed);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 52.w,
//           height: 52.h,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.4),
//                 blurRadius: 6.w,
//                 offset: Offset(0, 3.h),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: Icon(icon, color: Colors.white, size: 22.sp),
//             onPressed: onPressed,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLessonInfo() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'معلومات الدرس',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1E88E5),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 16.h),
//           _buildInfoRow(
//             icon: Icons.school,
//             label: 'المستوى',
//             value: widget.lesson['level'] ?? 'مبتدئ',
//             iconColor: Color(0xFF1E88E5),
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.format_list_numbered,
//             label: 'رقم الدرس',
//             value: '${widget.lesson['order_number'] ?? '1'}',
//             iconColor: Color(0xFFFFA726),
//           ),
//           if (widget.lesson['description'] != null) ...[
//             SizedBox(height: 16.h),
//             Text(
//               'الوصف:',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               widget.lesson['description']!,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[700],
//                 fontFamily: 'Tajawal',
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 20.sp, color: iconColor),
//         SizedBox(width: 12.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.grey[600],
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(0xFF1E88E5),
//       foregroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Text(
//         widget.lesson['title'] ?? 'عرض الدرس',
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       centerTitle: true,
//       elevation: 0,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//               SizedBox(height: 16.h),
//               Text(
//                 _errorMessage,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.red[700],
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null && !_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(color: Color(0xFF1E88E5)),
//               SizedBox(height: 16.h),
//               Text(
//                 'جاري تهيئة مشغل الفيديو...',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Color(0xFF1E88E5),
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Text(
//             'خطأ في تحميل الفيديو',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.red,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ),
//       );
//     }
//
//     return WillPopScope(
//       onWillPop: () async {
//         if (_controller != null && _controller!.value.isFullScreen) {
//           _controller!.toggleFullScreenMode();
//           return false;
//         }
//         return true;
//       },
//       child: YoutubePlayerBuilder(
//         onEnterFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeRight,
//             DeviceOrientation.landscapeLeft,
//           ]);
//         },
//         onExitFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//           ]);
//         },
//         player: YoutubePlayer(
//           controller: _controller!,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Color(0xFF1E88E5),
//           progressColors: ProgressBarColors(
//             playedColor: Color(0xFF1E88E5),
//             handleColor: Color(0xFF1E88E5),
//             backgroundColor: Colors.grey[300]!,
//           ),
//           onReady: () {
//             if (mounted) {
//               setState(() {
//                 _isPlayerReady = true;
//               });
//             }
//           },
//           onEnded: (metaData) {
//             if (mounted) {
//               setState(() {
//                 _isPlaying = false;
//               });
//             }
//           },
//           bottomActions: [
//             CurrentPosition(),
//             ProgressBar(isExpanded: true),
//             RemainingDuration(),
//             _buildCustomPlaybackSpeedButton(),
//             FullScreenButton(),
//           ],
//         ),
//         builder: (context, player) {
//           return Scaffold(
//             backgroundColor: Color(0xFFF5F9FF),
//             appBar: _buildAppBar(),
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     margin: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.w),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 12.w,
//                           offset: Offset(0, 6.h),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12.w),
//                       child: player,
//                     ),
//                   ),
//
//                   if (_isPlayerReady) ...[
//                     SizedBox(height: 16.h),
//                     _buildVideoControls(),
//                   ],
//
//                   SizedBox(height: 16.h),
//                   _buildLessonInfo(),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//
//     _controller?.removeListener(_videoListener);
//     _controller?.dispose();
//     super.dispose();
//   }
// }

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
//   double _volume = 100;
//   bool _isPlaying = false;
//   double _playbackRate = 1.0;
//   bool _isDisposing = false; // ✅ منع العمليات أثناء الإغلاق
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeYouTubePlayer();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//   }
//
//   void _initializeYouTubePlayer() {
//     try {
//       String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';
//
//       if (videoUrl != null && videoUrl.isNotEmpty) {
//         String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//         if (videoId != null) {
//           _controller = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: false,
//               mute: false,
//               enableCaption: true,
//               captionLanguage: 'ar',
//               hideControls: false,
//               controlsVisibleAtStart: true,
//               useHybridComposition: true,
//               disableDragSeek: false,
//               loop: false,
//               isLive: false,
//               forceHD: false, // ✅ تغيير إلى false لتحسين الأداء
//             ),
//           );
//
//           _controller!.addListener(_videoListener);
//
//           if (mounted) {
//             setState(() {
//               _isPlayerReady = true;
//             });
//           }
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
//   void _videoListener() {
//     if (!mounted || _isDisposing) return;
//
//     if (_controller != null) {
//       setState(() {
//         _isPlaying = _controller!.value.isPlaying;
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
//       });
//     }
//   }
//
//   // ✅ إيقاف الفيديو قبل الخروج من الشاشة
//   void _stopVideoBeforeExit() {
//     if (_controller != null && _isPlayerReady) {
//       // إيقاف الفيديو وإعادة تعيينه
//       _controller!.pause();
//       // إرجاع الفيديو إلى البداية
//       _controller!.seekTo(Duration.zero);
//     }
//   }
//
//   // ✅ التعامل مع زر الرجوع يدويًا
//   Future<bool> _onWillPop() async {
//     // إذا كان في وضع fullscreen، نخرج منه أولاً
//     if (_controller != null && _controller!.value.isFullScreen) {
//       _controller!.toggleFullScreenMode();
//       return false;
//     }
//
//     // إيقاف الفيديو قبل الخروج
//     _stopVideoBeforeExit();
//
//     // انتظار قليل لضمان إيقاف الفيديو
//     await Future.delayed(Duration(milliseconds: 100));
//
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
//     }
//   }
//
//   void _toggleMute() {
//     if (_controller != null && !_isDisposing) {
//       if (_isMuted) {
//         _controller!.unMute();
//         setState(() {
//           _isMuted = false;
//           _volume = 100;
//         });
//       } else {
//         _controller!.mute();
//         setState(() {
//           _isMuted = true;
//           _volume = 0;
//         });
//       }
//     }
//   }
//
//   void _seekForward(int seconds) {
//     if (_controller != null && !_isDisposing) {
//       final newPosition = _controller!.value.position + Duration(seconds: seconds);
//       _controller!.seekTo(newPosition);
//     }
//   }
//
//   void _seekBackward(int seconds) {
//     if (_controller != null && !_isDisposing) {
//       final newPosition = _controller!.value.position - Duration(seconds: seconds);
//       _controller!.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
//     }
//   }
//
//   void _changePlaybackRate(double rate) {
//     if (_controller != null && !_isDisposing) {
//       _controller!.setPlaybackRate(rate);
//       setState(() {
//         _playbackRate = rate;
//       });
//     }
//   }
//
//   void _changeVolume(double volume) {
//     if (!_isDisposing) {
//       setState(() {
//         _volume = volume;
//         _isMuted = volume == 0;
//       });
//     }
//   }
//
//   void _onVolumeChangeEnd(double volume) {
//     if (_controller != null && !_isDisposing) {
//       _controller!.setVolume(volume.round());
//     }
//   }
//
//   Widget _buildCustomPlaybackSpeedButton() {
//     return PopupMenuButton<double>(
//       icon: Icon(Icons.speed, color: Colors.white),
//       tooltip: 'سرعة التشغيل',
//       onSelected: (speed) {
//         _changePlaybackRate(speed);
//       },
//       itemBuilder: (context) => [
//         PopupMenuItem(value: 0.25, child: Text('0.25x')),
//         PopupMenuItem(value: 0.5, child: Text('0.5x')),
//         PopupMenuItem(value: 0.75, child: Text('0.75x')),
//         PopupMenuItem(value: 1.0, child: Text('عادي (1.0x)')),
//         PopupMenuItem(value: 1.25, child: Text('1.25x')),
//         PopupMenuItem(value: 1.5, child: Text('1.5x')),
//         PopupMenuItem(value: 1.75, child: Text('1.75x')),
//         PopupMenuItem(value: 2.0, child: Text('2.0x')),
//       ],
//     );
//   }
//
//   Widget _buildVideoControls() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildControlButton(
//                 icon: Icons.replay_10,
//                 text: 'رجوع 10ث',
//                 onPressed: () => _seekBackward(10),
//                 color: Color(0xFF1E88E5),
//               ),
//               _buildControlButton(
//                 icon: _isPlaying ? Icons.pause : Icons.play_arrow,
//                 text: _isPlaying ? 'إيقاف' : 'تشغيل',
//                 onPressed: _togglePlayPause,
//                 color: Color(0xFF1E88E5),
//               ),
//               _buildControlButton(
//                 icon: _isMuted ? Icons.volume_off : Icons.volume_up,
//                 text: _isMuted ? 'كتم' : 'صوت',
//                 onPressed: _toggleMute,
//                 color: Color(0xFFFFA726),
//               ),
//               _buildControlButton(
//                 icon: Icons.forward_10,
//                 text: 'تقدم 10ث',
//                 onPressed: () => _seekForward(10),
//                 color: Color(0xFF1E88E5),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 16.h),
//
//           Row(
//             children: [
//               Icon(Icons.volume_up, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Slider(
//                   value: _volume,
//                   min: 0,
//                   max: 100,
//                   divisions: 10,
//                   onChanged: _changeVolume,
//                   onChangeEnd: _onVolumeChangeEnd,
//                   activeColor: Color(0xFF1E88E5),
//                   inactiveColor: Colors.grey[300],
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Text(
//                 '${_volume.round()}%',
//                 style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 12.h),
//
//           Row(
//             children: [
//               Icon(Icons.speed, size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 12.w),
//               Text(
//                 'السرعة:',
//                 style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: DropdownButton<double>(
//                   value: _playbackRate,
//                   isExpanded: true,
//                   items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
//                     return DropdownMenuItem(
//                       value: speed,
//                       child: Text(
//                         '${speed}x',
//                         style: TextStyle(fontSize: 12.sp),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (speed) {
//                     if (speed != null) _changePlaybackRate(speed);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required String text,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 52.w,
//           height: 52.h,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.4),
//                 blurRadius: 6.w,
//                 offset: Offset(0, 3.h),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: Icon(icon, color: Colors.white, size: 22.sp),
//             onPressed: onPressed,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 10.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontFamily: 'Tajawal',
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLessonInfo() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.w),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.w,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'معلومات الدرس',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1E88E5),
//               fontFamily: 'Tajawal',
//             ),
//           ),
//           SizedBox(height: 16.h),
//           _buildInfoRow(
//             icon: Icons.school,
//             label: 'المستوى',
//             value: widget.lesson['level'] ?? 'مبتدئ',
//             iconColor: Color(0xFF1E88E5),
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.format_list_numbered,
//             label: 'رقم الدرس',
//             value: '${widget.lesson['order_number'] ?? '1'}',
//             iconColor: Color(0xFFFFA726),
//           ),
//           if (widget.lesson['description'] != null) ...[
//             SizedBox(height: 16.h),
//             Text(
//               'الوصف:',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               widget.lesson['description']!,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: Colors.grey[700],
//                 fontFamily: 'Tajawal',
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 20.sp, color: iconColor),
//         SizedBox(width: 12.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: Colors.grey[600],
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(0xFF1E88E5),
//       foregroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () async {
//           // ✅ استخدام الدالة الجديدة للتعامل مع الرجوع
//           if (await _onWillPop()) {
//             Navigator.pop(context);
//           }
//         },
//       ),
//       title: Text(
//         widget.lesson['title'] ?? 'عرض الدرس',
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Tajawal',
//         ),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       centerTitle: true,
//       elevation: 0,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
//               SizedBox(height: 16.h),
//               Text(
//                 _errorMessage,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.red[700],
//                   fontFamily: 'Tajawal',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null && !_hasError) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(color: Color(0xFF1E88E5)),
//               SizedBox(height: 16.h),
//               Text(
//                 'جاري تهيئة مشغل الفيديو...',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Color(0xFF1E88E5),
//                   fontFamily: 'Tajawal',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (_controller == null) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: Center(
//           child: Text(
//             'خطأ في تحميل الفيديو',
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: Colors.red,
//               fontFamily: 'Tajawal',
//             ),
//           ),
//         ),
//       );
//     }
//
//     return WillPopScope(
//       onWillPop: _onWillPop, // ✅ استخدام الدالة المحسنة
//       child: YoutubePlayerBuilder(
//         onEnterFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.landscapeRight,
//             DeviceOrientation.landscapeLeft,
//           ]);
//         },
//         onExitFullScreen: () {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//           ]);
//         },
//         player: YoutubePlayer(
//           controller: _controller!,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Color(0xFF1E88E5),
//           progressColors: ProgressBarColors(
//             playedColor: Color(0xFF1E88E5),
//             handleColor: Color(0xFF1E88E5),
//             backgroundColor: Colors.grey[300]!,
//           ),
//           onReady: () {
//             if (mounted && !_isDisposing) {
//               setState(() {
//                 _isPlayerReady = true;
//               });
//             }
//           },
//           onEnded: (metaData) {
//             if (mounted && !_isDisposing) {
//               setState(() {
//                 _isPlaying = false;
//               });
//             }
//           },
//           bottomActions: [
//             CurrentPosition(),
//             ProgressBar(isExpanded: true),
//             RemainingDuration(),
//             _buildCustomPlaybackSpeedButton(),
//             FullScreenButton(),
//           ],
//         ),
//         builder: (context, player) {
//           return Scaffold(
//             backgroundColor: Color(0xFFF5F9FF),
//             appBar: _buildAppBar(),
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // ✅ إضافة AnimatedContainer لتحسين الانتقال
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 200),
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     margin: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.w),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 12.w,
//                           offset: Offset(0, 6.h),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12.w),
//                       child: player,
//                     ),
//                   ),
//
//                   if (_isPlayerReady) ...[
//                     SizedBox(height: 16.h),
//                     _buildVideoControls(),
//                   ],
//
//                   SizedBox(height: 16.h),
//                   _buildLessonInfo(),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _isDisposing = true; // ✅ وضع علامة أننا في حالة إغلاق
//
//     // ✅ إيقاف الفيديو أولاً
//     _stopVideoBeforeExit();
//
//     // ✅ الانتظار قليلاً قبل التدمير
//     Future.delayed(Duration(milliseconds: 50)).then((_) {
//       _controller?.removeListener(_videoListener);
//       _controller?.dispose();
//     });
//
//     // ✅ إعادة ضبط اتجاه الشاشة
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//
//     super.dispose();
//   }
// }
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
      String? videoUrl = widget.lesson['video_url'] ?? 'https://youtu.be/UB1O30fR-EE';

      if (videoUrl != null && videoUrl.isNotEmpty) {
        String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
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
              forceHD: false,
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
    if (_controller != null && _controller!.value.isFullScreen) {
      _controller!.toggleFullScreenMode();
      return false;
    }

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

  Widget _buildVideoControls() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15.w,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          // أزرار التحكم الرئيسية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: Icons.replay_10,
                text: 'رجوع 10ث',
                onPressed: () => _seekBackward(10),
                color: Color(0xFF1E88E5),
              ),
              _buildControlButton(
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                text: _isPlaying ? 'إيقاف' : 'تشغيل',
                onPressed: _togglePlayPause,
                color: Color(0xFF1E88E5),
                isMain: true,
              ),
              _buildControlButton(
                icon: _isMuted ? Icons.volume_off : Icons.volume_up,
                text: _isMuted ? 'كتم' : 'صوت',
                onPressed: _toggleMute,
                color: Color(0xFFFFA726),
              ),
              _buildControlButton(
                icon: Icons.forward_10,
                text: 'تقدم 10ث',
                onPressed: () => _seekForward(10),
                color: Color(0xFF1E88E5),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // التحكم في الصوت
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFA726),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مستوى الصوت',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Slider(
                      value: _volume,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      onChanged: _changeVolume,
                      onChangeEnd: _onVolumeChangeEnd,
                      activeColor: Color(0xFFFFA726),
                      inactiveColor: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color(0xFF1E88E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${_volume.round()}%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E88E5),
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // سرعة التشغيل
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Color(0xFF1E88E5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.speed,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سرعة التشغيل',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    DropdownButton<double>(
                      value: _playbackRate,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down, color: Color(0xFF1E88E5)),
                      items: [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
                        return DropdownMenuItem(
                          value: speed,
                          child: Text(
                            '${speed}x',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF1E88E5),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (speed) {
                        if (speed != null) _changePlaybackRate(speed);
                      },
                    ),
                  ],
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
    bool isMain = false,
  }) {
    return Column(
      children: [
        Container(
          width: isMain ? 64.w : 52.w,
          height: isMain ? 64.h : 52.h,
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
                size: isMain ? 28.sp : 22.sp
            ),
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
            fontFamily: 'Tajawal',
          ),
        ),
      ],
    );
  }

  // ✅ التعديل: بناء رأس مخصص بدلاً من AppBar
  Widget _buildCustomHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Color(0xFF1E88E5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.w),
          bottomRight: Radius.circular(20.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
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
            SizedBox(width: 12.w),
            // عنوان الدرس
            Expanded(
              child: Text(
                widget.lesson['title'] ?? 'عرض الدرس',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Tajawal',
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ التعديل: بناء واجهة الخطأ بدون AppBar
  Widget _buildErrorScreen() {
    return Container(
      color: Color(0xFFF5F9FF),
      child: Column(
        children: [
          _buildCustomHeader(),
          Expanded(
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
                      color: Colors.red[700],
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ التعديل: بناء واجهة التحميل بدون AppBar
  Widget _buildLoadingScreen() {
    return Container(
      color: Color(0xFFF5F9FF),
      child: Column(
        children: [
          _buildCustomHeader(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF1E88E5)),
                  SizedBox(height: 16.h),
                  Text(
                    'جاري تهيئة مشغل الفيديو...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF1E88E5),
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // ❌ إزالة AppBar
          body: _buildErrorScreen(),
        ),
      );
    }

    if (_controller == null && !_hasError) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // ❌ إزالة AppBar
          body: _buildLoadingScreen(),
        ),
      );
    }

    if (_controller == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // ❌ إزالة AppBar
          body: Container(
            color: Color(0xFFF5F9FF),
            child: Column(
              children: [
                _buildCustomHeader(),
                Expanded(
                  child: Center(
                    child: Text(
                      'خطأ في تحميل الفيديو',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.red,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: YoutubePlayerBuilder(
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
            progressIndicatorColor: Color(0xFF1E88E5),
            progressColors: ProgressBarColors(
              playedColor: Color(0xFF1E88E5),
              handleColor: Color(0xFF1E88E5),
              backgroundColor: Colors.grey[300]!,
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
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              RemainingDuration(),
              _buildCustomPlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
          builder: (context, player) {
            return Scaffold(
              backgroundColor: Color(0xFFF5F9FF),
              // ❌ إزالة AppBar
              body: Column(
                children: [
                  // الرأس المخصص
                  _buildCustomHeader(),

                  // مشغل الفيديو والتحكم
                  Expanded(
                    child: Column(
                      children: [
                        // الجزء العلوي: مشغل الفيديو
                        Expanded(
                          flex: 3, // 60% من المساحة
                          child: Container(
                            margin: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20.w,
                                  offset: Offset(0, 8.h),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.w),
                              child: player,
                            ),
                          ),
                        ),

                        // الجزء السفلي: عناصر التحكم
                        Expanded(
                          flex: 2, // 40% من المساحة
                          child: _buildVideoControls(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposing = true;
    _stopVideoBeforeExit();

    Future.delayed(Duration(milliseconds: 50)).then((_) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.dispose();
  }
}
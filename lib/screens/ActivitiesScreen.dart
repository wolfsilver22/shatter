import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> with TickerProviderStateMixin {
  // ألوان التطبيق التعليمي
  final Color primaryColor = const Color(0xFF1E88E5); // الأزرق الأساسي
  final Color secondaryColor = const Color(0xFFF5F9FF); // الخلفية الفاتحة
  final Color accentColor = const Color(0xFFFFA726); // البرتقالي
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);

  // متحكمات الحركة
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  // بيانات النشاطات
  final List<Map<String, dynamic>> _activities = [
    {
      'id': 1,
      'title': 'تعلم الحروف العربية',
      'category': 'الحروف',
      'icon': Icons.abc,
      'color': Color(0xFF4CAF50),
      'description': 'أنشطة تفاعلية لتعلم الحروف العربية ونطقها',
      'level': 'مبتدئ',
      'duration': '15 دقيقة',
      'is_completed': false,
    },
    {
      'id': 2,
      'title': 'تعلم الحروف الإنجليزية',
      'category': 'الحروف',
      'icon': Icons.language,
      'color': Color(0xFF2196F3),
      'description': 'تعلم الحروف الإنجليزية مع الصوت والصور',
      'level': 'مبتدئ',
      'duration': '20 دقيقة',
      'is_completed': true,
    },
    {
      'id': 3,
      'title': 'تعلم الأرقام العربية',
      'category': 'الأرقام',
      'icon': Icons.numbers,
      'color': Color(0xFF9C27B0),
      'description': 'أنشطة ممتعة لتعلم الأرقام والعد',
      'level': 'مبتدئ',
      'duration': '10 دقيقة',
      'is_completed': false,
    },
    {
      'id': 4,
      'title': 'تعلم الأرقام الإنجليزية',
      'category': 'الأرقام',
      'icon': Icons.format_list_numbered,
      'color': Color(0xFFFF9800),
      'description': 'تعلم الأرقام الإنجليزية من 1 إلى 100',
      'level': 'مبتدئ',
      'duration': '15 دقيقة',
      'is_completed': false,
    },
    {
      'id': 5,
      'title': 'ألعاب الذكاء',
      'category': 'الذكاء',
      'icon': Icons.psychology,
      'color': Color(0xFFE91E63),
      'description': 'ألعاب ذكاء لتنمية المهارات العقلية',
      'level': 'متوسط',
      'duration': '25 دقيقة',
      'is_completed': false,
    },
    {
      'id': 6,
      'title': 'قصص تفاعلية',
      'category': 'القراءة',
      'icon': Icons.menu_book,
      'color': Color(0xFF795548),
      'description': 'قصص تعليمية تفاعلية مع أسئلة فهم',
      'level': 'متوسط',
      'duration': '30 دقيقة',
      'is_completed': true,
    },
    {
      'id': 7,
      'title': 'أنشطة الرسم',
      'category': 'الإبداع',
      'icon': Icons.brush,
      'color': Color(0xFFFF5722),
      'description': 'تعلم الرسم والتلوين مع الحروف والأرقام',
      'level': 'مبتدئ',
      'duration': '20 دقيقة',
      'is_completed': false,
    },
    {
      'id': 8,
      'title': 'تحديات النطق',
      'category': 'النطق',
      'icon': Icons.record_voice_over,
      'color': Color(0xFF009688),
      'description': 'تمارين نطق وتحسين مخارج الحروف',
      'level': 'متقدم',
      'duration': '15 دقيقة',
      'is_completed': false,
    },
  ];

  // الفئات المتاحة
  final List<String> _categories = ['الكل', 'الحروف', 'الأرقام', 'الذكاء', 'القراءة', 'الإبداع', 'النطق'];
  String _selectedCategory = 'الكل';

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    // تهيئة متحكمات الحركة
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // تعريف الحركات
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
    );

    // بدء الحركات
    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _scaleController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // تصفية النشاطات حسب الفئة
  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedCategory == 'الكل') {
      return _activities;
    }
    return _activities.where((activity) => activity['category'] == _selectedCategory).toList();
  }

  void _startActivity(Map<String, dynamic> activity) {
    // هنا يمكنك إضافة التنقل لشاشة النشاط التفاعلي
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('بدء النشاط: ${activity['title']}'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleCompletion(int activityId) {
    setState(() {
      final index = _activities.indexWhere((activity) => activity['id'] == activityId);
      if (index != -1) {
        _activities[index]['is_completed'] = !_activities[index]['is_completed'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: secondaryColor,
        // appBar: _buildAppBar(),
        body: AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildMainBanner(),
                        _buildCategoriesSection(),
                        _buildActivitiesSection(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainBanner() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ),
      ),
      child: Container(
        height: 160.h,
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [primaryColor, primaryColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 15.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // خلفية متدرجة
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.9),
                    primaryColor.withOpacity(0.7)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),

            // المحتوى
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'النشاطات التفاعلية',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'أنشطة ممتعة لتطوير مهاراتك خارج المنهج',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Tajawal',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${_activities.where((a) => a['is_completed']).length}/${_activities.length} مكتمل',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                      size: 35.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الفئات',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: category == _categories.first ? 0 : 8.w,
                      end: category == _categories.last ? 0 : 8.w,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() => _selectedCategory = category);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : textPrimary,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'النشاطات المتاحة',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${_filteredActivities.length} نشاط',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildActivitiesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesList() {
    if (_filteredActivities.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 60.sp,
              color: textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'لا توجد نشاطات في هذه الفئة',
              style: TextStyle(
                fontSize: 16.sp,
                color: textSecondary,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = _filteredActivities[index];
        return _buildActivityCard(activity, index);
      },
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, int index) {
    final bool isCompleted = activity['is_completed'] ?? false;

    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _fadeController.value)),
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Card(
            elevation: 4.w,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: InkWell(
              onTap: () => _startActivity(activity),
              borderRadius: BorderRadius.circular(16.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: cardColor,
                ),
                child: Stack(
                  children: [
                    // شارة الإكمال
                    if (isCompleted)
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),

                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          // الأيقونة
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: activity['color'].withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              activity['icon'],
                              color: activity['color'],
                              size: 28.sp,
                            ),
                          ),

                          SizedBox(width: 16.w),

                          // المعلومات
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        activity['title'],
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: textPrimary,
                                          fontFamily: 'Tajawal',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: _getLevelColor(activity['level']).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Text(
                                        activity['level'],
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: _getLevelColor(activity['level']),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  activity['description'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: textSecondary,
                                    fontFamily: 'Tajawal',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 8.h),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 14.sp,
                                      color: textSecondary,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      activity['duration'],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: textSecondary,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Icon(
                                      Icons.category,
                                      size: 14.sp,
                                      color: textSecondary,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      activity['category'],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: textSecondary,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // زر البدء
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => _startActivity(activity),
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: primaryColor,
                                  size: 24.sp,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: primaryColor.withOpacity(0.1),
                                  padding: EdgeInsets.all(8.w),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              GestureDetector(
                                onTap: () => _toggleCompletion(activity['id']),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: isCompleted ? Colors.green : Colors.grey,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ الحصول على لون المستوى
  Color _getLevelColor(String level) {
    switch (level) {
      case 'مبتدئ':
        return Colors.green;
      case 'متوسط':
        return Colors.orange;
      case 'متقدم':
        return Colors.red;
      default:
        return primaryColor;
    }
  }

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: primaryColor,
  //     foregroundColor: Colors.white,
  //     elevation: 0,
  //     centerTitle: true,
  //     title: Text(
  //       'النشاطات التفاعلية',
  //       style: TextStyle(
  //         fontSize: 20.sp,
  //         fontWeight: FontWeight.bold,
  //         fontFamily: 'Tajawal',
  //       ),
  //     ),
  //
  //   );
  // }
}
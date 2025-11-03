import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> with TickerProviderStateMixin {
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

  // بيانات المواد الدراسية
  final List<Map<String, dynamic>> _subjects = [
    {
      'id': 1,
      'title': 'الرياضيات',
      'icon': Icons.calculate,
      'color': Color(0xFF4CAF50),
      'description': 'تمارين وحلول في الرياضيات',
      'exercise_count': 15,
      'question_count': 45,
    },
    {
      'id': 2,
      'title': 'اللغة العربية',
      'icon': Icons.menu_book,
      'color': Color(0xFF2196F3),
      'description': 'تمارين في النحو والصرف',
      'exercise_count': 12,
      'question_count': 38,
    },
    {
      'id': 3,
      'title': 'العلوم',
      'icon': Icons.science,
      'color': Color(0xFF9C27B0),
      'description': 'تجارب وتمارين علمية',
      'exercise_count': 10,
      'question_count': 30,
    },
    {
      'id': 4,
      'title': 'اللغة الإنجليزية',
      'icon': Icons.language,
      'color': Color(0xFFFF9800),
      'description': 'تمارين في القواعد والمفردات',
      'exercise_count': 8,
      'question_count': 25,
    },
    {
      'id': 5,
      'title': 'التاريخ',
      'icon': Icons.history,
      'color': Color(0xFFE91E63),
      'description': 'أسئلة وتمارين تاريخية',
      'exercise_count': 6,
      'question_count': 20,
    },
    {
      'id': 6,
      'title': 'الجغرافيا',
      'icon': Icons.public,
      'color': Color(0xFF795548),
      'description': 'تمارين في الخرائط والمعالم',
      'exercise_count': 7,
      'question_count': 22,
    },
  ];

  // بيانات التمارين لكل مادة
  final Map<String, List<Map<String, dynamic>>> _exercisesData = {
    'الرياضيات': [
      {
        'id': 1,
        'title': 'تمرين الجمع والطرح',
        'description': 'تمارين أساسية في الجمع والطرح للأعداد الصحيحة',
        'difficulty': 'سهل',
        'duration': '15 دقيقة',
        'questions_count': 10,
        'solutions_available': true,
        'completed': true,
      },
      {
        'id': 2,
        'title': 'تمرين الضرب والقسمة',
        'description': 'تمارين متقدمة في الضرب والقسمة',
        'difficulty': 'متوسط',
        'duration': '20 دقيقة',
        'questions_count': 12,
        'solutions_available': true,
        'completed': false,
      },
      {
        'id': 3,
        'title': 'مسائل الكسور',
        'description': 'تمارين شاملة في الكسور والعمليات عليها',
        'difficulty': 'صعب',
        'duration': '25 دقيقة',
        'questions_count': 8,
        'solutions_available': true,
        'completed': false,
      },
    ],
    'اللغة العربية': [
      {
        'id': 1,
        'title': 'تمرين الإعراب',
        'description': 'تمارين في إعراب الجمل والكلمات',
        'difficulty': 'متوسط',
        'duration': '18 دقيقة',
        'questions_count': 15,
        'solutions_available': true,
        'completed': true,
      },
      {
        'id': 2,
        'title': 'تمرين الصرف',
        'description': 'تمارين في تصريف الأفعال',
        'difficulty': 'سهل',
        'duration': '12 دقيقة',
        'questions_count': 10,
        'solutions_available': true,
        'completed': false,
      },
    ],
  };

  String _selectedView = 'exercises'; // 'exercises' أو 'questions'
  String? _selectedSubject;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
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

  void _selectSubject(String subject) {
    setState(() {
      _selectedSubject = subject;
    });
  }

  void _navigateToExerciseList(String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseListScreen(
          subject: subject,
          exercises: _exercisesData[subject] ?? [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: secondaryColor,
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
                        _buildToggleSection(),
                        if (_selectedSubject == null) _buildSubjectsSection(),
                        if (_selectedSubject != null) _buildExercisesSection(),
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
        height: 140.h,
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
                          'التمارين والأسئلة',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'تدرب على المواد الدراسية مع تمارين وحلول متكاملة',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Tajawal',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 30.w,
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

  Widget _buildToggleSection() {
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildToggleCard(
                'التمارين',
                Icons.assignment,
                _selectedView == 'exercises',
                    () => setState(() => _selectedView = 'exercises'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildToggleCard(
                'الأسئلة',
                Icons.quiz,
                _selectedView == 'questions',
                    () => setState(() => _selectedView = 'questions'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleCard(String title, IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : primaryColor,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsSection() {
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
            Text(
              'المواد الدراسية',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'اختر المادة لعرض التمارين المتاحة',
              style: TextStyle(
                fontSize: 14.sp,
                color: textSecondary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 16.h),
            _buildSubjectsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: _subjects.length,
      itemBuilder: (context, index) {
        final subject = _subjects[index];
        return _buildSubjectCard(subject);
      },
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
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
        child: Card(
          elevation: 4.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: InkWell(
            onTap: () => _navigateToExerciseList(subject['title']),
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: cardColor,
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الأيقونة والعنوان
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: subject['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          subject['icon'],
                          color: subject['color'],
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          subject['title'],
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
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // الوصف
                  Text(
                    subject['description'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: textSecondary,
                      fontFamily: 'Tajawal',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Spacer(),

                  // الإحصائيات
                  Row(
                    children: [
                      _buildStatItem(
                        Icons.assignment,
                        '${subject['exercise_count']} تمارين',
                        primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      _buildStatItem(
                        Icons.quiz,
                        '${subject['question_count']} سؤال',
                        accentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 12.sp,
              color: color,
            ),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                color: color,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisesSection() {
    // سيتم استخدام هذا القسم عندما يتم اختيار مادة معينة
    return Container();
  }
}

// شاشة قائمة التمارين
class ExerciseListScreen extends StatefulWidget {
  final String subject;
  final List<Map<String, dynamic>> exercises;

  const ExerciseListScreen({
    Key? key,
    required this.subject,
    required this.exercises,
  }) : super(key: key);

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'تمارين ${widget.subject}',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              _buildExercisesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: primaryColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تمارين ${widget.subject}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${widget.exercises.length} تمرين متاح - ${widget.exercises.where((e) => e['completed']).length} مكتمل',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textSecondary,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    if (widget.exercises.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(
              Icons.assignment,
              size: 60.sp,
              color: textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'لا توجد تمارين متاحة لهذه المادة',
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];
          return _buildExerciseCard(exercise, index);
        },
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise, int index) {
    final bool isCompleted = exercise['completed'] ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Card(
        elevation: 4.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والمستوى
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            exercise['title'],
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(exercise['difficulty']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            exercise['difficulty'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: _getDifficultyColor(exercise['difficulty']),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // الوصف
                    Text(
                      exercise['description'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: textSecondary,
                        fontFamily: 'Tajawal',
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // المعلومات الإضافية
                    Row(
                      children: [
                        _buildExerciseInfoItem(
                          Icons.access_time,
                          exercise['duration'],
                        ),
                        SizedBox(width: 16.w),
                        _buildExerciseInfoItem(
                          Icons.quiz,
                          '${exercise['questions_count']} أسئلة',
                        ),
                        SizedBox(width: 16.w),
                        _buildExerciseInfoItem(
                          Icons.lightbulb,
                          exercise['solutions_available'] ? 'متوفر حلول' : 'لا يوجد حلول',
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // الأزرار
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // بدء التمرين
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: Text(
                              'بدء التمرين',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        IconButton(
                          onPressed: () {
                            // عرض الحلول
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: primaryColor.withOpacity(0.1),
                            padding: EdgeInsets.all(12.w),
                          ),
                          icon: Icon(
                            Icons.lightbulb_outline,
                            color: primaryColor,
                            size: 20.sp,
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
    );
  }

  Widget _buildExerciseInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: textSecondary,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: textSecondary,
            fontFamily: 'Tajawal',
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'سهل':
        return Colors.green;
      case 'متوسط':
        return Colors.orange;
      case 'صعب':
        return Colors.red;
      default:
        return primaryColor;
    }
  }
}
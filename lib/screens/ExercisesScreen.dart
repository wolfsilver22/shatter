import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> with TickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _mainExercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadMainExercises();
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

  Future<void> _loadMainExercises() async {
    try {
      final querySnapshot = await _firestore.collection('Exercises').get();
      setState(() {
        _mainExercises = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading exercises: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _navigateToSubExercises(DocumentSnapshot mainExercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubExercisesScreen(
          mainExercise: mainExercise,
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
                          'التمارين التعليمية',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'اختبر معرفتك وحسّن مهاراتك',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Tajawal',
                          ),
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

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: 16.h),
          Text(
            'جاري تحميل التمارين...',
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment,
            size: 80.sp,
            color: textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد تمارين متاحة حالياً',
            style: TextStyle(
              fontSize: 18.sp,
              color: textSecondary,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'سيتم إضافة تمارين جديدة قريباً',
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary.withOpacity(0.7),
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.1,
      ),
      itemCount: _mainExercises.length,
      itemBuilder: (context, index) {
        final exercise = _mainExercises[index];
        return _buildExerciseCard(exercise, index);
      },
    );
  }

  Widget _buildExerciseCard(DocumentSnapshot exercise, int index) {
    final data = exercise.data() as Map<String, dynamic>;
    final title = data['title'] ?? 'بدون عنوان';
    final description = data['description'] ?? 'لا يوجد وصف';
    final imageUrl = data['image_url'];
    final studentLevel = data['student_level'] ?? 'جميع المستويات';

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
          elevation: 6.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: InkWell(
            onTap: () => _navigateToSubExercises(exercise),
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: cardColor,
              ),
              child: Stack(
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.w),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.assignment,
                              color: primaryColor,
                              size: 40.sp,
                            ),
                          );
                        },
                      ),
                    ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Tajawal',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Tajawal',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.8),
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 8.h),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            studentLevel,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
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

                        SlideTransition(
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
                                  'التمارين المتاحة',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: textPrimary,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'اختر التمرين لبدء الاختبار',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: textSecondary,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                                SizedBox(height: 16.h),

                                if (_isLoading) _buildLoadingIndicator(),
                                if (!_isLoading && _mainExercises.isEmpty) _buildEmptyState(),
                                if (!_isLoading && _mainExercises.isNotEmpty) _buildExercisesGrid(),
                              ],
                            ),
                          ),
                        ),
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
}

// شاشة التمارين الفرعية
class SubExercisesScreen extends StatefulWidget {
  final DocumentSnapshot mainExercise;

  const SubExercisesScreen({
    Key? key,
    required this.mainExercise,
  }) : super(key: key);

  @override
  State<SubExercisesScreen> createState() => _SubExercisesScreenState();
}

class _SubExercisesScreenState extends State<SubExercisesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);

  List<DocumentSnapshot> _subExercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubExercises();
  }

  Future<void> _loadSubExercises() async {
    try {
      final mainExerciseId = widget.mainExercise.id;
      final querySnapshot = await _firestore
          .collection('Exercises')
          .doc(mainExerciseId)
          .collection('exercises')
          .orderBy('id')
          .get();

      setState(() {
        _subExercises = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading sub exercises: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToQuestions(String subExerciseId, String subExerciseTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsScreen(
          mainExercise: widget.mainExercise,
          subExerciseId: subExerciseId,
          subExerciseTitle: subExerciseTitle,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final data = widget.mainExercise.data() as Map<String, dynamic>;
    final title = data['title'] ?? 'بدون عنوان';
    final description = data['description'] ?? 'لا يوجد وصف';
    final imageUrl = data['image_url'];
    final studentLevel = data['student_level'] ?? 'جميع المستويات';

    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 150.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150.h,
                    color: primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.assignment,
                      color: primaryColor,
                      size: 50.sp,
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        studentLevel,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.assignment,
                      color: primaryColor,
                      size: 24.sp,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    fontFamily: 'Tajawal',
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textSecondary,
                    fontFamily: 'Tajawal',
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubExerciseCard(DocumentSnapshot subExercise, int index) {
    final data = subExercise.data() as Map<String, dynamic>;
    final id = data['id'] ?? '';
    final imageUrl = data['image_url'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Card(
        elevation: 4.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: InkWell(
          onTap: () => _navigateToQuestions(subExercise.id, 'تمرين ${index + 1}'),
          borderRadius: BorderRadius.circular(16.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: cardColor,
            ),
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  margin: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: primaryColor.withOpacity(0.1),
                  ),
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.assignment,
                          color: primaryColor,
                          size: 30.sp,
                        );
                      },
                    ),
                  )
                      : Icon(
                    Icons.assignment,
                    color: primaryColor,
                    size: 30.sp,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تمرين ${index + 1}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'اضغط لبدء حل الأسئلة',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: textSecondary,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Icon(
                    Icons.arrow_left,
                    color: primaryColor,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
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
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'التمارين الفرعية',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
        body: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            Text(
              'التمارين المتاحة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textPrimary,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 8.h),
            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              )
            else if (_subExercises.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment,
                        size: 60.sp,
                        color: textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'لا توجد تمارين فرعية متاحة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: textSecondary,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _subExercises.length,
                  itemBuilder: (context, index) {
                    return _buildSubExerciseCard(_subExercises[index], index);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// شاشة الأسئلة
class QuestionsScreen extends StatefulWidget {
  final DocumentSnapshot mainExercise;
  final String subExerciseId;
  final String subExerciseTitle;

  const QuestionsScreen({
    Key? key,
    required this.mainExercise,
    required this.subExerciseId,
    required this.subExerciseTitle,
  }) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);

  List<DocumentSnapshot> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final mainExerciseId = widget.mainExercise.id;
      final querySnapshot = await _firestore
          .collection('Exercises')
          .doc(mainExerciseId)
          .collection('exercises')
          .doc(widget.subExerciseId)
          .collection('questions')
          .orderBy('id')
          .get();

      setState(() {
        _questions = querySnapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading questions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildQuestionCard(DocumentSnapshot question, int index) {
    final data = question.data() as Map<String, dynamic>;
    final id = data['id'] ?? '';
    final imageUrl = data['image_url'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'سؤال ${index + 1}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: secondaryColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: secondaryColor,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: textSecondary,
                                  size: 40.sp,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'اكتب إجابتك هنا...',
                          hintStyle: TextStyle(
                            color: textSecondary,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: textPrimary,
                          fontFamily: 'Tajawal',
                        ),
                      ),
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
            widget.subExerciseTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
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
                    Icons.quiz,
                    color: primaryColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'أسئلة ${widget.subExerciseTitle}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${_questions.length} سؤال',
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
            ),

            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              )
            else if (_questions.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.quiz,
                        size: 60.sp,
                        color: textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'لا توجد أسئلة متاحة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: textSecondary,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return _buildQuestionCard(_questions[index], index);
                  },
                ),
              ),

            if (_questions.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.w),
                child: ElevatedButton(
                  onPressed: () {
                    // إرسال الإجابات
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  ),
                  child: Text(
                    'إرسال الإجابات',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
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
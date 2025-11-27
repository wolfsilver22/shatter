import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

import '../secrets.dart';

class HomeworkSolverScreen extends StatefulWidget {
  const HomeworkSolverScreen({Key? key}) : super(key: key);

  @override
  State<HomeworkSolverScreen> createState() => _HomeworkSolverScreenState();
}

class _HomeworkSolverScreenState extends State<HomeworkSolverScreen>
    with TickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF1E88E5);
  final Color secondaryColor = const Color(0xFFF5F9FF);
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF2D3748);
  final Color textSecondary = const Color(0xFF718096);
  final Color successColor = const Color(0xFF4CAF50);
  final Color warningColor = const Color(0xFFFF9800);

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isProcessing = false;
  bool _hasSolution = false;
  List<QuestionSolution> _solutions = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOutQuint),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
      _scaleController.forward();
      _slideController.forward();
    });
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutions.clear();
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في التقاط الصورة: $e';
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasSolution = false;
          _solutions.clear();
          _errorMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في اختيار الصورة: $e';
      });
    }
  }

  Future<void> _solveHomework() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = '';
    });

    try {
      final solutionText = await GeminiService.solveHomework(_selectedImage!);
      _parseSolutions(solutionText);

      setState(() {
        _isProcessing = false;
        _hasSolution = true;
      });

    } catch (e) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'خطأ في معالجة الواجب: $e';
      });
    }
  }

  void _parseSolutions(String responseText) {
    final List<QuestionSolution> solutions = [];

    print("الرد الخام من Gemini: $responseText");

    try {
      // طريقة محسنة جداً لتحليل الرد
      solutions.addAll(_parseWithEnhancedMethod(responseText));

      // إذا لم نجد حلول، نجرب الطرق البديلة
      if (solutions.isEmpty) {
        solutions.addAll(_parseWithSectionMethod(responseText));
      }

      // إذا استمر عدم وجود حلول، نستخدم الرد كاملاً
      if (solutions.isEmpty) {
        solutions.add(QuestionSolution(
          question: 'تحليل الواجب',
          solution: responseText,
          explanation: 'تم تحليل محتوى الواجب بنجاح',
        ));
      }

    } catch (e) {
      print('خطأ في التحليل: $e');
      solutions.add(QuestionSolution(
        question: 'حل الواجب',
        solution: responseText,
        explanation: 'تم معالجة الواجب بنجاح',
      ));
    }

    setState(() => _solutions = solutions);
  }

  List<QuestionSolution> _parseWithEnhancedMethod(String text) {
    final List<QuestionSolution> solutions = [];

    // regex محسن للتعرف على التنسيق المنظم
    final pattern = RegExp(
      r'(?:سؤال|Question)[\s:\-]*([^\n]*)(?:\n\s*)?(?:الحل|Solution)[\s:\-]*([\s\S]*?)(?=(?:\n\s*)?(?:شرح|Explanation)[\s:\-]*([\s\S]*?)(?=(?:\n\s*)?(?:سؤال|Question|$))|(?:\n\s*)?(?:سؤال|Question|$))',
      caseSensitive: false,
    );

    final matches = pattern.allMatches(text);

    for (final match in matches) {
      if (match.groupCount >= 1) {
        String question = match.group(1)?.trim() ?? 'سؤال';
        String solution = match.group(2)?.trim() ?? '';
        String explanation = match.group(3)?.trim() ?? '';

        // تنظيف النصوص
        question = _cleanText(question, ['سؤال', 'Question', ':']);
        solution = _cleanText(solution, ['الحل', 'Solution', ':']);
        explanation = _cleanText(explanation, ['شرح', 'Explanation', ':']);

        if (question.isNotEmpty || solution.isNotEmpty) {
          solutions.add(QuestionSolution(
            question: question.isNotEmpty ? question : 'سؤال ${solutions.length + 1}',
            solution: solution,
            explanation: explanation,
          ));
        }
      }
    }

    return solutions;
  }

  List<QuestionSolution> _parseWithSectionMethod(String text) {
    final List<QuestionSolution> solutions = [];

    // تقسيم النص إلى أقسام بناءً على العناوين الرئيسية
    final sections = text.split(RegExp(r'\n\s*\n'));
    int questionCount = 0;

    for (final section in sections) {
      if (section.trim().isEmpty) continue;

      final lines = section.split('\n');
      String currentQuestion = '';
      String currentSolution = '';
      String currentExplanation = '';
      String currentSection = 'question';

      for (final line in lines) {
        final trimmedLine = line.trim();
        if (trimmedLine.isEmpty) continue;

        // اكتشاف نوع المحتوى
        if (trimmedLine.contains(RegExp(r'^(سؤال|Question|السؤال|Problem|المسألة)'))) {
          currentSection = 'question';
          if (currentQuestion.isNotEmpty && (currentSolution.isNotEmpty || currentExplanation.isNotEmpty)) {
            solutions.add(QuestionSolution(
              question: _cleanText(currentQuestion, ['سؤال', 'Question']),
              solution: currentSolution,
              explanation: currentExplanation,
            ));
            currentQuestion = '';
            currentSolution = '';
            currentExplanation = '';
          }
          currentQuestion = trimmedLine;
        }
        else if (trimmedLine.contains(RegExp(r'^(الحل|Solution|الإجابة|Answer)'))) {
          currentSection = 'solution';
        }
        else if (trimmedLine.contains(RegExp(r'^(شرح|Explanation|توضيح|ملاحظة)'))) {
          currentSection = 'explanation';
        }
        else {
          // إضافة المحتوى للقسم الحالي
          switch (currentSection) {
            case 'question':
              if (currentQuestion.isEmpty) {
                currentQuestion = trimmedLine;
              } else {
                currentQuestion += '\n$trimmedLine';
              }
              break;
            case 'solution':
              currentSolution += '$trimmedLine\n';
              break;
            case 'explanation':
              currentExplanation += '$trimmedLine\n';
              break;
          }
        }
      }

      // إضافة القسم الأخير
      if (currentQuestion.isNotEmpty) {
        solutions.add(QuestionSolution(
          question: _cleanText(currentQuestion, ['سؤال', 'Question']),
          solution: currentSolution.trim(),
          explanation: currentExplanation.trim(),
        ));
      } else if (section.trim().isNotEmpty) {
        // إذا لم يكن هناك سؤال واضح، نعتبر النص كله حلاً
        questionCount++;
        solutions.add(QuestionSolution(
          question: 'سؤال $questionCount',
          solution: section.trim(),
          explanation: 'تم تحليل السؤال وإيجاد الحل المناسب',
        ));
      }
    }

    return solutions;
  }

  String _cleanText(String text, List<String> prefixes) {
    String cleaned = text;
    for (final prefix in prefixes) {
      cleaned = cleaned.replaceAll(RegExp('^$prefix[\\s:\\-]*', caseSensitive: false), '');
    }
    return cleaned.trim();
  }

  void _clearAll() {
    setState(() {
      _selectedImage = null;
      _hasSolution = false;
      _solutions.clear();
      _errorMessage = '';
    });
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 15.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 40.w,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'حل الواجبات بالذكاء الاصطناعي',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  fontFamily: 'Tajawal',
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'التقط صورة للواجب واحصل على الحل فوراً\nباستخدام أحدث تقنيات الذكاء الاصطناعي',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: textSecondary,
                  fontFamily: 'Tajawal',
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20.r,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.shade100,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: primaryColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'صورة الواجب',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        if (_selectedImage != null)
                          InkWell(
                            onTap: _clearAll,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16.w,
                                color: textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    if (_selectedImage == null)
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          color: secondaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 32.w,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'لم يتم اختيار صورة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                'قم باختيار صورة الواجب من الكاميرا أو المعرض لبدء التحليل',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: textSecondary.withOpacity(0.7),
                                  fontFamily: 'Tajawal',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 260.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.file(
                                _selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.grey.shade400,
                                      size: 50.w,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8.w,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'صورة الواجب',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(14.r),
                            child: InkWell(
                              onTap: _captureImage,
                              borderRadius: BorderRadius.circular(14.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 16.w,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 18.w,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'التقط صورة',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _pickImageFromGallery,
                              borderRadius: BorderRadius.circular(14.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo_library,
                                      size: 18.w,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'المعرض',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontFamily: 'Tajawal',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _selectedImage == null
            ? Container()
            : _isProcessing
            ? ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15.r,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 22.w,
                      height: 22.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'جاري حل الواجب...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: textPrimary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'قد تستغرق العملية بضع ثوانٍ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: textSecondary,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        )
            : Material(
          color: _hasSolution ? successColor : primaryColor,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: _solveHomework,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: (_hasSolution ? successColor : primaryColor).withOpacity(0.3),
                    blurRadius: 15.r,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _hasSolution ? Icons.check_circle : Icons.auto_awesome,
                    size: 22.w,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    _hasSolution ? 'تم حل الواجب بنجاح' : 'حل الواجب بالذكاء الاصطناعي',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal',
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

  Widget _buildSolutions() {
    if (!_hasSolution) return Container();

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: successColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.assignment_turned_in,
                        color: successColor,
                        size: 22.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'حلول الواجب',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${_solutions.length}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              if (_solutions.isEmpty)
                _buildNoSolutionsFound()
              else
                ..._solutions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final solution = entry.value;
                  return _buildSolutionCard(solution, index);
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoSolutionsFound() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 50.w,
            color: textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'لم يتم العثور على أسئلة منظمة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'قد تحتوي الصورة على نص غير منظم أو قد تحتاج إلى تحسين جودة الصورة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: textSecondary,
              fontFamily: 'Tajawal',

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard(QuestionSolution solution, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          leading: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
          title: Text(
            solution.question.isNotEmpty ? solution.question : 'سؤال ${index + 1}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontFamily: 'Tajawal',
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عرض الحل
                  if (solution.solution.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: primaryColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الحل:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            solution.solution,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textPrimary,
                              fontFamily: 'Tajawal',
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.orange[100]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.orange[600], size: 18.w),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'لا يوجد حل مفصل متوفر',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.orange[700],
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // عرض الشرح
                  if (solution.explanation.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: successColor,
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الشرح:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: successColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: successColor.withOpacity(0.1),
                            ),
                          ),
                          child: Text(
                            solution.explanation,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textSecondary,
                              fontFamily: 'Tajawal',
                              height: 1.6,
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
    );
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isEmpty) return Container();

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: Colors.red[700],
                size: 18.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حدث خطأ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red[600],
                      fontFamily: 'Tajawal',
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

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildHeader(),
                      _buildImageSection(),
                      _buildActionButton(),
                      _buildErrorMessage(),
                      _buildSolutions(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuestionSolution {
  final String question;
  final String solution;
  final String explanation;

  QuestionSolution({
    required this.question,
    required this.solution,
    required this.explanation,
  });
}

class GeminiService {
  static const apiKey = Secrets.googleApiKey;

  static Future<String> solveHomework(File image) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
      );

      final bytes = await image.readAsBytes();

      final content = [
        Content.multi([
          TextPart("""
أنت مساعد تعليمي متخصص في حل الواجبات المدرسية. قم بتحليل الصورة التي تحتوي على واجب منزلي وأجب عن الأسئلة بطريقة تعليمية واضحة.

التعليمات المهمة:
1. حلل كل سؤال على حدة
2. قدم الحلول خطوة بخطوة
3. اشرح المفاهيم الأساسية
4. تأكد من دقة الحلول الرياضية
5. استخدم أسلوباً تعليمياً واضحاً
6. رتب الإجابات حسب ترتيب الأسئلة
7. استخدم اللغة العربية الفصحى
8. اذكر الخطوات التفصيلية لكل حل

أعد الإجابة باستخدام هذا التنسيق بالضبط لكل سؤال:

سؤال: [نص السؤال هنا]
الحل: [الحل التفصيلي خطوة بخطوة هنا]
شرح: [الشرح والتوضيح هنا]

إذا كان هناك أكثر من سؤال، كرر هذا التنسيق لكل سؤال.
          """),
          DataPart('image/jpeg', bytes),
        ])
      ];

      final response = await model.generateContent(
        content,
        generationConfig: GenerationConfig(
          temperature: 0.3,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 4096,
        ),
      );

      if (response.text != null) {
        return response.text!;
      } else {
        throw Exception('لم يتم إرجاع أي رد من النموذج');
      }
    } catch (e) {
      if (e is GenerativeAIException) {
        throw Exception('خطأ في الذكاء الاصطناعي: ${e.message}');
      } else {
        throw Exception('خطأ في الاتصال: $e');
      }
    }
  }
}


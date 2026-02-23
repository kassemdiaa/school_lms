import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_lms/core/colors/colors_manger.dart';
import 'package:school_lms/features/layout/home/cource_item.dart';
import 'package:school_lms/models/cource_model.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'package:school_lms/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<CourceModel> _allCources = [];
  List<CourceModel> _filtered   = [];
  String _username = '';

  static const _kUsername = 'logged_username';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearch);
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _username = prefs.getString(_kUsername) ?? '';
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allCources = CourceModel.getCources(context);
    _filtered   = _allCources;
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearch);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      _filtered = query.isEmpty
          ? _allCources
          : _allCources
              .where((c) =>
                  c.name.toLowerCase().contains(query) ||
                  c.instractorName.toLowerCase().contains(query))
              .toList();
    });
  }

  void _toggleLocale() {
    final isAr = appLocale.value.languageCode == 'ar';
    appLocale.value = isAr ? const Locale('en') : const Locale('ar');
    saveLocale(appLocale.value.languageCode);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {
        _allCources = CourceModel.getCources(context);
        _onSearch();
      });
    });
  }

  void _toggleTheme() {
    final isDark = appTheme.value == ThemeMode.dark;
    appTheme.value = isDark ? ThemeMode.light : ThemeMode.dark;
    saveTheme(appTheme.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n   = AppLocalizations.of(context)!;
    final isAr   = appLocale.value.languageCode == 'ar';
    final isDark = appTheme.value == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                '${l10n.welcome}, ',
                style: GoogleFonts.plusJakartaSans(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // ── Show the typed username ────────────────────────────────
              Flexible(
                child: Text(
                  _username.isEmpty ? 'User' : _username,
                  style: GoogleFonts.plusJakartaSans(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            // ── Globe: language toggle ─────────────────────────────────────
            InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: _toggleLocale,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(CupertinoIcons.globe,
                        color: ColorsManger.gray, size: 26.sp),
                    Positioned(
                      top: -4,
                      right: -6,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: ColorsManger.blue,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          isAr ? 'AR' : 'EN',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 4.w),

            // ── Sun / Moon: theme toggle ───────────────────────────────────
            InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: _toggleTheme,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => RotationTransition(
                    turns: anim,
                    child: FadeTransition(opacity: anim, child: child),
                  ),
                  child: Icon(
                    isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                    key: ValueKey(isDark),
                    color: isDark ? Colors.amber : ColorsManger.gray,
                    size: 26.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              children: [
                // ── Search bar ────────────────────────────────────────────
                TextField(
                  controller: _searchCtrl,
                  cursorColor: const Color.fromARGB(255, 122, 122, 122),
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search,
                        color: ColorsManger.gray, size: 26.sp),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.close,
                                color: ColorsManger.gray, size: 20.sp),
                            onPressed: () {
                              _searchCtrl.clear();
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null,
                    hintText: l10n.search,
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: const Color.fromARGB(255, 198, 198, 198),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).hoverColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 7.w, vertical: 10.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 198, 198, 198),
                          width: 1.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 122, 122, 122),
                          width: 1.w),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),

                // ── Section header ────────────────────────────────────────
                Row(
                  children: [
                    Text(
                      _searchCtrl.text.isEmpty
                          ? l10n.cources
                          : '${_filtered.length} result${_filtered.length == 1 ? '' : 's'}',
                      style: GoogleFonts.plusJakartaSans(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // ── Grid or empty state ───────────────────────────────────
                _filtered.isEmpty
                    ? _EmptyState(query: _searchCtrl.text)
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 11.w,
                          mainAxisSpacing: 5.h,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) => CourceItem(
                          cource: _filtered[index],
                          onReturn: () => setState(() {
                            _allCources = CourceModel.getCources(context);
                            _onSearch();
                          }),
                        ),
                        itemCount: _filtered.length,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.search,
              size: 54.sp,
              color: const Color.fromARGB(255, 198, 198, 198)),
          SizedBox(height: 16.h),
          Text(
            'No courses found for\n"$query"',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: const Color.fromARGB(255, 160, 160, 160),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

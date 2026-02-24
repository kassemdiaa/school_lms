import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:school_lms/features/layout/profile/edit_sheet.dart';
import 'package:school_lms/features/layout/profile/skill_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'package:school_lms/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String _name     = 'Name Here';
  String _tagLine  = 'Tag Line';
  String _about    = 'Lorem ipsum dolor sit amet consectetur.';
  List<String> _skills = ['UI/UX', 'Graphics Design', 'Figma', 'Video Editor'];
  String? _photoPath;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  static const _kName    = 'profile_name';
  static const _kTagLine = 'profile_tagline';
  static const _kAbout   = 'profile_about';
  static const _kSkills  = 'profile_skills';
  static const _kPhoto   = 'profile_photo';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _animCtrl, curve: Curves.easeOut));
    _loadProfile().then((_) => _animCtrl.forward());
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _name      = p.getString(kUsername) ?? p.getString(_kName) ?? _name;
      _tagLine   = p.getString(_kTagLine) ?? _tagLine;
      _about     = p.getString(_kAbout)   ?? _about;
      _skills    = p.getStringList(_kSkills) ?? _skills;
      _photoPath = p.getString(_kPhoto);
    });
  }

  Future<void> _saveProfile() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kName, _name);
    await p.setString(_kTagLine, _tagLine);
    await p.setString(_kAbout, _about);
    await p.setStringList(_kSkills, _skills);
    if (_photoPath != null) await p.setString(_kPhoto, _photoPath!);
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _photoPath = picked.path);
      _saveProfile();
    }
  }

  void _openEditSheet(BuildContext context) {
    final l10n      = AppLocalizations.of(context)!;
    final nameCtrl  = TextEditingController(text: _name);
    final tagCtrl   = TextEditingController(text: _tagLine);
    final aboutCtrl = TextEditingController(text: _about);
    final skillCtrl = TextEditingController(text: _skills.join(', '));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditSheet(
        l10n: l10n,
        nameCtrl: nameCtrl,
        tagCtrl: tagCtrl,
        aboutCtrl: aboutCtrl,
        skillCtrl: skillCtrl,
        onSave: () {
          setState(() {
            _name    = nameCtrl.text.trim().isEmpty ? _name : nameCtrl.text.trim();
            _tagLine = tagCtrl.text.trim().isEmpty  ? _tagLine : tagCtrl.text.trim();
            _about   = aboutCtrl.text.trim().isEmpty ? _about : aboutCtrl.text.trim();
            _skills  = skillCtrl.text
                .split(',')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();
          });
          _saveProfile();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.logout,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Text(l10n.areyousure,
            style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel,
                style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              elevation: 0,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await clearLogin();     
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesManger.loginOrRegister,
                  (_) => false,
                );
              }
            },
            child: Text(l10n.logout,
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(l10n.profile,
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              )),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 3.w),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 16.r,
                                offset: const Offset(0, 6))
                          ],
                        ),
                        child: ClipOval(
                          child: _photoPath != null
                              ? Image.file(File(_photoPath!),
                                  fit: BoxFit.cover)
                              : Container(
                                  color: const Color(0xFFD0D8F0),
                                  child: Icon(Icons.person,
                                      size: 48.sp,
                                      color: const Color(0xFF002F96))),
                        ),
                      ),
                      Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: const BoxDecoration(
                            color: Color(0xFF002F96),
                            shape: BoxShape.circle),
                        child: Icon(Icons.camera_alt_rounded,
                            color: Colors.white, size: 14.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20.r,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_name,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w800,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    )),
                                SizedBox(height: 2.h),
                                Text(_tagLine,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.sp,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _openEditSheet(context),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(Icons.edit_rounded,
                                  size: 16.sp,
                                  color: const Color(0xFF002F96)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(l10n.aboutme,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColorLight,
                          )),
                      SizedBox(height: 6.h),
                      Text(_about,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Colors.black54,
                            height: 1.6,
                          )),
                      SizedBox(height: 20.h),
                      Text(l10n.myskills,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColorLight,
                          )),
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _skills
                            .map((s) => SkillChip(label: s))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade400,
                      side: BorderSide(color: Colors.red.shade300),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(l10n.logout,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        )),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

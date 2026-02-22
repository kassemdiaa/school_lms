import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Entry point widget ───────────────────────────────────────────────────────
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // ── state ──────────────────────────────────────────────────────────────────
  String _name      = 'Name Here';
  String _tagLine   = 'Tag Line';
  String _about     = 'Lorem ipsum dolor sit amet consectetur. Nec eget accumsan molestie proin. Integer rhoncus vitae nisi natoque ac mus tellus scelerisque gravida.';
  List<String> _skills = ['UI/UX', 'Graphics Design', 'Figma', 'Video Editor'];
  String? _photoPath;

  late AnimationController _animCtrl;
  late Animation<double>    _fadeAnim;
  late Animation<Offset>    _slideAnim;

  static const _kName      = 'profile_name';
  static const _kTagLine   = 'profile_tagline';
  static const _kAbout     = 'profile_about';
  static const _kSkills    = 'profile_skills';
  static const _kPhoto     = 'profile_photo';

  // ── lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _loadProfile().then((_) => _animCtrl.forward());
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  // ── persistence ────────────────────────────────────────────────────────────
  Future<void> _loadProfile() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _name      = p.getString(_kName)    ?? _name;
      _tagLine   = p.getString(_kTagLine) ?? _tagLine;
      _about     = p.getString(_kAbout)   ?? _about;
      _skills    = p.getStringList(_kSkills) ?? _skills;
      _photoPath = p.getString(_kPhoto);
    });
  }

  Future<void> _saveProfile() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kName,    _name);
    await p.setString(_kTagLine, _tagLine);
    await p.setString(_kAbout,   _about);
    await p.setStringList(_kSkills, _skills);
    if (_photoPath != null) await p.setString(_kPhoto, _photoPath!);
  }

  // ── photo picker ───────────────────────────────────────────────────────────
  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _photoPath = picked.path);
      _saveProfile();
    }
  }

  // ── edit sheet ─────────────────────────────────────────────────────────────
  void _openEditSheet() {
    final nameCtrl  = TextEditingController(text: _name);
    final tagCtrl   = TextEditingController(text: _tagLine);
    final aboutCtrl = TextEditingController(text: _about);
    final skillCtrl = TextEditingController(text: _skills.join(', '));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditSheet(
        nameCtrl:  nameCtrl,
        tagCtrl:   tagCtrl,
        aboutCtrl: aboutCtrl,
        skillCtrl: skillCtrl,
        onSave: () {
          setState(() {
            _name     = nameCtrl.text.trim().isEmpty ? _name  : nameCtrl.text.trim();
            _tagLine  = tagCtrl.text.trim().isEmpty  ? _tagLine : tagCtrl.text.trim();
            _about    = aboutCtrl.text.trim().isEmpty ? _about : aboutCtrl.text.trim();
            _skills   = skillCtrl.text
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

  // ── build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F4F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                // ── avatar ──────────────────────────────────────────────────
                GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90.w,
                        height: 90.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: _photoPath != null
                              ? Image.file(File(_photoPath!),
                                  fit: BoxFit.cover)
                              : Image.asset('assets/default_avatar.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFFD0D8F0),
                                    child: Icon(Icons.person,
                                        size: 48.sp,
                                        color: const Color(0xFF002F96)),
                                  )),
                        ),
                      ),
                      Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF002F96),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt_rounded,
                            color: Colors.white, size: 14.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ── card ─────────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8ECF5),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name + edit icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _name,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  _tagLine,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.sp,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: _openEditSheet,
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

                      // about
                      _SectionLabel(label: 'About Me'),
                      SizedBox(height: 6.h),
                      Text(
                        _about,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.black54,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // skills
                      _SectionLabel(label: 'My Skills'),
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _skills
                            .map((s) => _SkillChip(label: s))
                            .toList(),
                      ),
                    ],
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

// ─── Section label ────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      );
}

// ─── Skill chip ───────────────────────────────────────────────────────────────
class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      );
}

// ─── Edit bottom sheet ────────────────────────────────────────────────────────
class _EditSheet extends StatelessWidget {
  const _EditSheet({
    required this.nameCtrl,
    required this.tagCtrl,
    required this.aboutCtrl,
    required this.skillCtrl,
    required this.onSave,
  });

  final TextEditingController nameCtrl;
  final TextEditingController tagCtrl;
  final TextEditingController aboutCtrl;
  final TextEditingController skillCtrl;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Edit Profile',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.h),
            _Field(ctrl: nameCtrl,  label: 'Name'),
            SizedBox(height: 14.h),
            _Field(ctrl: tagCtrl,   label: 'Tag Line'),
            SizedBox(height: 14.h),
            _Field(ctrl: aboutCtrl, label: 'About Me', maxLines: 4),
            SizedBox(height: 14.h),
            _Field(
              ctrl: skillCtrl,
              label: 'Skills (comma separated)',
              hint: 'e.g. Flutter, Dart, UI/UX',
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF002F96),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
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

// ─── Reusable text field ──────────────────────────────────────────────────────
class _Field extends StatelessWidget {
  const _Field({
    required this.ctrl,
    required this.label,
    this.maxLines = 1,
    this.hint,
  });
  final TextEditingController ctrl;
  final String label;
  final int maxLines;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp, color: Colors.black26),
            filled: true,
            fillColor: const Color(0xFFF2F4F8),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF002F96), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

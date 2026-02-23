import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    super.key,
    required this.pdfPath,
    required this.title,
  });

  final String pdfPath; // e.g. 'assets/docs/chapter1.pdf'
  final String title;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  int _currentPage = 1;
  int _totalPages  = 0;
  bool _isLoading  = true;

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Theme.of(context).primaryColorLight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.plusJakartaSans(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (_totalPages > 0)
              Text(
                'Page $_currentPage of $_totalPages',
                style: GoogleFonts.plusJakartaSans(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 10.sp,
                ),
              ),
          ],
        ),
        actions: [
          // Jump to first page
          IconButton(
            icon: Icon(Icons.first_page_rounded,
                color: Theme.of(context).canvasColor, size: 22.sp),
            tooltip: 'First page',
            onPressed: () => _pdfController.firstPage(),
          ),
          // Jump to last page
          IconButton(
            icon: Icon(Icons.last_page_rounded,
                color: Theme.of(context).canvasColor, size: 22.sp),
            tooltip: 'Last page',
            onPressed: () => _pdfController.lastPage(),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: Stack(
        children: [
          // ── PDF viewer ──────────────────────────────────────────────────
          SfPdfViewer.asset(
            widget.pdfPath,
            controller: _pdfController,
            onDocumentLoaded: (details) {
              setState(() {
                _totalPages = details.document.pages.count;
                _isLoading  = false;
              });
            },
            onPageChanged: (details) {
              setState(() => _currentPage = details.newPageNumber);
            },
            onDocumentLoadFailed: (details) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to load PDF: ${details.description}',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            pageLayoutMode: PdfPageLayoutMode.continuous,
            scrollDirection: PdfScrollDirection.vertical,
            enableDoubleTapZooming: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
          ),

          // ── Loading indicator ───────────────────────────────────────────
          if (_isLoading)
            Container(
              color: const Color(0xFFF2F4F8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading PDF...',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),

      // ── Bottom navigation bar ─────────────────────────────────────────────
      bottomNavigationBar: _totalPages > 0
          ? Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous page
                  _NavButton(
                    icon: Icons.chevron_left_rounded,

                    label: 'Prev',
                    onTap: _currentPage > 1
                        ? () => _pdfController.previousPage()
                        : null,
                  ),

                  // Page indicator
                  Text(
                    '$_currentPage / $_totalPages',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),

                  // Next page
                  _NavButton(
                    icon: Icons.chevron_right_rounded,
                    label: 'Next',
                    onTap: _currentPage < _totalPages
                        ? () => _pdfController.nextPage()
                        : null,
                    isRight: true,
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

// ─── Nav button ───────────────────────────────────────────────────────────────
class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isRight = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (!isRight)
            Icon(icon,
                color: Theme.of(context).primaryColorLight ,
                size: 20.sp),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          if (isRight)
            Icon(icon,
                color: Theme.of(context).primaryColorLight,
                size: 20.sp),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.videoPath,
    required this.title,
  });

  final String videoPath; // e.g. 'assets/videos/chapter1.mp4'
  final String title;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls  = true;
  bool _isFullscreen  = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.play();
      });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleControls() =>
      setState(() => _showControls = !_showControls);

  void _togglePlay() {
    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();
  }

  void _toggleFullscreen() {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── Video + controls ────────────────────────────────────────────
            GestureDetector(
              onTap: _toggleControls,
              child: AspectRatio(
                aspectRatio: _isInitialized
                    ? _controller.value.aspectRatio
                    : 16 / 9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Video
                    _isInitialized
                        ? VideoPlayer(_controller)
                        : const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFF002F96))),

                    // Controls overlay
                    AnimatedOpacity(
                      opacity: _showControls ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            // Top bar
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 10.h),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Centre play/pause
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Rewind 10s
                                IconButton(
                                  iconSize: 36.sp,
                                  icon: const Icon(Icons.replay_10,
                                      color: Colors.white),
                                  onPressed: () {
                                    final pos = _controller.value.position -
                                        const Duration(seconds: 10);
                                    _controller.seekTo(
                                        pos < Duration.zero ? Duration.zero : pos);
                                  },
                                ),
                                SizedBox(width: 16.w),
                                // Play / Pause
                                GestureDetector(
                                  onTap: _togglePlay,
                                  child: Container(
                                    width: 58.w,
                                    height: 58.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF002F96),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF002F96)
                                              .withOpacity(0.4),
                                          blurRadius: 16,
                                        )
                                      ],
                                    ),
                                    child: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 34.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                // Forward 10s
                                IconButton(
                                  iconSize: 36.sp,
                                  icon: const Icon(Icons.forward_10,
                                      color: Colors.white),
                                  onPressed: () {
                                    final pos = _controller.value.position +
                                        const Duration(seconds: 10);
                                    final dur = _controller.value.duration;
                                    _controller.seekTo(
                                        pos > dur ? dur : pos);
                                  },
                                ),
                              ],
                            ),
                            const Spacer(),

                            // Bottom: seek bar + time + fullscreen
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              child: Column(
                                children: [
                                  // Seek bar
                                  _isInitialized
                                      ? SliderTheme(
                                          data: SliderTheme.of(context)
                                              .copyWith(
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 6.r),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                    overlayRadius: 12.r),
                                            activeTrackColor:
                                                const Color(0xFF002F96),
                                            inactiveTrackColor:
                                                Colors.white24,
                                            thumbColor:
                                                const Color(0xFF002F96),
                                            trackHeight: 3,
                                          ),
                                          child: Slider(
                                            value: _controller
                                                .value.position.inSeconds
                                                .toDouble(),
                                            max: _controller
                                                .value.duration.inSeconds
                                                .toDouble()
                                                .clamp(1, double.infinity),
                                            onChanged: (v) => _controller
                                                .seekTo(Duration(
                                                    seconds: v.toInt())),
                                          ),
                                        )
                                      : const SizedBox(),

                                  // Time + fullscreen
                                  Row(
                                    children: [
                                      Text(
                                        '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white70,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          _isFullscreen
                                              ? Icons.fullscreen_exit
                                              : Icons.fullscreen,
                                          color: Colors.white,
                                        ),
                                        onPressed: _toggleFullscreen,
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
                  ],
                ),
              ),
            ),

            // ── Info panel (portrait only) ──────────────────────────────────
            if (!_isFullscreen)
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Tap the video to show / hide controls.\n'
                        'Use ⏪ ⏩ to skip 10 seconds.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.black45,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

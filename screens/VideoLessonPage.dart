import 'package:flutter/material.dart';
import 'package:hom/theme/Appcolors.dart';

class VideoLessonPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const VideoLessonPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  State<VideoLessonPage> createState() => _VideoLessonPageState();
}

class _VideoLessonPageState extends State<VideoLessonPage> {
  bool isPlaying = false;
  double currentProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final textColor = (widget.color == AppColors.beige ||
            widget.color == AppColors.lightBlue ||
            widget.color == AppColors.lightTeal ||
            widget.color == AppColors.mintGreen)
        ? AppColors.darkGray
        : AppColors.offWhite;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color,
                  widget.color.withOpacity(0.8),
                  AppColors.navyBlue,
                  AppColors.offWhite,
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.closed_caption_outlined,
                                color: textColor),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.settings, color: textColor),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Video player section
                Container(
                  height: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Video placeholder
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.black87,
                          child: Center(
                            child: Icon(
                              widget.icon,
                              size: 80,
                              color: widget.color.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),

                      // Play button
                      IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                          size: 70,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                      ),

                      // Video controls overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Progress bar
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: widget.color,
                                  inactiveTrackColor: Colors.white30,
                                  thumbColor: widget.color,
                                  overlayColor: widget.color.withOpacity(0.3),
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6,
                                  ),
                                  overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 12,
                                  ),
                                ),
                                child: Slider(
                                  value: currentProgress,
                                  onChanged: (value) {
                                    setState(() {
                                      currentProgress = value;
                                    });
                                  },
                                ),
                              ),

                              // Time and controls
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "0:00 / 45:00",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.replay_10,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.forward_10,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.fullscreen,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Lesson information
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.darkGray.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Resources section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Lesson Resources",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGray,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildResourceItem(
                              Icons.description,
                              "Lesson Notes",
                              "PDF - 2.5 MB",
                              widget.color,
                            ),
                            const SizedBox(height: 12),
                            _buildResourceItem(
                              Icons.assignment,
                              "Practice Exercises",
                              "PDF - 1.8 MB",
                              widget.color,
                            ),
                            const SizedBox(height: 12),
                            _buildResourceItem(
                              Icons.code,
                              "Code Examples",
                              "ZIP - 4.2 MB",
                              widget.color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
              label: const Text("Previous"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkGray,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next Lesson"),
              style: TextButton.styleFrom(
                foregroundColor: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.darkGray.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.download,
            color: color,
          ),
        ],
      ),
    );
  }
}

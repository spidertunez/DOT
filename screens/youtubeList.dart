import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlaylistScreen extends StatefulWidget {
  const YouTubePlaylistScreen({super.key});

  @override
  State<YouTubePlaylistScreen> createState() => _YouTubePlaylistScreenState();
}

class _YouTubePlaylistScreenState extends State<YouTubePlaylistScreen> {
  List<Map<String, dynamic>> videos = [];
  bool isLoading = true;

  final String apiKey = 'AIzaSyB_7td9OpQQ3am73kNrbt5HYdK49RCTQiY';
  final String playlistId = 'PLDoPjvoNmBAw_t_XWUFbBX-c9MafPk9ji';

  @override
  void initState() {
    super.initState();
    fetchPlaylistVideos();
  }

  Future<void> fetchPlaylistVideos() async {
    final playlistUrl = Uri.parse(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=20&playlistId=$playlistId&key=$apiKey');
    final playlistResponse = await http.get(playlistUrl);

    if (playlistResponse.statusCode == 200) {
      final playlistData = jsonDecode(playlistResponse.body);
      List items = playlistData['items'];

      List<String> videoIds = items
          .map((item) => item['snippet']['resourceId']['videoId'] as String)
          .toList();

      final videosUrl = Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?part=statistics,contentDetails&id=${videoIds.join(',')}&key=$apiKey');
      final videosResponse = await http.get(videosUrl);

      if (videosResponse.statusCode == 200) {
        final videosData = jsonDecode(videosResponse.body);

        setState(() {
          videos = List.generate(items.length, (index) {
            final snippet = items[index]['snippet'];
            final stats = videosData['items'][index]['statistics'];
            final contentDetails = videosData['items'][index]['contentDetails'];
            return {
              'title': snippet['title'],
              'publishedAt': snippet['publishedAt'],
              'thumbnailUrl': snippet['thumbnails']['high']['url'],
              'videoId': snippet['resourceId']['videoId'],
              'viewCount': stats['viewCount'] ?? '0',
              'duration': contentDetails['duration'] ?? 'PT0M0S',
            };
          });
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  String parseDuration(String duration) {
    final regex = RegExp(r'PT(\d+H)?(\d+M)?(\d+S)?');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = match.group(1)?.replaceAll('H', '') ?? '0';
      final minutes = match.group(2)?.replaceAll('M', '') ?? '0';
      final seconds = match.group(3)?.replaceAll('S', '') ?? '0';
      return '${hours.padLeft(2, '0')}:${minutes.padLeft(2, '0')}:${seconds.padLeft(2, '0')}';
    }
    return '00:00:00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Playlist')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return AnimatedContainer(
            duration: Duration(milliseconds: 500 + index * 50),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => YouTubeVideoPlayerScreen(videoId: video['videoId']),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.1),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(video['thumbnailUrl'], width: 100, fit: BoxFit.cover),
                  ),
                  title: Text(video['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Published: ${video['publishedAt'].substring(0, 10)}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        Text('Views: ${video['viewCount']} | Duration: ${parseDuration(video['duration'])}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class YouTubeVideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const YouTubeVideoPlayerScreen({super.key, required this.videoId});

  @override
  State<YouTubeVideoPlayerScreen> createState() => _YouTubeVideoPlayerScreenState();
}

class _YouTubeVideoPlayerScreenState extends State<YouTubeVideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}

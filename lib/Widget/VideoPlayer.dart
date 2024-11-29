import 'package:flutter/material.dart';
import 'package:scorers/Widget/Component.dart';
import 'package:url_launcher/url_launcher.dart';


class CustomYouTubePlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  // Constructor
  CustomYouTubePlayer({Key? key, required this.videoUrl,required this.thumbnailUrl}) : super(key: key);

  @override
  _CustomYouTubePlayerState createState() => _CustomYouTubePlayerState();
}

class _CustomYouTubePlayerState extends State<CustomYouTubePlayer> {




  Future<void> _openInBrowser() async {
    final Uri url = Uri.parse(widget.videoUrl);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)), // Apply borderRadius to the outer container
        image: DecorationImage(
          image: NetworkImage(widget.thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)), // Clip child to the same radius
        child: Container(
          color: Colors.black.withOpacity(0.6), // Black overlay with opacity
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
            children: [
              // Left widget (Barcelona)
              IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset("assets/Barce.png"),
                    ),
                    SizedBox(height: 5),
                    CustomWidget.CText("Barcelona", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

              // Play/Pause button
              SizedBox(width: 40), // Space between the two widgets
              IntrinsicHeight(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Set the button color
                    shape: CircleBorder(), // Make it circular
                    padding: EdgeInsets.all(20), // Adjust button size
                  ),
                  onPressed: () {
                    _openInBrowser();
                  },
                  child: Icon(
                    Icons.play_arrow,
                    color: Color(0xFF008F8F), // Icon color
                    size: 30, // Icon size
                  ),
                ),
              ),

              // Right widget (Real Madrid)
              SizedBox(width: 40), // Space between the two widgets
              IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset("assets/Rmadrid.png"),
                    ),
                    SizedBox(height: 5),
                    CustomWidget.CText("Real Madrid", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}

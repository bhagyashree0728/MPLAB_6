import 'package:flutter/material.dart';

class YoutubeTestimonialsPage extends StatelessWidget {
  // Removed `const` from the constructor as 'testimonials' is not constant
  YoutubeTestimonialsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> testimonials = [
    {
      'name': 'Solar System',
      'description': 'I loved learning with Blossom, Bubbles & Bytes! It was so much fun!',
      'videoUrl': 'https://youtu.be/Uj9w-uBuLgw', // replace with your actual video URL
      'thumbnail': 'https://tse2.mm.bing.net/th?id=OIP.HhTiuaQoalRMyAgjYet72AHaEK&pid=Api&P=0&h=180', // placeholder image
    },
    {
      'name': 'Jane Smith',
      'description': 'The interactive lessons and story-based learning kept me hooked! Awesome!',
      'videoUrl': 'https://youtu.be/Uj9w-uBuLgw',
      'thumbnail': 'https://tse4.mm.bing.net/th?id=OIP.bczwcBVEwClMi2msCRcLIgHaEK&pid=Api&P=0&h=180',
    },
    {
      'name': 'Mark Johnson',
      'description': 'I learned coding through adventure and games! It was the best experience!',
      'videoUrl': 'https://www.youtube.com/watch?v=abcd1236',
      'thumbnail': 'https://tse3.mm.bing.net/th?id=OIP.ldIo6onRRIe1doXhhuYD5QHaEo&pid=Api&P=0&h=180',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 🌌 Background GIF
            Positioned.fill(
              child: Image.asset(
                'assets/splash/solar.gif',
                fit: BoxFit.cover,
              ),
            ),
            // 🔮 Semi-transparent overlay (optional for contrast)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            // 🌟 Main Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'What Our Kids Say!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    for (var testimonial in testimonials)
                      GestureDetector(
                        onTap: () {
                          // Open YouTube URL when the card is tapped
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Watch Testimonial'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(testimonial['thumbnail']!),
                                    SizedBox(height: 10),
                                    Text(testimonial['description']!),
                                    SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () {
                                        // Implement your URL opening here
                                        // Use url_launcher to open the link
                                        print('Opening ${testimonial['videoUrl']}');
                                      },
                                      child: Text('Watch Video'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Column(
                              children: [
                                Image.network(
                                  testimonial['thumbnail']!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        testimonial['name']!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        testimonial['description']!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
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

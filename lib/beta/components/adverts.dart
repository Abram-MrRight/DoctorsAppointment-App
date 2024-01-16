import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertCard extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final String url;

  const AdvertCard({super.key, required this.url, this.imageAsset, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(Uri.parse(url));
      },
      child: Container(
        width: 256.0, // Adjust the width as needed
        margin: const EdgeInsets.all(8.0),
        decoration: imageUrl != null ? BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          ),
        ) : null,
        child: imageAsset != null ?
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imageAsset!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ) :
        const Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HorizontalAdvertCardList extends StatelessWidget {
  const HorizontalAdvertCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          AdvertCard(url: '', imageAsset: 'assets/images/save_time.jpg'),
          AdvertCard(url: '', imageAsset: 'assets/images/features.png'),
          AdvertCard(url: '', imageAsset: 'assets/images/specialistsAd.png'),
          AdvertCard(url: '', imageAsset: 'assets/images/premium_health.jpg'),
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*wyD07LhN9BXLtoGl'),
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*BUoDCSwYNKROMgWU'),
          AdvertCard(url: '', imageUrl: 'https://miro.medium.com/v2/resize:fit:828/format:webp/0*yRW7z7HYpj5yezkO'),
          // Add more AdvertCard widgets as needed
        ],
      ),
    );
  }
}
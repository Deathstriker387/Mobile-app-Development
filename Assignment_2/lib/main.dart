import 'package:flutter/material.dart';

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ListScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Guide'),
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Destinations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full Screen Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/f/fb/New7Wonders.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Semi-transparent overlay
        Container(
          color: Colors.black.withOpacity(0.4),
        ),
        // Content
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Travel Slogan with RichText
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    text: 'Explore the World with Us',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Welcome Message Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Welcome to our Travel Guide App! Discover amazing destinations around the world, find inspirations for your next adventure, and explore the beauty of our planet.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Destination TextField Label
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Enter Your Dream Destination:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Destination TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    hintText: 'e.g., Paris, Tokyo, New York...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        final destination = _destinationController.text;
                        if (destination.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Great choice! Planning a trip to $destination! 🌍',
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a destination first!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Plan My Trip'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () {
                        print('User clicked: Get Recommendations');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Loading personalized recommendations... 📍',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.star),
                      label: const Text('Get Recommendations'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final destinations = [
      {
        'name': 'Paris, France',
        'description':
        'The City of Light is famous for the Eiffel Tower, world-class museums, and romantic atmosphere.'
      },
      {
        'name': 'Tokyo, Japan',
        'description':
        'A bustling metropolis blending tradition with cutting-edge technology and delicious cuisine.'
      },
      {
        'name': 'New York, USA',
        'description':
        'The city that never sleeps offers iconic landmarks, Broadway shows, and diverse neighborhoods.'
      },
      {
        'name': 'Barcelona, Spain',
        'description':
        'Known for its stunning architecture by Gaudí, beautiful beaches, and vibrant culture.'
      },
      {
        'name': 'Dubai, UAE',
        'description':
        'A modern desert oasis featuring luxury shopping, stunning skyscrapers, and golden beaches.'
      },
      {
        'name': 'Rome, Italy',
        'description':
        'The Eternal City is home to ancient ruins, Vatican treasures, and authentic Italian cuisine.'
      },
      {
        'name': 'Bangkok, Thailand',
        'description':
        'Experience ornate temples, vibrant street markets, and incredible street food culture.'
      },
      {
        'name': 'Sydney, Australia',
        'description':
        'Famous for the Opera House and Harbour Bridge, stunning beaches and outdoor activities.'
      },
      {
        'name': 'Amsterdam, Netherlands',
        'description':
        'A charming city with picturesque canals, bicycles, world-class museums, and relaxed vibes.'
      },
      {
        'name': 'Bali, Indonesia',
        'description':
        'A tropical paradise with stunning beaches, rice terraces, temples, and wellness retreats.'
      },
      {
        'name': 'Istanbul, Turkey',
        'description':
        'Straddling two continents, Istanbul blends history, culture, and stunning views.'
      },
      {
        'name': 'London, UK',
        'description':
        'Royal palaces, Big Ben, world-renowned museums, and an iconic red telephone box charm.'
      },
    ];

    return Container(
        color: Colors.blue[50],
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination = destinations[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 16),
              elevation: 3,
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_city,
                        color: Colors.blue[700],
                        size: 50,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(
                              destination['description']! + ' This amazing destination offers unforgettable experiences, unique cultural heritage, and memories that will last a lifetime. Don\'t miss the opportunity to visit this wonderful place.',
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final attractions = [
      {
        'name': 'Eiffel Tower',
        'image':
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=300&h=300',
      },
      {
        'name': 'Taj Mahal',
        'image':
        'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=300&h=300',
      },
      {
        'name': 'Great Wall of China',
        'image':
        'https://images.unsplash.com/photo-1508804185872-d7badad00f7d?w=300&h=300',
      },
      {
        'name': 'Statue of Liberty',
        'image':
        'https://images.unsplash.com/photo-1518391846015-55a9cc003b25?w=300&h=300',
      },
      {
        'name': 'Christ the Redeemer',
        'image':
        'data:image/webp;base64,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',
      },
      {
        'name': 'Big Ben',
        'image':
        'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=300&h=300',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
          mainAxisExtent: 600,
        ),
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final attraction = attractions[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.grey[300],
                    ),
                    child: Image.network(
                      attraction['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    attraction['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
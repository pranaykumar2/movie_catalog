import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie Catalog',
      home: MovieCatalogApp(),
    );
  }
}

class MovieCatalogApp extends StatefulWidget {
  const MovieCatalogApp({super.key});

  @override
  _MovieCatalogAppState createState() => _MovieCatalogAppState();
}

class _MovieCatalogAppState extends State<MovieCatalogApp> {
  List<Map<String, dynamic>> allMovies = [
    {
      'title': 'Inception',
      'image': 'https://i.ibb.co/j999LVHZ/Screenshot-20250329-144959.jpg',
      'description':
          'A thief who enters the dreams of others to steal secrets faces a new task: to plant an idea in a target’s subconscious.',
      'year': '2010',
      'rating': '8.8/10',
      'genre': 'Sci-Fi',
    },
    {
      'title': 'Avatar',
      'image':
          'https://i.ibb.co/LXVrLTFr/127624-3840x2160-desktop-4k-avatar-wallpaper.jpg',
      'description':
          'On the lush alien world of Pandora, a reluctant hero embarks on an epic adventure to save the planet.',
      'year': '2009',
      'rating': '7.9/10',
      'genre': 'Action',
    },
    {
      'title': 'The Dark Knight',
      'image':
          'https://i.ibb.co/GqZzcqC/37797-3840x2160-desktop-4k-the-dark-knight-wallpaper-image.jpg',
      'description':
          'Batman faces a criminal mastermind known as the Joker, who plunges Gotham into anarchy.',
      'year': '2008',
      'rating': '9.0/10',
      'genre': 'Action',
    },
    {
      'title': 'Interstellar',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
      'description':
          'A team of explorers travels through a wormhole in space in search of a new habitable planet.',
      'year': '2014',
      'rating': '8.6/10',
      'genre': 'Sci-Fi',
    },
    {
      'title': 'Avengers: Endgame',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
      'description':
          'The Avengers assemble once again to reverse the catastrophic events caused by Thanos.',
      'year': '2019',
      'rating': '8.4/10',
      'genre': 'Action',
    },
    {
      'title': 'Titanic',
      'image':
          'https://i.ibb.co/sv5gSSNs/303796-2032x3004-phone-hd-titanic-background-image.jpg',
      'description':
          'A young man and woman from different social classes fall in love aboard the ill-fated Titanic.',
      'year': '1997',
      'rating': '7.9/10',
      'genre': 'Romance',
    },
  ];

  List<Map<String, dynamic>> filteredMovies = [];
  String selectedGenre = 'All';

  @override
  void initState() {
    super.initState();
    filteredMovies = allMovies;
  }

  // Search by title or genre
  void filterMovies(String query) {
    setState(() {
      filteredMovies = allMovies
          .where((movie) =>
              (selectedGenre == 'All' || movie['genre'] == selectedGenre) &&
              movie['title']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Filter by Genre
  void filterByGenre(String genre) {
    setState(() {
      selectedGenre = genre;
      filteredMovies = allMovies
          .where((movie) => (genre == 'All' || movie['genre'] == genre))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      'All',
      'Action',
      'Sci-Fi',
      'Romance',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog App'),
        backgroundColor: const Color(0xff6bb0e8),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff289ec1),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterMovies,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          // Genre Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => filterByGenre(genres[index]),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: selectedGenre == genres[index]
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      genres[index],
                      style: TextStyle(
                        color: selectedGenre == genres[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Movie Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to movie detail page when clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                  },
                  child: MovieCard(movie: movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Movie Card Widget
class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              movie['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie['title']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Movie Detail Page
class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(movie['title']),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              movie['image'],
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              movie['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Year: ${movie['year']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Genre: ${movie['genre']}',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 5),
            Text(
              'Rating: ${movie['rating']}',
              style: const TextStyle(fontSize: 16, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            Text(
              movie['description'],
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// About Us Page
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Welcome to the Movie Catalog App!\n\nHere, you can explore a variety of movies, filter them by genre, and get detailed information about each movie. Enjoy exploring!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}

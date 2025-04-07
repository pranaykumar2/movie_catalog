import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie Catalog',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E2BFF),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF5E2BFF),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MovieCatalogApp(),
    );
  }
}

class MovieCatalogApp extends StatefulWidget {
  const MovieCatalogApp({super.key});

  @override
  _MovieCatalogAppState createState() => _MovieCatalogAppState();
}

class _MovieCatalogAppState extends State<MovieCatalogApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> allMovies = [
    {
      'title': 'Inception',
      'image': 'https://i.ibb.co/j999LVHZ/Screenshot-20250329-144959.jpg',
      'description':
          'A thief who enters the dreams of others to steal secrets faces a new task: to plant an idea in a target's subconscious.',
      'year': '2010',
      'rating': '8.8/10',
      'genre': 'Sci-Fi',
      'director': 'Christopher Nolan',
      'cast': 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
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
      'director': 'James Cameron',
      'cast': 'Sam Worthington, Zoe Saldana, Sigourney Weaver',
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
      'director': 'Christopher Nolan',
      'cast': 'Christian Bale, Heath Ledger, Aaron Eckhart',
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
      'director': 'Christopher Nolan',
      'cast': 'Matthew McConaughey, Anne Hathaway, Jessica Chastain',
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
      'director': 'Anthony Russo, Joe Russo',
      'cast': 'Robert Downey Jr., Chris Evans, Mark Ruffalo',
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
      'director': 'James Cameron',
      'cast': 'Leonardo DiCaprio, Kate Winslet, Billy Zane',
    },
  ];

  List<Map<String, dynamic>> filteredMovies = [];
  String selectedGenre = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        filteredMovies = allMovies;
        _isLoading = false;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
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
      
      // Reset search when changing genre
      _searchController.clear();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('CineVerse'),
        backgroundColor: const Color(0xFF5E2BFF),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF5E2BFF),
              ),
              accountName: const Text(
                'Movie Enthusiast',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text('movie.fan@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Color(0xFF5E2BFF),
                  size: 40,
                ),
              ),
              otherAccountsPictures: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile settings coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.settings,
                      color: Color(0xFF5E2BFF),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.movie_outlined, color: Color(0xFF5E2BFF)),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_border, color: Color(0xFF5E2BFF)),
                    title: const Text('Favorites'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Favorites feature coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history, color: Color(0xFF5E2BFF)),
                    title: const Text('Watch History'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Watch history feature coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: Color(0xFF5E2BFF)),
                    title: const Text('About Us'),
                    onTap: () {
                      Navigator.pop(context);
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: const Text('Exit'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _isLoading 
        ? _buildLoadingView()
        : _buildMainContent(context, genres),
    );
  }
  
  Widget _buildLoadingView() {
    return Container(
      color: const Color(0xFF5E2BFF).withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://i.ibb.co/LXVrLTFr/127624-3840x2160-desktop-4k-avatar-wallpaper.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Color(0xFF5E2BFF),
            ),
            const SizedBox(height: 20),
            Text(
              'Loading CineVerse...',
              style: GoogleFonts.poppins(
                color: const Color(0xFF5E2BFF),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMainContent(BuildContext context, List<String> genres) {
    return Column(
      children: [
        // Header with gradient
        Container(
          height: 120,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5E2BFF), Color(0xFF702EFF)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
            child: Text(
              'Discover amazing films',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        
        // Search Bar with shadow
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: filterMovies,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.grey.shade400,
                        onPressed: () {
                          _searchController.clear();
                          filterMovies('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        
        // Genre Filter with improved styling
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              bool isSelected = selectedGenre == genres[index];
              return GestureDetector(
                onTap: () => filterByGenre(genres[index]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF5E2BFF) : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? const Color(0xFF5E2BFF).withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      genres[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        // Movie Count info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Found ${filteredMovies.length} movies',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sorting options coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 4),
                    Text(
                      'Sort',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Movie Grid with staggered animation
        Expanded(
          child: filteredMovies.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie_off,
                        size: 70,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No movies found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try changing your search or filter',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        // Calculate delay for staggered animation
                        final delayedAnimation = index / 10;
                        final animationValue = (_animation.value - delayedAnimation)
                            .clamp(0.0, 1.0);
                            
                        final movie = filteredMovies[index];
                        return Transform.translate(
                          offset: Offset(
                            0.0,
                            50 * (1.0 - animationValue),
                          ),
                          child: Opacity(
                            opacity: animationValue,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to movie detail page with animation
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        MovieDetailPage(movie: movie),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = const Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.easeOutQuint;
                                      var tween = Tween(begin: begin, end: end).chain(
                                        CurveTween(curve: curve),
                                      );
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: MovieCard(movie: movie),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// Enhanced Movie Card Widget
class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Movie poster
            Hero(
              tag: 'movie-image-${movie['title']}',
              child: Image.network(
                movie['image']!,
                fit: BoxFit.cover,
              ),
            ),
            
            // Gradient overlay for text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            
            // Movie information overlay
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E2BFF).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          movie['genre']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber.shade400,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        movie['rating']!.split('/')[0],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Play button overlay
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Trailer for ${movie['title']} coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  splashRadius: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Movie Detail Page
class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite_border, color: Colors.white),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to favorites!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Header with movie poster
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                // Movie poster as background
                SizedBox(
                  width: double.infinity,
                  child: Hero(
                    tag: 'movie-image-${movie['title']}',
                    child: Image.network(
                      movie['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                
                // Movie title and quick info
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5E2BFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              movie['genre']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              movie['year']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie['title']!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie['rating']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Play trailer button
                Positioned(
                  bottom: -25,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Trailer for ${movie['title']} coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5E2BFF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5E2BFF).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Movie details
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cast and crew section
                    const Text(
                      'Cast & Crew',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Director',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie['director'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cast',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie['cast'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Synopsis section
                    const Text(
                      'Synopsis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie['description'],
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Watch now button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Watch ${movie['title']} feature coming soon!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E2BFF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Watch Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Enhanced About Us Page
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About CineVerse'),
        backgroundColor: const Color(0xFF5E2BFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header image
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5E2BFF), Color(0xFF702EFF)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.movie_filter,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'CineVerse',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Your Ultimate Movie Companion',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _AboutSection(
                    icon: Icons.info_outline,
                    title: 'About CineVerse',
                    content: 'CineVerse is your ultimate destination for exploring movies across genres. Our app provides a seamless experience for movie enthusiasts to discover new films, get detailed information, and keep track of their favorites.',
                  ),
                  const SizedBox(height: 20),
                  const _AboutSection(
                    icon: Icons.movie_filter,
                    title: 'Our Collection',
                    content: 'We curate a diverse collection of movies from various genres, eras, and cultures. From blockbuster hits to indie gems, CineVerse aims to cater to all tastes and preferences in the world of cinema.',
                  ),
                  const SizedBox(height: 20),
                  const _AboutSection(
                    icon: Icons.lightbulb_outline,
                    title: 'Features',
                    content: '• Browse movies by genre\n• Search for specific titles\n• Get detailed information about movies\n• Save favorites for quick access\n• Stay updated with latest releases',
                  ),
                  const SizedBox(height: 20),
                  const _AboutSection(
                    icon: Icons.people_outline,
                    title: 'Our Team',
                    content: 'CineVerse is developed by a passionate team of movie buffs and developers who are committed to creating the best movie catalog experience for users worldwide.',
                  ),
                  const SizedBox(height: 30),
                  
                  // Contact section
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get in Touch',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _ContactItem(
                            icon: Icons.email_outlined,
                            title: 'Email',
                            content: 'support@cineverse.example.com',
                          ),
                          const SizedBox(height: 12),
                          const _ContactItem(
                            icon: Icons.web_outlined,
                            title: 'Website',
                            content: 'www.cineverse.example.com',
                          ),
                          const SizedBox(height: 12),
                          const _ContactItem(
                            icon: Icons.location_on_outlined,
                            title: 'Location',
                            content: 'New York, NY, USA',
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Version info
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '© 2025 CineVerse. All rights reserved.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _AboutSection({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF5E2BFF),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF5E2BFF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF5E2BFF),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            Text(
              content,
              style: GoogleFonts.poppins(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

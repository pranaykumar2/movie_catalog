import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
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
      title: 'Movie Catalog',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.light,
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFFa29bfe),
          tertiary: const Color(0xFFfdcb6e),
          surface: Colors.white,
          background: const Color(0xFFF5F9FC),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        cardTheme: CardTheme(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF6C5CE7),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.dark,
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFFa29bfe),
          tertiary: const Color(0xFFfdcb6e),
          surface: const Color(0xFF1F1D36),
          background: const Color(0xFF121212),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        cardTheme: CardTheme(
          elevation: 0,
          color: const Color(0xFF1F1D36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF6C5CE7),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F1D36),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      themeMode: ThemeMode.light, // You can replace with ThemeMode.system to respect system settings
      home: const MovieCatalogApp(),
    );
  }
}

class MovieCatalogApp extends StatefulWidget {
  const MovieCatalogApp({super.key});

  @override
  State<MovieCatalogApp> createState() => _MovieCatalogAppState();
}

class _MovieCatalogAppState extends State<MovieCatalogApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  
  bool _isLoading = true;
  double _currentPage = 0;
  bool _showSearchBar = false;
  
  List<Map<String, dynamic>> allMovies = [
    {
      'title': 'Inception',
      'image': 'https://i.ibb.co/j999LVHZ/Screenshot-20250329-144959.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BMjExMjkwNTQ0Nl5BMl5BanBnXkFtZTcwNTY0OTk1Mw@@._V1_.jpg',
      'description':
          'A thief who enters the dreams of others to steal secrets faces a new task: to plant an idea in a target subconscious.',
      'year': '2010',
      'rating': '8.8/10',
      'genre': 'Sci-Fi',
      'director': 'Christopher Nolan',
      'cast': 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
      'duration': '148 min',
      'featured': true,
    },
    {
      'title': 'Avatar',
      'image':
          'https://i.ibb.co/LXVrLTFr/127624-3840x2160-desktop-4k-avatar-wallpaper.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_FMjpg_UX1000_.jpg',
      'description':
          'On the lush alien world of Pandora, a reluctant hero embarks on an epic adventure to save the planet.',
      'year': '2009',
      'rating': '7.9/10',
      'genre': 'Action',
      'director': 'James Cameron',
      'cast': 'Sam Worthington, Zoe Saldana, Sigourney Weaver',
      'duration': '162 min',
      'featured': true,
    },
    {
      'title': 'The Dark Knight',
      'image':
          'https://i.ibb.co/GqZzcqC/37797-3840x2160-desktop-4k-the-dark-knight-wallpaper-image.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg',
      'description':
          'Batman faces a criminal mastermind known as the Joker, who plunges Gotham into anarchy.',
      'year': '2008',
      'rating': '9.0/10',
      'genre': 'Action',
      'director': 'Christopher Nolan',
      'cast': 'Christian Bale, Heath Ledger, Aaron Eckhart',
      'duration': '152 min',
      'featured': true,
    },
    {
      'title': 'Interstellar',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
      'description':
          'A team of explorers travels through a wormhole in space in search of a new habitable planet.',
      'year': '2014',
      'rating': '8.6/10',
      'genre': 'Sci-Fi',
      'director': 'Christopher Nolan',
      'cast': 'Matthew McConaughey, Anne Hathaway, Jessica Chastain',
      'duration': '169 min',
      'featured': false,
    },
    {
      'title': 'Avengers: Endgame',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg',
      'description':
          'The Avengers assemble once again to reverse the catastrophic events caused by Thanos.',
      'year': '2019',
      'rating': '8.4/10',
      'genre': 'Action',
      'director': 'Anthony Russo, Joe Russo',
      'cast': 'Robert Downey Jr., Chris Evans, Mark Ruffalo',
      'duration': '181 min',
      'featured': false,
    },
    {
      'title': 'Titanic',
      'image':
          'https://i.ibb.co/sv5gSSNs/303796-2032x3004-phone-hd-titanic-background-image.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_.jpg',
      'description':
          'A young man and woman from different social classes fall in love aboard the ill-fated Titanic.',
      'year': '1997',
      'rating': '7.9/10',
      'genre': 'Romance',
      'director': 'James Cameron',
      'cast': 'Leonardo DiCaprio, Kate Winslet, Billy Zane',
      'duration': '194 min',
      'featured': false,
    },
    {
      'title': 'The Matrix',
      'image': 'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'description': 'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.',
      'year': '1999',
      'rating': '8.7/10',
      'genre': 'Sci-Fi',
      'director': 'Lana Wachowski, Lilly Wachowski',
      'cast': 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss',
      'duration': '136 min',
      'featured': false,
    },
    {
      'title': 'Parasite',
      'image': 'https://m.media-amazon.com/images/M/MV5BYWZjMjk3ZTItODQ2ZC00NTY5LWE0ZDYtZTI3MjcwN2Q5NTVkXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_.jpg',
      'backdrop': 'https://m.media-amazon.com/images/M/MV5BYWZjMjk3ZTItODQ2ZC00NTY5LWE0ZDYtZTI3MjcwN2Q5NTVkXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_.jpg',
      'description': 'Greed and class discrimination threaten the relationship between a wealthy family and a poor one.',
      'year': '2019',
      'rating': '8.6/10',
      'genre': 'Drama',
      'director': 'Bong Joon Ho',
      'cast': 'Song Kang-ho, Lee Sun-kyun, Jo Yeo-jeong',
      'duration': '132 min',
      'featured': false,
    },
  ];

  List<Map<String, dynamic>> featuredMovies = [];
  List<Map<String, dynamic>> filteredMovies = [];
  String selectedGenre = 'All';

  List<String> genres = [
    'All',
    'Action',
    'Sci-Fi',
    'Romance',
    'Drama',
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    
    // Setup page view listener
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        featuredMovies = allMovies.where((movie) => movie['featured'] == true).toList();
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
    _pageController.dispose();
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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _showSearchBar 
            ? SizedBox(
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.white.withAlpha(50),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: _searchController,
                        onChanged: filterMovies,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search movies...',
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search, color: Colors.white70, size: 20),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white70, size: 18),
                            onPressed: () {
                              setState(() {
                                _showSearchBar = false;
                                _searchController.clear();
                                filterMovies('');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const Text('Movie Catalog'),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                _showSearchBar ? Icons.search_off : Icons.search,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: GlassmorphicDrawer(
        user: 'Pranay Kumar',
        email: 'iamypranay@gmail.com',
      ),
      body: _isLoading 
        ? _buildLoadingView()
        : Stack(
            children: [
              _buildMainContent(context, theme, size),
              
              // Bottom navigation bar with glassmorphism
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withAlpha(30),
                            Colors.white.withAlpha(70),
                          ],
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNavItem(icon: Icons.home_rounded, label: 'Home', isSelected: true),
                          _buildNavItem(icon: Icons.explore_outlined, label: 'Explore'),
                          _buildNavItem(icon: Icons.bookmark_border_rounded, label: 'Watchlist'),
                          _buildNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
  
  Widget _buildNavItem({
    required IconData icon, 
    required String label, 
    bool isSelected = false
  }) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label page coming soon!'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color(0xFF6C5CE7),
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withAlpha(200),
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withAlpha(200),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLoadingView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6C5CE7), Color(0xFF4834d4)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.movie_filter_rounded,
                        size: 60,
                        color: Color(0xFF6C5CE7),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutQuad,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Column(
                children: [
                  Text(
                    'Movie Catalog',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Premium Movie Experience',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.white.withAlpha(50),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 6,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMainContent(BuildContext context, ThemeData theme, Size size) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Featured movies carousel with parallax effect
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.6,
            child: Stack(
              children: [
                // Carousel PageView
                PageView.builder(
                  controller: _pageController,
                  itemCount: featuredMovies.length,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 0;
                        if (_pageController.position.haveDimensions) {
                          value = index.toDouble() - (_pageController.page ?? 0);
                          value = (value * 0.04).clamp(-1, 1);
                        }
                        return Transform.scale(
                          scale: 1 - (value.abs() * 0.1),
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  MovieDetailPage(movie: featuredMovies[index]),
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
                        child: Hero(
                          tag: 'movie-image-${featuredMovies[index]['title']}',
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(40),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(featuredMovies[index]['backdrop']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Gradient overlay
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(100),
                                        Colors.black.withAlpha(200),
                                      ],
                                      stops: const [0.4, 0.7, 1.0],
                                    ),
                                  ),
                                ),
                                
                                // Movie info
                                Positioned(
                                  bottom: 30,
                                  left: 25,
                                  right: 25,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFeaturedMovieBadge(),
                                      const SizedBox(height: 15),
                                      Text(
                                        featuredMovies[index]['title'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6C5CE7).withAlpha(200),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              featuredMovies[index]['genre'],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withAlpha(150),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Color(0xFFfdcb6e),
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  featuredMovies[index]['rating'].split('/')[0],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withAlpha(150),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              featuredMovies[index]['duration'],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      GlassmorphicButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Trailer for ${featuredMovies[index]['title']} coming soon!'),
                                              behavior: SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              backgroundColor: const Color(0xFF6C5CE7),
                                            ),
                                          );
                                        },
                                        icon: Icons.play_arrow_rounded,
                                        label: 'Watch Trailer',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                // Carousel indicators
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      featuredMovies.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _currentPage.round() == index ? 20 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _currentPage.round() == index
                              ? const Color(0xFF6C5CE7)
                              : Colors.white.withAlpha(100),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Category filter header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.brightness == Brightness.dark ? Colors.white : Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('More categories coming soon!'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF6C5CE7),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6C5CE7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Genre filters
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - _animation.value)),
                  child: Opacity(
                    opacity: _animation.value,
                    child: child,
                  ),
                );
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (context, index) {
                  bool isSelected = selectedGenre == genres[index];
                  return GestureDetector(
                    onTap: () => filterByGenre(genres[index]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: isSelected
                          ? GlassmorphicChip(label: genres[index], isSelected: true)
                          : Chip(
                              label: Text(
                                genres[index],
                                style: TextStyle(
                                  color: theme.brightness == Brightness.dark ? Colors.white : Colors.black87,
                                ),
                              ),
                              backgroundColor: theme.brightness == Brightness.dark
                                  ? const Color(0xFF1F1D36)
                                  : Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: BorderSide.none,
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        
        // Trending movies section header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending Now',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.brightness == Brightness.dark ? Colors.white : Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Found: ${filteredMovies.length}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, size: 22),
                      color: const Color(0xFF6C5CE7),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Advanced filters coming soon!'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF6C5CE7),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Movie grid
        SliverPadding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 90),
          sliver: filteredMovies.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_filter,
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
                  ),
                )
              : SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final movie = filteredMovies[index];
                      // Calculate delay for staggered animation
                      final delayedAnimation = index / 10;
                      final animationValue = (_animation.value - delayedAnimation)
                          .clamp(0.0, 1.0);
                          
                      return Transform.translate(
                        offset: Offset(
                          0.0,
                          50 * (1.0 - animationValue),
                        ),
                        child: Opacity(
                          opacity: animationValue,
                          child: GestureDetector(
                            onTap: () {
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
                            child: GlassmorphicMovieCard(movie: movie),
                          ),
                        ),
                      );
                    },
                    childCount: filteredMovies.length,
                  ),
                ),
        ),
      ],
    );
  }
  
  Widget _buildFeaturedMovieBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFfdcb6e), Color(0xFFe84393)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            'Featured Film',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Glassmorphic Movie Card
class GlassmorphicMovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const GlassmorphicMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
            
            // Glassmorphic info overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withAlpha(30),
                          Colors.white.withAlpha(70),
                        ],
                      ),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withAlpha(80),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Column(
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
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withAlpha(150),
                                borderRadius: BorderRadius.circular(12),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Color(0xFFfdcb6e),
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
                      ],
                    ),
                  ),
                ),
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
                  color: const Color(0xFF6C5CE7).withAlpha(150),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 8,
                    ),
                  ],
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF6C5CE7),
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

// Glassmorphic Button
class GlassmorphicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const GlassmorphicButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withAlpha(30),
                  Colors.white.withAlpha(70),
                ],
              ),
              border: Border.all(
                color: Colors.white.withAlpha(80),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Glassmorphic Chip
class GlassmorphicChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const GlassmorphicChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6C5CE7).withAlpha(170),
                const Color(0xFF6C5CE7).withAlpha(220),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withAlpha(40),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: Colors.white.withAlpha(80),
              width: 0.5,
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

// Glassmorphic Drawer
class GlassmorphicDrawer extends StatelessWidget {
  final String user;
  final String email;

  const GlassmorphicDrawer({
    super.key,
    required this.user,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1535016120720-40c646be5580?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Glassmorphic overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black.withAlpha(100),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          
          // Drawer content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withAlpha(100),
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFF6C5CE7),
                          radius: 45,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        user,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        email,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Menu items
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withAlpha(30),
                              Colors.white.withAlpha(50),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          border: Border.all(
                            color: Colors.white.withAlpha(80),
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          child: Column(
                            children: [
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.home_rounded,
                                label: 'Home',
                                selected: true,
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.local_fire_department_rounded,
                                label: 'Trending',
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.bookmark_border_rounded,
                                label: 'Watchlist',
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.download_outlined,
                                label: 'Downloads',
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.history_rounded,
                                label: 'History',
                              ),
                              
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Divider(color: Colors.white38, height: 1),
                              ),
                              
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.notifications_none_rounded,
                                label: 'Notifications',
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.settings_outlined,
                                label: 'Settings',
                              ),
                              _buildDrawerItem(
                                context: context,
                                icon: Icons.info_outline_rounded,
                                label: 'About',
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
                              
                              const Spacer(),
                              
                              // Log out button
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Logout feature coming soon!'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      backgroundColor: Color(0xFF6C5CE7),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.redAccent.withAlpha(150),
                                        Colors.red.withAlpha(180),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withAlpha(50),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.logout_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Logout',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? const Color(0xFF6C5CE7) : Colors.white,
        size: 22,
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
                    fontSize: 16,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          color: selected ? const Color(0xFF6C5CE7) : Colors.white,
        ),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context);
        if (!selected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label page coming soon!'),
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              backgroundColor: const Color(0xFF6C5CE7),
            ),
          );
        }
      },
      // Add subtle highlight for selected item
      tileColor: selected ? Colors.white.withAlpha(20) : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Enhanced Movie Detail Page with Glassmorphism
class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(80),
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
                color: Colors.black.withAlpha(80),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.favorite_border, color: Colors.white),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${movie['title']} to favorites!'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFF6C5CE7),
                ),
              );
            },
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.share_outlined, color: Colors.white),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Share ${movie['title']} feature coming soon!'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFF6C5CE7),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Background image with parallax effect
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero movie poster as header
                SizedBox(
                  height: size.height * 0.65,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Full-screen movie backdrop
                      Hero(
                        tag: 'movie-image-${movie['title']}',
                        child: SizedBox(
                          height: size.height * 0.65,
                          width: double.infinity,
                          child: Image.network(
                            movie['backdrop'] ?? movie['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
                      // Gradient overlay for visibility
                      Container(
                        height: size.height * 0.65,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(150),
                              Colors.black,
                            ],
                            stops: const [0.4, 0.7, 0.95],
                          ),
                        ),
                      ),
                      
                      // Movie info positioned at bottom
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Genre and rating chips row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C5CE7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    movie['genre']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie['rating']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withAlpha(100),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    movie['duration'] ?? '120 min',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 15),
                            
                            // Movie title
                            Text(
                              movie['title']!,
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            
                            const SizedBox(height: 6),
                            
                            // Year and director
                            Text(
                              '${movie['year']} • Directed by ${movie['director'] ?? 'Unknown Director'}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Play trailer floating button
                      Positioned(
                        bottom: -25,
                        right: 30,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Trailer for ${movie['title']} coming soon!'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: const Color(0xFF6C5CE7),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C5CE7), Color(0xFF8A7CE0)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6C5CE7).withAlpha(100),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Cast and crew section
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cast & Crew',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            for (String actor in (movie['cast'] as String).split(', '))
                              _buildCastCard(actor),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Synopsis section
                      Text(
                        'Synopsis',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Action buttons
                      Row(
                        children: [
                          // Watch now button
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Watch ${movie['title']} feature coming soon!'),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: const Color(0xFF6C5CE7),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6C5CE7),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.play_circle_fill_rounded),
                                  const SizedBox(width: 8),
                                  const Text('Watch Now'),
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Download button
                          Expanded(
                            flex: 2,
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Download ${movie['title']} feature coming soon!'),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: const Color(0xFF6C5CE7),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white, width: 2),
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.download_rounded),
                                  const SizedBox(width: 8),
                                  const Text('Download'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Similar movies suggestion section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Similar Movies',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('More similar movies coming soon!'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  backgroundColor: Color(0xFF6C5CE7),
                                ),
                              );
                            },
                            child: Text(
                              'See All',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF6C5CE7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 15),
                      
                      // Similar movies horizontal list
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 3, // Show only 3 similar movies
                          itemBuilder: (context, index) {
                            // Simply show 3 random movies as "similar"
                            final similarIndex = (index + 2) % 8; // Adjust to avoid showing the same movie
                            
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailPage(
                                      movie: ((movie['title'] == 'The Matrix') && (similarIndex == 0)) 
                                        ? {'title': 'The Matrix Reloaded', 'image': 'https://m.media-amazon.com/images/M/MV5BODE0MzZhZTgtYzkwYi00YmI5LThlZWYtOWRmNWE5ODk0NzMxXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg', 'description': 'Freedom fighters Neo, Trinity and Morpheus continue to lead the revolt against the Machine Army.', 'year': '2003', 'rating': '7.2/10', 'genre': 'Sci-Fi', 'director': 'Lana Wachowski, Lilly Wachowski', 'cast': 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss', 'duration': '138 min'} // Just a placeholder to avoid showing the current movie
                                        : ([0, 1, 2, 3, 4, 5, 6, 7]..shuffle()).first < 4 // To create some variety, show a different movie each time
                                            ? {'title': 'Blade Runner 2049', 'image': 'https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg', 'description': 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.', 'year': '2017', 'rating': '8.0/10', 'genre': 'Sci-Fi', 'director': 'Denis Villeneuve', 'cast': 'Harrison Ford, Ryan Gosling, Ana de Armas', 'duration': '164 min'}
                                            : {'title': 'Dune', 'image': 'https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg', 'description': 'Feature adaptation of Frank Herbert\'s science fiction novel, about the son of a noble family entrusted with the protection of the most valuable asset in the galaxy.', 'year': '2021', 'rating': '8.0/10', 'genre': 'Sci-Fi', 'director': 'Denis Villeneuve', 'cast': 'Timothée Chalamet, Rebecca Ferguson, Oscar Isaac', 'duration': '155 min'}
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(40),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        index == 0 
                                          ? 'https://m.media-amazon.com/images/M/MV5BODE0MzZhZTgtYzkwYi00YmI5LThlZWYtOWRmNWE5ODk0NzMxXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg'
                                          : index == 1
                                            ? 'https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg'
                                            : 'https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg',
                                        height: 180,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                      
                                      // Gradient overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withAlpha(200),
                                            ],
                                            stops: const [0.6, 1.0],
                                          ),
                                        ),
                                      ),
                                      
                                      // Title overlay
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                        child: Text(
                                          index == 0 
                                            ? 'The Matrix Reloaded'
                                            : index == 1
                                              ? 'Blade Runner 2049'
                                              : 'Dune',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 80), // Extra padding for bottom nav safety
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Floating action buttons at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(0),
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: Icons.add,
                        label: 'My List',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${movie['title']} to your list!'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xFF6C5CE7),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context: context,
                        icon: Icons.thumb_up_alt_outlined,
                        label: 'Rate',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Rating feature coming soon!'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              backgroundColor: Color(0xFF6C5CE7),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context: context,
                        icon: Icons.share_outlined,
                        label: 'Share',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Share feature coming soon!'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              backgroundColor: Color(0xFF6C5CE7),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCastCard(String actor) {
    // Sample images for cast (in a real app, you would use actual cast photos)
    final Map<String, String> actorImages = {
  'Leonardo DiCaprio': 'https://m.media-amazon.com/images/M/MV5BMjI0MTg3MzI0M15BMl5BanBnXkFtZTcwMzQyODU2Mw@@._V1_UY317_CR10,0,214,317_AL_.jpg',
  'Joseph Gordon-Levitt': 'https://m.media-amazon.com/images/M/MV5BMTY3NTk0NDI3Ml5BMl5BanBnXkFtZTgwNDA3NjY0MjE@._V1_UY317_CR14,0,214,317_AL_.jpg',
  'Ellen Page': 'https://m.media-amazon.com/images/M/MV5BMTU3MzM3MDYzMV5BMl5BanBnXkFtZTcwNzk1Mzc3NA@@._V1_UY317_CR12,0,214,317_AL_.jpg',
  'Sam Worthington': 'https://www.nbc.com/sites/nbcblog/files/2024/08/the-killer-cast-sam-worthington.jpg',
  'Zoe Saldana': 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSrrZg65-rGvBbXvisdQd-BouxSw0dw-Z7U316XbQSNHuOrzBzbofgjMnRKhhQA_ZlqwqO5UWBBIL_P-mlPeN5gDQ',
  'Sigourney Weaver': 'https://m.media-amazon.com/images/M/MV5BMTk1MTcyNTE3OV5BMl5BanBnXkFtZTcwMTA0MTMyMw@@._V1_UY317_CR12,0,214,317_AL_.jpg',
  'Christian Bale': 'https://m.media-amazon.com/images/M/MV5BMTkxMzk4MjQ4MF5BMl5BanBnXkFtZTcwMzExODQxOA@@._V1_UY317_CR1,0,214,317_AL_.jpg',
  'Heath Ledger': 'https://m.media-amazon.com/images/M/MV5BMTI2NTY0NzA4MF5BMl5BanBnXkFtZTYwMjE1MDE0._V1_UX214_CR0,0,214,317_AL_.jpg',
  'Aaron Eckhart': 'https://m.media-amazon.com/images/M/MV5BMTc4MTAyNzMzNF5BMl5BanBnXkFtZTcwMzQ5MzQzMg@@._V1_UY317_CR6,0,214,317_AL_.jpg',
  'Matthew McConaughey': 'https://m.media-amazon.com/images/M/MV5BMTg0MDc3ODUwOV5BMl5BanBnXkFtZTcwMTk2NjY4Nw@@._V1_UY317_CR12,0,214,317_AL_.jpg',
  'Anne Hathaway': 'https://m.media-amazon.com/images/M/MV5BNjQ5MDAwNjAzN15BMl5BanBnXkFtZTcwMTk4NzU0NA@@._V1_UY317_CR8,0,214,317_AL_.jpg',
  'Jessica Chastain': 'https://m.media-amazon.com/images/M/MV5BMTU2MDcwMzY4NF5BMl5BanBnXkFtZTcwOTM0NDIyNw@@._V1_UY317_CR12,0,214,317_AL_.jpg',
  'Robert Downey Jr.': 'https://m.media-amazon.com/images/M/MV5BNzg1MTUyNDYxOF5BMl5BanBnXkFtZTgwNTQ4MTE2MjE@._V1_UY317_CR12,0,214,317_AL_.jpg',
  'Chris Evans': 'https://m.media-amazon.com/images/M/MV5BMTU2NTg1OTQzMF5BMl5BanBnXkFtZTcwNjIyMjkyMg@@._V1_UY317_CR6,0,214,317_AL_.jpg',
  'Mark Ruffalo': 'https://m.media-amazon.com/images/M/MV5BNWIzZTI1ODUtZTUzMC00NTdiLWFlOTYtZTg4MGZkYmU4YzNlXkEyXkFqcGdeQXVyNTExOTk5Nzg@._V1_UY317_CR7,0,214,317_AL_.jpg',
  'Kate Winslet': 'https://m.media-amazon.com/images/M/MV5BODgzMzM2NTE0Ml5BMl5BanBnXkFtZTcwMTcyMTkyOQ@@._V1_UY317_CR5,0,214,317_AL_.jpg',
  'Billy Zane': 'https://m.media-amazon.com/images/M/MV5BMTI5NzA2NTE0NF5BMl5BanBnXkFtZTcwODYzOTAzMQ@@._V1_UY317_CR15,0,214,317_AL_.jpg',
  'Keanu Reeves': 'https://m.media-amazon.com/images/M/MV5BNGJmMWEzOGQtMWZkNS00MGNiLTk5NGEtYzg0YmJiZjc0OTk0XkEyXkFqcGdeQXVyMTE1MTYxNDAw._V1_UY317_CR100,0,214,317_AL_.jpg',
  'Laurence Fishburne': 'https://m.media-amazon.com/images/M/MV5BMTc0NjczNDc1MV5BMl5BanBnXkFtZTYwMDU0Mjg1._V1_UX214_CR0,0,214,317_AL_.jpg',
  'Carrie-Anne Moss': 'https://m.media-amazon.com/images/M/MV5BMTYxMjgwNzEwOF5BMl5BanBnXkFtZTcwNTQ0NzI5Ng@@._V1_UY317_CR16,0,214,317_AL_.jpg',
  'Song Kang-ho': 'https://m.media-amazon.com/images/M/MV5BYWQwMmE5YzItYjVkNC00NGYyLTk3NTMtNDQ0NjQ2ZTI3MDQ2XkEyXkFqcGdeQXVyNDQxNjcxNQ@@._V1_UY317_CR22,0,214,317_AL_.jpg',
  'Lee Sun-kyun': 'https://m.media-amazon.com/images/M/MV5BMzA1MzQxOTYyOV5BMl5BanBnXkFtZTgwMDI5NjYwNzE@._V1_UY317_CR20,0,214,317_AL_.jpg',
  'Jo Yeo-jeong': 'https://m.media-amazon.com/images/M/MV5BOWZlMjVkYjgtNWU0Ni00YzhkLWE2NWUtYzQxNzFmZjFmMTMyXkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_UY317_CR20,0,214,317_AL_.jpg'
};
    
    // Default image if actor not found in our map
    final imageUrl = actorImages[actor] ?? 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
    
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          // Actor image
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Actor name
          Text(
            actor,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Enhanced About Us Page with Glassmorphism
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('About Movie Catalog'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6C5CE7), Color(0xFF4834d4)],
              ),
            ),
          ),
          
          // Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  // Header with app logo and title
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        // App logo
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(40),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.movie_filter_rounded,
                              size: 60,
                              color: Color(0xFF6C5CE7),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Movie Catalog',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Version 1.0.0',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Content sections with glassmorphism
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildGlassmorphicSection(
                          icon: Icons.info_outline,
                          title: 'About Movie Catalog',
                          content: 'Movie Catalog is your ultimate destination for exploring movies across genres. Our app provides a seamless experience for movie enthusiasts to discover new films, get detailed information, and keep track of their favorites.',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildGlassmorphicSection(
                          icon: Icons.movie_filter,
                          title: 'Our Collection',
                          content: 'We curate a diverse collection of movies from various genres, eras, and cultures. From blockbuster hits to indie gems, Movie Catalog aims to cater to all tastes and preferences in the world of cinema.',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildGlassmorphicSection(
                          icon: Icons.lightbulb_outline,
                          title: 'Features',
                          content: '• Premium UI with glassmorphism effects\n• Browse movies by genre\n• Search for specific titles\n• Get detailed information about movies\n• Save favorites for quick access\n• Discover trending and featured films\n• Share movies with friends',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildGlassmorphicSection(
                          icon: Icons.people_outline,
                          title: 'Our Team',
                          content: 'Movie Catalog is developed by a passionate team of movie buffs and Flutter developers who are committed to creating the best movie catalog experience for users worldwide.',
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Contact section
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withAlpha(40),
                                    Colors.white.withAlpha(20),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withAlpha(80),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(50),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.contact_support_outlined,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Get in Touch',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  _buildContactItem(
                                    icon: Icons.email_outlined,
                                    title: 'Email',
                                    content: 'support@Movie Catalog.example.com',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildContactItem(
                                    icon: Icons.web_outlined,
                                    title: 'Website',
                                    content: 'www.Movie Catalog.example.com',
                                  ),
                                  const SizedBox(height: 15),
                                  _buildContactItem(
                                    icon: Icons.location_on_outlined,
                                    title: 'Location',
                                    content: 'New York, NY, USA',
                                  ),
                                  const SizedBox(height: 20),
                                  GlassmorphicButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Contact form coming soon!'),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                          backgroundColor: Color(0xFF6C5CE7),
                                        ),
                                      );
                                    },
                                    icon: Icons.message_outlined,
                                    label: 'Send Message',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Footer
                        Text(
                          '© 2025 Movie Catalog. All rights reserved.',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withAlpha(150),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGlassmorphicSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withAlpha(40),
                Colors.white.withAlpha(20),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withAlpha(80),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Text(
              content,
              style: GoogleFonts.poppins(
                color: Colors.white.withAlpha(180),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

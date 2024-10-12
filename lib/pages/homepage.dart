import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/pages/favorites.dart';
import 'package:webtoon_explorer_app/item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  final List<Item> ListItems = [
    Item(
      title: 'Hello Baby',
      imageUrl: 'lib/assets/toonImages/01.webp',
      itemNumber: 0,
      rating: 1.0,
    ),
    Item(
      title: 'The Alpha King’s Claim',
      imageUrl: 'lib/assets/toonImages/02.webp',
      itemNumber: 1,
      rating: 1.0,
    ),
    Item(
      title: 'Bitten Contract',
      imageUrl: 'lib/assets/toonImages/03.webp',
      itemNumber: 2,
      rating: 1.0,
    ),
    Item(
      title: 'Tricked into Becoming the Heroine’s Stepmother',
      imageUrl: 'lib/assets/toonImages/04.webp',
      itemNumber: 3,
      rating: 1.0,
    ),
    Item(
      title: 'The Guy Upstairs',
      imageUrl: 'lib/assets/toonImages/05.png',
      itemNumber: 4,
      rating: 1.0,
    ),
    Item(
      title: 'The Runaway',
      imageUrl: 'lib/assets/toonImages/06.png',
      itemNumber: 5,
      rating: 1.0,
    ),
    Item(
      title: 'Your Smile Is A Trap',
      imageUrl: 'lib/assets/toonImages/07.webp',
      itemNumber: 6,
      rating: 1.0,
    ),
    Item(
      title: 'There Must Be Happy Endings',
      imageUrl: 'lib/assets/toonImages/08.webp',
      itemNumber: 7,
      rating: 1.0,
    ),
    Item(
      title: 'Seasons of Blossom',
      imageUrl: 'lib/assets/toonImages/09.webp',
      itemNumber: 8,
      rating: 1.0,
    ),
    Item(
      title: 'Romance 101',
      imageUrl: 'lib/assets/toonImages/10.webp',
      itemNumber: 9,
      rating: 1.0,
    ),
  ];

  // load last saved ratings
  void _loadRatings() {
    var box = Hive.box('ratings');
    for (var item in ListItems) {
      double rating = box.get(item.title, defaultValue: 0.0);
      item.rating = rating;
    }
    setState(() {});
  }

  // save ratings
  void _saveRating(String title, double rating) {
    var box = Hive.box('ratings');
    box.put(title, rating);
  }

  void loadItems() {
    // Load items from Hive
    final favoritesBox = Hive.box<Item>('favorites');
    ListItems.forEach((item) {
      item.isFavorite = favoritesBox.containsKey(item.itemNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top 10 Popular Webtoons",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              ).then((_) {
                setState(() {
                  loadItems();
                });
              });
            },
            icon: const Icon(
              Icons.bookmarks_rounded,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ListItems.length,
        itemBuilder: (context, index) {
          final item = ListItems[index];
          return ToonListItem(
            item: item,
            onRatingChange: (newRating) {
              setState(() {
                ListItems[index].rating = newRating;
                _saveRating(ListItems[index].title, ListItems[index].rating);
              });
            },
          );
        },
      ),
    );
  }
}

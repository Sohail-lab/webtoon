import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webtoon_explorer_app/item.dart';
import 'package:webtoon_explorer_app/pages/item_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Item>('favorites').listenable(),
        builder: (context, Box<Item> favoritesBox, _) {
          List<Item> favoriteItems = favoritesBox.values.toList();

          return favoriteItems.isEmpty
              ? const Center(child: Text('No favorite items yet!'))
              : ListView.builder(
                  itemCount: favoriteItems.length,
                  itemBuilder: (context, index) {
                    Item item = favoriteItems[index];
                    return ListTile(
                      leading: Image.asset(
                        item.imageUrl,
                        height: 50,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.title),
                      subtitle: Text('Rating: ${item.rating.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.bookmark_remove_rounded),
                        onPressed: () {
                          setState(() {
                            item.isFavorite = !item.isFavorite;
                            favoritesBox.delete(item.itemNumber);
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetails(item: item,),
                          )
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}

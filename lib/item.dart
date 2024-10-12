import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/pages/item_details_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final int itemNumber;
  @HiveField(3)
  bool isFavorite;
  @HiveField(4)
  double rating;

  Item({
    required this.title,
    required this.imageUrl,
    required this.itemNumber,
    this.isFavorite = false,
    this.rating = 0.0,
  });
}

class ToonListItem extends StatefulWidget {
  final Item item;
  final ValueChanged<double> onRatingChange;

  const ToonListItem({
    super.key,
    required this.item,
    required this.onRatingChange,
  });

  @override
  State<ToonListItem> createState() => _ToonListItemState();
}

class _ToonListItemState extends State<ToonListItem> {
  final favoritesBox = Hive.box<Item>('favorites');

  @override
  void initState() {
    super.initState();
    if (favoritesBox.containsKey(widget.item.itemNumber)) {
      widget.item.isFavorite =
          favoritesBox.get(widget.item.itemNumber)!.isFavorite;
    }
  }

  void favoriteChange() {
    if (widget.item.isFavorite) {
      favoritesBox.delete(widget.item.itemNumber);
    } else {
      favoritesBox.put(widget.item.itemNumber, widget.item);
    }
    setState(() {
      widget.item.isFavorite = !widget.item.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetails(
                      item: widget.item,
                    ))).then((_) {
          setState(() {});
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  widget.item.imageUrl,
                  height: 90,
                  width: 120,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                    initialRating: widget.item.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.2),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: widget.onRatingChange,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(widget.item.isFavorite == true
                      ? Icons.bookmark_added
                      : Icons.bookmark_border_rounded),
                  onPressed: () {
                    favoriteChange();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

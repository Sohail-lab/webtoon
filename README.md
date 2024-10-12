# webtoon_explorer_app

Webtoon Explorer App

flutter package dependencies:
  flutter_rating_bar: ^4.0.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0


The app has a simple UI. The homepage loads a list of 10 most popular webtoons and displays then in a list of Card sytle.
Each Card starts with a thumbnail of the webtoon followed by title and rating. **The rating can be adjusted dynamically by clicking or sliding on the stars**
There is also an **Add to Favorite** button at the end of each card which saves the item to a hivebox created locally.
The favorites page can be navigated by clicking the favorites page icon on top right corner of screen
The favorites page has a list of favorite items and can be removed by clicking on remove from favorite button beside each item.
When clicked on any item it opens the item details page. The details page has a Thumbnail, Title of webtoon, Description and an **add to favorites button**
The design is kept simple cause I could not find a suitable color palette.


There is also an android app built ready named **install-android.apk**

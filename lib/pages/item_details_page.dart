import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webtoon_explorer_app/item.dart';
import 'package:webtoon_explorer_app/pages/favorites.dart';

class ItemDetails extends StatefulWidget {
  final Item item;

  const ItemDetails({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late bool isFavorite;

  final favoritesBox = Hive.box<Item>('favorites');

  @override
  void initState() {
    super.initState();
    if (favoritesBox.containsKey(widget.item.itemNumber)) {
      widget.item.isFavorite =
          favoritesBox.get(widget.item.itemNumber)!.isFavorite;
    }
    isFavorite = widget.item.isFavorite;
  }

  final List<String> itemDescription = [
    '''
    Gwen is a kind and passionate young woman with a tragic backstory. Her mother died when she was young, and her stepmother and stepsister treated her even worse with the demise of her father. Before dying, her father suggests she go on a cruise vacation with her best friend when her partner broke up with her to focus on his career instead. On the vacation, she meets Arthur, a handsome but lonely young man. Things escalate between them when they share their unfortunate fates. They end up hooking up, but Gwen runs away, afraid of the outcome. Fate brings them 2 years later, and they end up in a legal fight when Arthur finds out about his and Gwen’s child. Read Hello Baby to learn whether they can solve their differences.
    ''',
    '''
    Do you believe in supernatural creatures like werewolves, vampires, and witches? How would you feel if one day you were transported to a different realm when you touched a painting? The same thing happened with Serena in The Alpha King’s Claim. One rainy day, she buys an interesting painting while taking shelter in a painting shop. When she touched the painting at her home, she got transported to the realm where werewolves lived. Moreover, she ends up on the bed of the Alpha King Aero, who hates all women.
    ''',
    '''
    Do you believe vampires exist? What would your first reaction be if you crossed paths with a vampire? Would you be delighted, terrified, or unsure of how to act? Well, Chae-i certainly had an unusual reaction than the others. Chae-i is an actress who has been in the entertainment industry ever since she can remember. However, she is been having a hard time fitting in with other actors due to the extremely painful headaches she started having a little while ago. As a consequence of this, her professional life started deteriorating.\n\nEveryone started thinking of her as some stuck-up actress. However, one time, she gets bitten by Ijun, a top actor who is a vampire. Surprisingly, her headache vanishes for a week. Hence, she asks him to continue biting her to keep everything going smoothly. To her surprise, Ijun asks for a contractual relationship in return. Read the popular webtoon, Bitten Contract, to find out his motive behind asking Chae-i for a relationship.
    ''',
    '''
    How would you feel if one day you woke up in the novel you wrote just after dying in the real world? Would you feel ecstatic to have a chance to live again? Or would you feel scared because of the uncertain possibilities and the danger lurking? Daisy is a woman with a kind yet strong personality. Following her death in the real world, she wakes up in the novel she wrote with her nine other friends just for fun. Unfortunately, her living conditions do not change much. However, one random day, she is arrested by the duke’s soldier for helping her friend out.
    ''',
    '''
    The Guy Upstairs follows Rosy, a college undergraduate who is an orphan and barely makes ends meet by working odd jobs. However, her life is not too tough, especially because of her best friend Hawa. She supported and trusted her when nobody else did. However, strangely enough, she hears weird sounds coming from the floor above. One random day she decides to check just for her peace of mind, but wait, why is there a dead body of a woman? Moreover, why is she being dragged by her neighbor upstairs?
    ''',
    '''
    Paris is known as the city of love by the whole world. Would you consider going there freshly after a breakup? Jian is a beautiful young woman who works in the fashion industry. One day, she discovers that her new handsome boss is the person she had been hooked up with in France. She dismisses it, thinking that he probably does not remember her since it has been so long. However, she is proved wrong. On top of it all, he is extremely rude to her in the office but too nice when alone. Also, the new gay couple that shifted next door is quite interesting. Scroll the popular webtoon The Runaway to know what happens when Jian’s ex tries patching up things with her and why the handsome neighbor is too kind to her.
    ''',
    '''
    Do you believe that people judge others based on their outer appearance? Have you ever been judged based on your looks? Kiyo is an ex-idol trainee who wants to live like a normal teenager. In this attempt, he starts living with his grandmother and enrolls in a new school. He even starts wearing ugly-looking glasses to hide his exceptional looks. There, he meets Lily, another victim of the same thing. People fear her and her father just because of their scary features, even though they are nice. However, Kiyu makes the same mistakes as others and judges Lily just like everyone else. Gradually, Kiyu realizes his mistake and the fact that Lily is really nice and kind. Read Your Smile Is A Trap to learn about their blossoming love and the obstacles they face.
    ''',
    '''
    If you ever get a chance to go back and change things you regret now, would you do it? Yeonu is a young and beautiful woman married to Seonjae, a cold and handsome businessman. Her marriage was of convenience and hence there is no love between her and her husband. They tried running the marriage, but ultimately, Yeonu gave up, and they divorced. Due to a series of unfortunate events, Seonjae dies in front of her. However, fate gives her a second chance, and she vows to save Seonjae this time. Read There Must Be Happy Endings to find out whether or not Yeonu was able to save Seonjae and why Seonjae seems to be hiding several secrets.
    ''',
    '''
    The popular webtoon series Seasons of Blossom is a compilation of several individual stories that are all connected. It contains all four seasons: spring, summer, fall, and winter. Each season contains a different story and a different theme with different endings. It focuses majorly on school bullying and how much it can affect someone’s whole life. Despite it being based on high school students, the story has several serious events and a storyline with many variations. Check out this webtoon to learn about each story and their interlinked connections.
    ''',
    '''
    Are you an organized person who keeps track of every detail, disregarding how insignificant it may be, or are you a messy person who goes with the flow? Bareum is a very organized person who even maintains a diary detailing all her events and commitments. She has always had great marks and a clear record of what she wants to do in the future. However, one thing that she has not had any luck with is making a boyfriend. She decides to do things a little differently to achieve this goal and hence joins a programming club despite her planner being full. Fate has different plans in store for her. Read the popular webtoon Romance 101 to find out whether or not she was able to achieve this goal.
    ''',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              ).then((_) {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.bookmarks_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.item.imageUrl),
            Text(
              widget.item.title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            Text('Rating: ${widget.item.rating.toString()} out of 5.0'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Description', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                  Text(
                    itemDescription[widget.item.itemNumber],
                    softWrap: true,
                    maxLines: null,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                  isFavorite ? 'Remove from favorites' : 'Add to favorites'),
              onPressed: () {
                if (widget.item.isFavorite) {
                  favoritesBox.delete(widget.item.itemNumber);
                } else {
                  favoritesBox.put(widget.item.itemNumber, widget.item);
                }
                setState(() {
                  widget.item.isFavorite = !widget.item.isFavorite;
                  isFavorite = isFavorite ? false : true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
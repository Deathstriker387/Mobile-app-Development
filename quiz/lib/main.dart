import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(home: FlashcardApp()));

class FlashcardApp extends StatefulWidget {
  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _cards = [
    {'q': 'What is Flutter?', 'a': 'A UI toolkit'},
    {'q': 'What is Dart?', 'a': 'Programming language'},
    {'q': 'What is a Widget?', 'a': 'UI building block'},
    {'q': 'What is setState?', 'a': 'Updates state'},
    {'q': 'What is Hot Reload?', 'a': 'Live code updates'},
  ];
  var _list = <Map<String, String>>[];
  var _learned = 0;

  @override
  void initState() {
    super.initState();
    _list = List.from(_cards);
  }

 Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _learned = 0;
      _list = List.from(_cards)..shuffle(Random());
    });
  }

  void _remove(int i) {
    final card = _list[i];
    setState(() {
      _list.removeAt(i);
      _learned++;
    });
    _listKey.currentState?.removeItem(
      i,
          (ctx, anim) => SizeTransition(sizeFactor: anim, child: _Card(card)),
    );
  }

  void _add() {
    setState(() => _list.insert(0, _cards[Random().nextInt(_cards.length)]));
    _listKey.currentState?.insertItem(0);
  }

  void _addCustom() async {
    final qCtrl = TextEditingController();
    final aCtrl = TextEditingController();
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add New Question'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qCtrl,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: aCtrl,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (qCtrl.text.isNotEmpty && aCtrl.text.isNotEmpty) {
                Navigator.pop(ctx, {'q': qCtrl.text, 'a': aCtrl.text});
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
    if (result != null) {
      _cards.add(result);
      setState(() => _list.insert(0, result));
      _listKey.currentState?.insertItem(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _list.length + _learned;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('$_learned of $total learned'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (ctx, _) => AnimatedList(
                  key: _listKey,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  initialItemCount: _list.length,
                  itemBuilder: (ctx, i, anim) => SizeTransition(
                    sizeFactor: anim,
                    child: Dismissible(
                      key: Key('$i${_list[i]['q']}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _remove(i),
                      background: Container(color: Colors.green, child: Icon(Icons.check)),
                      child: _Card(_list[i]),
                    ),
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'custom',
            onPressed: _addCustom,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatefulWidget {
  final Map<String, String> data;
  _Card(this.data);

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  var _show = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _show = !_show),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _show ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _show ? widget.data['a']! : widget.data['q']!,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
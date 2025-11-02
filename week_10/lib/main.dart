// ============================================
// CHAPTER 9: CREATING SCROLLING LISTS AND EFFECTS
// Beginning Flutter by Marco L. Napoli
// ============================================

// This file contains all examples from the chapter:
// 1. Card Widget Examples
// 2. ListView.builder with ListTile
// 3. GridView (count, extent, builder)
// 4. Stack Widget
// 5. CustomScrollView with Slivers

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 9 Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenu(),
    );
  }
}

// ============================================
// MAIN MENU
// ============================================
class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 9 - Scrolling Lists & Effects'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _MenuCard(
            title: 'Card Examples',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CardExamples())),
          ),
          _MenuCard(
            title: 'ListView.builder Example',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ListViewExample())),
          ),
          _MenuCard(
            title: 'GridView Examples',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GridViewExamples())),
          ),
          _MenuCard(
            title: 'Stack Example',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StackExample())),
          ),
          _MenuCard(
            title: 'CustomScrollView with Slivers',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomScrollViewExample())),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// ============================================
// 1. CARD WIDGET EXAMPLES
// ============================================
class CardExamples extends StatelessWidget {
  const CardExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Customizations')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Default Card
          Card(
            elevation: 8.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Barista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Travel Plans',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Default', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // StadiumBorder
          Card(
            elevation: 8.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            shape: const StadiumBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Barista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Travel Plans',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Text('StadiumBorder', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // UnderlineInputBorder
          Card(
            elevation: 8.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            shape: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Barista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Travel Plans',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Text('UnderlineInputBorder', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // OutlineInputBorder
          Card(
            elevation: 8.0,
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange.withOpacity(0.5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Barista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  'Travel Plans',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Text('OutlineInputBorder', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ============================================
// 2. LISTVIEW.BUILDER EXAMPLE
// ============================================
class ListViewExample extends StatelessWidget {
  const ListViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView.builder')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return HeaderWidget(index: index);
            } else if (index >= 1 && index <= 3) {
              return RowWithCardWidget(index: index);
            } else {
              return RowWidget(index: index);
            }
          },
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 120.0,
      child: Card(
        elevation: 8.0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Barista',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
                color: Colors.orange,
              ),
            ),
            Text(
              'Travel Plans',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class RowWithCardWidget extends StatelessWidget {
  const RowWithCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.flight,
          size: 48.0,
          color: Colors.lightBlue,
        ),
        title: Text('Airplane $index'),
        subtitle: const Text('Very Cool'),
        trailing: Text(
          '${index * 7}%',
          style: const TextStyle(color: Colors.lightBlue),
        ),
        onTap: () {
          print('Tapped on Row $index');
        },
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.directions_car,
        size: 48.0,
        color: Colors.lightGreen,
      ),
      title: Text('Car $index'),
      subtitle: const Text('Very Cool'),
      trailing: (index % 3).isEven
          ? const Icon(Icons.bookmark_border)
          : const Icon(Icons.bookmark),
      selected: false,
      onTap: () {
        print('Tapped on Row $index');
      },
    );
  }
}

// ============================================
// 3. GRIDVIEW EXAMPLES
// ============================================
class GridViewExamples extends StatelessWidget {
  const GridViewExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GridView Examples'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Count'),
              Tab(text: 'Extent'),
              Tab(text: 'Builder'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GridViewCountExample(),
            GridViewExtentExample(),
            GridViewBuilderExample(),
          ],
        ),
      ),
    );
  }
}

class GridViewCountExample extends StatelessWidget {
  const GridViewCountExample({Key? key}) : super(key: key);

  final List<IconData> _iconList = const [
    Icons.free_breakfast,
    Icons.access_alarms,
    Icons.directions_car,
    Icons.flight,
    Icons.cake,
    Icons.card_giftcard,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(20, (index) {
        print('_buildGridView $index');
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconList[index % _iconList.length],
                  size: 48.0,
                  color: Colors.blue,
                ),
                const Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      }),
    );
  }
}

class GridViewExtentExample extends StatelessWidget {
  const GridViewExtentExample({Key? key}) : super(key: key);

  final List<IconData> _iconList = const [
    Icons.free_breakfast,
    Icons.access_alarms,
    Icons.directions_car,
    Icons.flight,
    Icons.cake,
    Icons.card_giftcard,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 175.0,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(20, (index) {
        print('_buildGridViewExtent $index');
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconList[index % _iconList.length],
                  size: 48.0,
                  color: Colors.blue,
                ),
                const Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      }),
    );
  }
}

class GridViewBuilderExample extends StatelessWidget {
  const GridViewBuilderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.free_breakfast,
      Icons.access_alarms,
      Icons.directions_car,
      Icons.flight,
      Icons.cake,
      Icons.card_giftcard,
      Icons.change_history,
      Icons.face,
      Icons.star,
      Icons.headset_mic,
      Icons.directions_walk,
      Icons.sentiment_satisfied,
      Icons.cloud_queue,
      Icons.exposure,
      Icons.gps_not_fixed,
      Icons.child_friendly,
      Icons.child_care,
      Icons.edit_location,
      Icons.event_seat,
      Icons.lightbulb_outline,
    ];

    return GridView.builder(
      itemCount: 20,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        print('_buildGridViewBuilder $index');
        return Card(
          color: Colors.lightGreen.shade50,
          margin: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconList[index],
                  size: 48.0,
                  color: Colors.lightGreen,
                ),
                const Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      },
    );
  }
}

// ============================================
// 4. STACK EXAMPLE
// ============================================
class StackExample extends StatelessWidget {
  const StackExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack Example')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            if (index.isEven) {
              return const StackWidget();
            } else {
              return const StackFavoriteWidget();
            }
          },
        ),
      ),
    );
  }
}

class StackWidget extends StatelessWidget {
  const StackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 400,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100),
            );
          },
        ),
        Positioned(
          bottom: 10.0,
          left: 10.0,
          child: CircleAvatar(
            radius: 48.0,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1614027164847-1b28cfe1df60?w=400',
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Text(
            'Lion',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(0.3),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class StackFavoriteWidget extends StatelessWidget {
  const StackFavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Image.network(
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 400,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 100),
                );
              },
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: FractionalTranslation(
                translation: const Offset(0.3, -0.3),
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.white30,
                  child: const Icon(
                    Icons.star,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: CircleAvatar(
                radius: 48.0,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1598439210625-5067c578f3f6?w=400',
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: Text(
                'Bald Eagle',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// 5. CUSTOMSCROLLVIEW WITH SLIVERS
// ============================================
class CustomScrollViewExample extends StatelessWidget {
  const CustomScrollViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView - Slivers'),
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBarWidget(),
          const SliverListWidget(),
          const SliverGridWidget(),
        ],
      ),
    );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.brown,
      forceElevated: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Parallax Effect'),
        background: Image.network(
          'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100),
            );
          },
        ),
      ),
    );
  }
}

class SliverListWidget extends StatelessWidget {
  const SliverListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
              child: Text("${index + 1}"),
            ),
            title: Text('Row ${index + 1}'),
            subtitle: Text('Subtitle Row ${index + 1}'),
            trailing: const Icon(Icons.star_border),
          );
        }),
      ),
    );
  }
}

class SliverGridWidget extends StatelessWidget {
  const SliverGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.child_friendly,
                    size: 48.0,
                    color: Colors.amber,
                  ),
                  const Divider(),
                  Text('Grid ${index + 1}'),
                ],
              ),
            );
          },
          childCount: 12,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
      ),
    );
  }
}

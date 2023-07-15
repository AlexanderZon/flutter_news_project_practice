import 'package:flutter/material.dart';
import 'package:news_project/src/models/news_models.dart';
import 'package:news_project/src/theme/theme.dart';

class NewsList extends StatelessWidget {

  final List<Article> news_list;

  const NewsList(this.news_list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news_list.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(item: news_list[index], index: index,);
      }
    );
  }
}

class _New extends StatelessWidget {

  final Article item;
  final int index;
  const _New({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(item: item, index: index,),
        _CardTitle(item),
        _CardImage(item),
        _CardDescription(item),
        _CardActions(),
        SizedBox(height: 10,),
        Divider()
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: themeData.colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ]
      ),
    );
  }
}

class _CardDescription extends StatelessWidget {

  final Article item;

  const _CardDescription(this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(item.description != null ? item.description! : ''),
    );
  }
}

class _CardImage extends StatelessWidget {

  final Article item;

  const _CardImage(this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: item.urlToImage != null
            ? FadeInImage(
              placeholder: AssetImage('assets/images/giphy.gif'), 
              image: NetworkImage(item.urlToImage!)
            )
            : Image(image: AssetImage('assets/images/no-image.png'))
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {

  final Article item;
  
  const _CardTitle(this.item, {
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TopBarCard extends StatelessWidget {

  final Article item;
  final int index;
  const _TopBarCard({
    super.key, required this.item, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index+1}. ', style: TextStyle(color: themeData.colorScheme.secondary),),
          Text('${item.source.name}. ', style: TextStyle(color: themeData.colorScheme.secondary),)
        ],
      ),
    );
  }
}
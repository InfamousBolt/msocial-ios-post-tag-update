// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../modules/feeds/models/post.dart';
import '../modules/feeds/pages/posts/widgets/post_item.dart';
import 'AlgoliaApplication.dart';
import 'models/image.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  String _searchTerm;

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("posts").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            //physics: NeverScrollableScrollPhysics(),
              children:<Widget>[
                TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchTerm = val;
                      });
                    },
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 25),
                        border: InputBorder.none,
                        hintText: 'Search for posts',
                        //hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: BackButton(),
                    ),
                    autofocus: true,
                ),
                Divider(height: 5,),
                StreamBuilder<List<AlgoliaObjectSnapshot>>(
                  stream: Stream.fromFuture(_operation(_searchTerm)),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Container();
                    } else{
                      List<AlgoliaObjectSnapshot> currSearchStuff = snapshot.data;

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return Container();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Expanded(
                              child: CustomScrollView(
                                shrinkWrap: true,
                                slivers: <Widget>[

                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                          ( context,  index) {
                                            if(currSearchStuff[index].data["image"] == null && _searchTerm.isNotEmpty){

                                              return DisplaySearchResult(id: currSearchStuff[index].data["id"].toString(), authorID: currSearchStuff[index].data["authorID"].toString(),
                                                authorName: currSearchStuff[index].data["authorName"].toString(),createdAt: currSearchStuff[index].data["createdAt"], updatedAt: currSearchStuff[index].data["updatedAt"],
                                                content: currSearchStuff[index].data["content"].toString(), userLikes: currSearchStuff[index].data["usersLikes"].toString(), commentsIDs: currSearchStuff[index].data["commentsIDs"].toString(),
                                              );
                                            }
                                        return _searchTerm.isNotEmpty ? DisplaySearchResult(id: currSearchStuff[index].data["id"].toString(), authorID: currSearchStuff[index].data["authorID"].toString(),
                                            authorName: currSearchStuff[index].data["authorName"].toString(),createdAt: currSearchStuff[index].data["createdAt"], updatedAt: currSearchStuff[index].data["updatedAt"], imagePath: currSearchStuff[index].data["image"]["path"].toString(),
                                            imageHeight: currSearchStuff[index].data["image"]["height"].toString(), imageWidth: currSearchStuff[index].data["image"]["width"].toString(), content: currSearchStuff[index].data["content"].toString(),
                                            userLikes: currSearchStuff[index].data["usersLikes"].toString(), commentsIDs: currSearchStuff[index].data["commentsIDs"].toString()
                                            ) :
                                            Container();

                                      },
                                      childCount: currSearchStuff.length ?? 0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } }}
                  },
                ),
              ]),
        ),
      ),
    );
  }

}

class DisplaySearchResult extends StatelessWidget {
  final String id;
  final String authorID;
  final String authorName;
  final createdAt;
  final updatedAt;
  final String content;
  final String imagePath;
  final String imageHeight;
  final String imageWidth;
  final String userLikes;
  final String commentsIDs;

  const DisplaySearchResult({Key key, this.id, this.authorID, this.authorName, this.createdAt, this.updatedAt, this.content, this.imagePath, this.imageHeight, this.imageWidth, this.userLikes, this.commentsIDs}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int createdAtSeconds = createdAt["_seconds"] as int;
    final int updatedAtSeconds = updatedAt["_seconds"] as int;
    List<String> userLikesList;
    List<String> commentIDList;
    final createdDate = DateTime.fromMillisecondsSinceEpoch(createdAtSeconds * 1000);
    final updatedDate = DateTime.fromMillisecondsSinceEpoch(updatedAtSeconds * 1000);
    print("USERLIKESSS $userLikes");
    final String userLikesStrip = userLikes.substring(1, userLikes.length-1);
    if(userLikesStrip.contains(', ')){
      userLikesList = userLikesStrip.split(', ');
    }else{
      userLikesList = [userLikesStrip];
    }
    final String commentIDStrip = commentsIDs.substring(1, commentsIDs.length-1);
    if(commentIDStrip.contains(', ')){
      commentIDList = commentIDStrip.split(', ');
    }else{
      commentIDList = [commentIDStrip];
    }

    Post p;

    if(imagePath == null){
      p = Post(commentsIDs: commentIDList,usersLikes: userLikesList, authorID: authorID, content: content, id: id, createdAt: createdDate, updatedAt: updatedDate, authorName: authorName, authorPhotoURL: '', );
    }else{
      ImageModel image = ImageModel(imagePath);
      p = Post(commentsIDs: commentIDList,usersLikes: userLikesList,image: image, authorID: authorID, content: content, id: id, createdAt: createdDate, updatedAt: updatedDate, authorName: authorName, authorPhotoURL: '', );
    }
    return Column(
        children: <Widget>[


          PostWidget(p),
          // Text(authorName ?? "", style: TextStyle(color: Colors.black ),),
          // SizedBox(height: 80,),
          // Text(content ?? "", style: TextStyle(color: Colors.black ),),
          // SizedBox(height: 80,),
          // Text(authorID ?? "", style: TextStyle(color: Colors.black ),),
          // SizedBox(height: 80,),
          // Text(imageHeight ?? "", style: TextStyle(color: Colors.black ),),
          // SizedBox(height: 80,),



          // Divider(color: Colors.black,),
          // SizedBox(height: 20)
        ]
    );
  }
}
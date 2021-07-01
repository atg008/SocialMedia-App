import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/stream_story_builder.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/utils/firebase.dart';

class StoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 130.0,
      child: StreamStoriesWrapper(
        reverse: true,
        scrollDirection: Axis.horizontal,
        stream: storyRef.snapshots(),
        itemBuilder: (BuildContext context, DocumentSnapshot snapshot) {
           PostModel story = PostModel.fromJson(snapshot.data());
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Stack(
              children: [
                Container(
                  height: 95.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(story.mediaUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 70.0,
                  right: 25.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: new Offset(0.0, 0.0),
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/cm0.jpeg'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
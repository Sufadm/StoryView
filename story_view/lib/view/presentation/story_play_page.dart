import 'package:flutter/material.dart';
import 'package:story_view_task/model/story_model.dart';

// ignore: must_be_immutable
class StoryDetailsPage extends StatelessWidget {
  Story story;
  StoryDetailsPage({required this.story, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(story.image.toString()),
    );
  }
}

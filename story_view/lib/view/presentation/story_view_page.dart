import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:story_view_task/controller/controller.dart';
import 'package:story_view_task/view/widgets/card_widget.dart';
import 'package:story_view_task/view/widgets/message_ui__widget.dart';

class StoryViewPage extends StatelessWidget {
  StoryViewPage({Key? key}) : super(key: key);
  final pagecontroller = PageController();
  final controller = StoryController();
  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    return Scaffold(
      //appbar---
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 180,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 229, 228, 228),
              ),
              child: const Row(
                children: [
                  Text(
                    "  University Assistant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Icon(Icons.dashboard),
                ],
              ),
            ),
          )
        ],
        title: const Text(
          "AceApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.network(
              "https://play-lh.googleusercontent.com/VFSngB3RXIl4GiZZU6tz0L9L9eszAVkT90EFJRWvJ8ZdFV8NaJy782_TqsYdfnpX0vw"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              //student two widget---
              cardWidget(),
              const SizedBox(
                height: 7,
              ),

              //Retrieving datas from server
              Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  final data = value.storyData;
                  if (data.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final category = data[index];
                          final stories = category.stories;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            //adding stories (images and videos) in story items---
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    List<StoryItem> storyItems = [];
                                    try {
                                      for (var story in stories) {
                                        if (story.image != null &&
                                            story.image!.isNotEmpty) {
                                          storyItems.add(
                                            StoryItem.pageImage(
                                              url: story.image!,
                                              controller: controller,
                                            ),
                                          );
                                        } else if (story.videoLink != null &&
                                            story.videoLink!.isNotEmpty) {
                                          storyItems.add(
                                            StoryItem.pageVideo(
                                              story.videoLink!,
                                              controller: controller,
                                            ),
                                          );
                                        }
                                      }
                                      if (storyItems.isEmpty) {
                                        throw Exception(
                                            'No valid stories found.');
                                      }

                                      //Storie view page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            List<StoryItem> currentStoryItems =
                                                List.from(storyItems);
                                            return Scaffold(
                                              body: Stack(
                                                children: [
                                                  StoryView(
                                                    storyItems:
                                                        currentStoryItems,
                                                    controller: controller,
                                                    repeat: false,
                                                    onStoryShow:
                                                        (storyItem, index) {},
                                                    onComplete: () {
                                                      Navigator.pop(context);
                                                    },
                                                    onVerticalSwipeComplete:
                                                        (direction) {
                                                      if (direction ==
                                                          Direction.down) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                  //profile pic, name,comment,share button widgets
                                                  StoryProfileView(
                                                      url: category.image
                                                          .toString(),
                                                      name: category.name!),
                                                  const MessageSendWidget(),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } catch (e, stackTrace) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 1),
                                          content:
                                              Text('Error loading stories'),
                                        ),
                                      );
                                    }
                                  },
                                  //border of circles----
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          category.image.toString()),
                                      radius: 35,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  category.name!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view_task/controller/controller.dart';
import 'package:story_view_task/view/widgets/card_widget.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 180,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color.fromARGB(255, 229, 228, 228),
              ),
              child: const Row(
                children: [
                  Text(
                    "  University Assistant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Icon(Icons.account_balance_rounded)
                ],
              ),
            ),
          )
        ],
        title: const Text(
          "AceApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(
          Icons.import_contacts,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              cardWidget(),
              const SizedBox(
                height: 7,
              ),
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
                            child: Column(
                              children: [
                                InkWell(
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
                                                        (storyItem, index) {
                                                      // setState(() {
                                                      //   currentStoryItems[index]
                                                      //       .duration;
                                                      // });
                                                    },
                                                    onComplete: () {
                                                      // controller.next();
                                                      // final currentindex =
                                                      //     currentStoryItems.indexOf(
                                                      //         currentStoryItems[
                                                      //             index]);
                                                      // final isLastpage =
                                                      //     currentStoryItems
                                                      //                 .length -
                                                      //             1 ==
                                                      //         currentindex;
                                                      // if (isLastpage) {
                                                      //   Navigator.pop(context);
                                                      // }
                                                    },
                                                    onVerticalSwipeComplete:
                                                        (direction) {
                                                      if (direction ==
                                                          Direction.down) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                  _buildOverlayWidgets(
                                                      category.image.toString(),
                                                      category.name!),
                                                  _buildOverlayWidget(),
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
                                          content:
                                              Text('Error loading stories'),
                                        ),
                                      );
                                    }
                                  },
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

  Widget _buildOverlayWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayWidgets(String url, String name) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundImage: NetworkImage(url),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

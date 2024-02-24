import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view_task/controller/controller.dart';
import 'package:story_view_task/view/widgets/card_widget.dart';

class StoryViewPage extends StatelessWidget {
  final controller = StoryController();
  StoryViewPage({Key? key}) : super(key: key);

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
                          final story = data[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StoryView(
                                        storyItems: story.stories!
                                            .map((story) => StoryItem(
                                                  Image.network(
                                                    story.image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 15),
                                                ))
                                            .toList(),
                                        controller: controller,
                                        repeat: true,
                                        onStoryShow: (storyItem, index) {},
                                        onComplete: () {},
                                        onVerticalSwipeComplete: (direction) {
                                          if (direction == Direction.down) {
                                            Navigator.pop(context);
                                          }
                                        },
                                      );
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.red, width: 2.0)),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          NetworkImage(story.image!),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  story.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
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

import 'package:flutter/material.dart';
import 'package:story_view_task/view/widgets/card_widget.dart';

class StoryViewPage extends StatelessWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(radius: 35),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clone_whatsapp_round34/src/core/theme/app_color.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/chats_list.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/group_list.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? const Text("WhatsApp")
              : TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search by name",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchController.clear();
                    searchText = "";
                  }
                  isSearching = !isSearching;
                });
              },
            ),
            PopupMenuButton<MenuSelection>(
              itemBuilder: (_) => MenuButton.menuItems,
              onSelected: (value) {},
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.secondary,
              child: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  const Tab(icon: Icon(Icons.people)),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Chats"),
                        const SizedBox(width: 5),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "10",
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Tab(text: "Status"),
                  const Tab(text: "Calls"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  GroupList(searchText: searchText),
                  // هنا بنمرر النص للفلترة
                  ChatsList(searchText: searchText),
                  Center(child: Text("Status")),
                  Center(child: Text("Calls")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

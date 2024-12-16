import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekber_markas/widgets/event_card.dart'; // Make sure this is imported
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}
class _EventScreenState extends State<EventScreen> {
  String activeTab = 'All';
  final List<String> tabs = ['All', 'Hustler', 'Hacker', 'Hipster'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event',
          style: TextStyle(
            color: Color(0xFF212729),
            fontFamily: "Open Sans",
            fontSize: 31,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.93,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/filter.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tab Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.map((tab) {
                  final isActive = activeTab == tab;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = tab;
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            tab,
                            style: TextStyle(
                              color: isActive ? Colors.black : Colors.grey,
                              fontFamily: "Open Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isActive)
                          Container(
                            height: 3,
                            width: 30,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Section Content
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('event')
                    .where('category', isEqualTo: activeTab == 'All' ? null : activeTab)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error memuat data event: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final events = snapshot.data!.docs;
                  if (events.isEmpty) {
                    return Center(child: Text("Tidak ada event tersedia."));
                  }
                  return ListView(
                    children: [
                      if (activeTab == 'All' || activeTab == 'Hustler')
                        buildSection('Hustler', events),
                      if (activeTab == 'All' || activeTab == 'Hacker')
                        buildSection('Hacker', events),
                      if (activeTab == 'All' || activeTab == 'Hipster')
                        buildSection('Hipster', events),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSection(String title, List<QueryDocumentSnapshot> events) {
    final categoryEvents = events
        .where((event) => event['category'] == title)
        .toList();
    return categoryEvents.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF212121),
                  fontFamily: "Open Sans",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryEvents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: EventCard(eventData: categoryEvents[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
  }
}

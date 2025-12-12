import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // البروفايل
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.teal,
                    child: Text(
                      'R',
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Remedy(Friend)',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '+1 20135 14000',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(Icons.call, 'Audio'),
                      _buildButton(Icons.videocam, 'Video'),
                      _buildButton(Icons.payment, 'Pay'),
                      _buildButton(Icons.search, 'Search'),
                    ],
                  ),
                ],
              ),
            ),
            
            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),


            // About 
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Waiting for Me?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1 Jan 2006',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),

            Container(
              color: Colors.white,
              child: _buildItem(Icons.photo_library, 'Media, links, and docs'),
            ),

            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),

            Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                          children: [
                             Icon(Icons.notifications, color: Colors.teal),
                             SizedBox(width: 12),
                             Text(
                              'Mute Notifications',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                            ],
                          ),
                        ),
                        Switch(
                          value: false,
                          onChanged: (value) {},
                          activeColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),

            // Notifications
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  
                  _buildItem(Icons.music_note, 'Custom notifications'),
                  _buildItem(Icons.photo, 'Media visibility'),
                  _buildItem(Icons.star, 'Started messages'),
                ],
              ),
            ),

            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),

            // Encryption
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lock, color: Colors.teal),
                            const SizedBox(width: 12),
                            const Text(
                              'Encryption',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding: EdgeInsets.only(left: 44),
                          child: Text(
                            'You know you can see more for next encrypted.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timer, color: Colors.teal), // Added Icon
                                  SizedBox(width: 12), // Added SizedBox for spacing
                                  Text('Disappearing Messages'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text('Off', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                 
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline, color: Colors.teal),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lock, color: Colors.teal), // Added Icon
                                  SizedBox(width: 12), // Added SizedBox for spacing
                                  Text('Chat Lock'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text('Lock and hide this chat on this device.',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            

            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),


            // Groups
          
                      
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildItem(Icons.group, '0 Groups in common'),
                _buildItem(Icons.group_add, 'Create group with Reonsly(Friend)'),
              ],
            ),
          ),

            

            
            Container(
              height: 20,
              color: Colors.grey[50], 
            ),


            // Block & Report
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    color: Colors.red[50],
                    child: ListTile(
                      leading: Icon(Icons.block, color: Colors.red[800]),
                      title: const Text('Block Jimmy(Friend)',
                       style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600, // اللون الأحمر
                          color: Color(0xFFC62828),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    ),
                  ),
                  Container(
                    color: Colors.red[50],
                    child: ListTile(
                      leading: Icon(Icons.report, color: Colors.red.shade800),
                      title: Text('Report Jimmy(Friend)',
                        style: TextStyle(
                          fontSize: 17, // اللون الأحمر
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade800,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: Icon(icon, color: Colors.teal, size: 30),
        ),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }

  Widget _buildItem(IconData icon, String text) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(text),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        ),
        
      ],
    );
  }
}
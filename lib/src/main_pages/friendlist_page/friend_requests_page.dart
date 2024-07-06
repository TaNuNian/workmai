import 'package:flutter/material.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  final FriendService _friendService = FriendService();
  late Future<List<Map<String, dynamic>>> _friendRequestsFuture;

  @override
  void initState() {
    super.initState();
    _friendRequestsFuture = _friendService.fetchFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => _friendRequestsModal(),
            );
          },
          child: Text('Show Friend Requests'),
        ),
      ),
    );
  }

  Widget _friendRequestsModal() {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _friendRequestsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No friend requests'));
            } else {
              final friendRequests = snapshot.data!;
              return ListView.builder(
                controller: scrollController,
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  final request = friendRequests[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: request['profilePicture'] != null
                          ? NetworkImage(request['profilePicture'])
                          : AssetImage('assets/default_profile.png') as ImageProvider,
                    ),
                    title: Text(request['displayName'] ?? 'No Display Name'),
                    subtitle: Text('@${request['name']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () async {
                            await _friendService.acceptFriendRequest(request['uid']);
                            setState(() {
                              _friendRequestsFuture = _friendService.fetchFriendRequests();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () async {
                            await _friendService.declineFriendRequest(request['uid']);
                            setState(() {
                              _friendRequestsFuture = _friendService.fetchFriendRequests();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

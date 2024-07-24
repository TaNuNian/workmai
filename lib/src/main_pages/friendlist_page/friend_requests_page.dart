import 'package:flutter/material.dart';
import 'package:workmai/methods/cloud_firestore/friendservice.dart';

class FriendRequestsModal extends StatefulWidget {
  final FriendService friendService;

  const FriendRequestsModal({Key? key, required this.friendService})
      : super(key: key);

  @override
  _FriendRequestsModalState createState() => _FriendRequestsModalState();
}

class _FriendRequestsModalState extends State<FriendRequestsModal> {
  late Future<List<Map<String, dynamic>>> _friendRequestsFuture;

  @override
  void initState() {
    super.initState();
    _friendRequestsFuture = widget.friendService.fetchFriendRequests();
  }

  Future<void> _handleFriendRequest(String uid, bool accept) async {
    try {
      if (accept) {
        await widget.friendService.acceptFriendRequest(uid);
      } else {
        await widget.friendService.declineFriendRequest(uid);
      }
      // Reload friend requests after action
      setState(() {
        _friendRequestsFuture = widget.friendService.fetchFriendRequests();
      });
    } catch (e) {
      print('Error handling friend request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _friendRequestsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No friend requests'));
            } else {
              return ListView.builder(
                controller: scrollController,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final request = snapshot.data![index];
                  return ListTile(
                    leading: request['profilePicture'] != ''
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(request['profilePicture']),
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                    title: Text(
                      request['displayName'] == ''
                          ? 'Display Name'
                          : request['displayNames'],
                    style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                    subtitle: Text('@${request['name']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () =>
                              _handleFriendRequest(request['uid'], true),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () =>
                              _handleFriendRequest(request['uid'], false),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/co_worker_service.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CoWorkerService _coWorkerService = CoWorkerService();

  Future<Map<String, dynamic>?> _getRequestData(String requestId) async {
    final requestDoc =
    await _firestore.collection('matchingRequest').doc(requestId).get();
    return requestDoc.data() as Map<String, dynamic>?;
  }

  Widget _buildReceivedRequestTile(Map<String, dynamic> requestData, String requestId) {
    final senderId = requestData['senderId'];
    final message = requestData['message'];
    final timestamp = requestData['timestamp'] as Timestamp;
    final mode = requestData['mode'];

    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('users').doc(senderId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return ListTile(
            title: Text('Error loading sender data'),
          );
        }

        final senderData = snapshot.data!.data() as Map<String, dynamic>?;
        if (senderData == null) {
          return ListTile(
            title: Text('Invalid sender data'),
          );
        }
        final senderProfile = senderData['profile'];
        final displayName = senderProfile['display_name'] ?? 'N/A';
        final profilePicture = senderProfile['profilePicture'] ?? '';

        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
            profilePicture.isNotEmpty ? NetworkImage(profilePicture) : null,
            child: profilePicture.isEmpty ? Icon(Icons.person) : null,
          ),
          title: Text(
            'Find "$mode"',
            style:
            GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Sent at: ${timestamp.toDate()}',
            style: GoogleFonts.raleway(fontSize: 14),
          ),
          onTap: () {
            _showReceivedRequestBottomSheet(context, senderProfile, message, requestId);
          },
        );
      },
    );
  }

  Widget _buildSentRequestTile(Map<String, dynamic> requestData) {
    final profileImage = requestData['profileImage'];
    final message = requestData['message'];
    final timestamp = requestData['timestamp'] as Timestamp;
    final mode = requestData['mode'];
    final statuses = requestData['statuses'] as Map<String, dynamic>;

    // Count responses
    final responseCount =
        statuses.values.where((status) => status != 'pending').length;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
        profileImage.isNotEmpty ? NetworkImage(profileImage) : null,
        child: profileImage.isEmpty ? Icon(Icons.group) : null,
      ),
      title: Text(
        'Invite "$mode"',
        style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sent at: ${timestamp.toDate()}',
            style: GoogleFonts.raleway(fontSize: 14),
          ),
          Text(
            'Responses: $responseCount',
            style: GoogleFonts.raleway(fontSize: 14),
          ),
        ],
      ),
      onTap: () {
        _showStatusBottomSheet(context, requestData['statuses']);
      },
    );
  }

  void _showReceivedRequestBottomSheet(BuildContext context, Map<String, dynamic> senderProfile, String message, String requestId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: senderProfile['profilePicture'].isNotEmpty
                      ? NetworkImage(senderProfile['profilePicture'])
                      : null,
                  child: senderProfile['profilePicture'].isEmpty
                      ? Icon(Icons.person)
                      : null,
                ),
                title: Text(
                  senderProfile['display_name'] ?? 'N/A',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(senderProfile['name'] ?? 'N/A'),
              ),
              SizedBox(height: 16),
              Text(
                'Message:',
                style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                message,
                style: GoogleFonts.raleway(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _coWorkerService.acceptMatchingRequest(requestId, _auth.currentUser!.uid);
                      Navigator.pop(context); // Close the bottom sheet
                      setState(() {});
                    },
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _coWorkerService.rejectMatchingRequest(requestId, _auth.currentUser!.uid, 'User rejected the request');
                      Navigator.pop(context); // Close the bottom sheet
                      setState(() {}); // Refresh the inbox page to remove the tile
                    },
                    child: Text('Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStatusBottomSheet(
      BuildContext context, Map<String, dynamic> statuses) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: statuses.length,
          itemBuilder: (context, index) {
            final uid = statuses.keys.elementAt(index);
            final status = statuses[uid];
            IconData statusIcon;
            Color iconColor;

            switch (status) {
              case 'accepted':
                statusIcon = Icons.check_circle;
                iconColor = Colors.green;
                break;
              case 'rejected':
                statusIcon = Icons.cancel;
                iconColor = Colors.red;
                break;
              case 'pending':
              default:
                statusIcon = Icons.hourglass_empty;
                iconColor = Colors.grey;
                break;
            }

            return FutureBuilder<DocumentSnapshot>(
              future: _firestore.collection('users').doc(uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return ListTile(
                    title: Text('Error loading user data'),
                  );
                }
                final userData = snapshot.data!.data() as Map<String, dynamic>?;
                if (userData == null) {
                  return ListTile(
                    title: Text('Invalid user data'),
                  );
                }
                final profile = userData['profile'];
                final displayName = profile['display_name'] == '' ? 'Display Name': profile['display_name'];
                final profilePicture = profile['profilePicture'] ?? '';
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: profilePicture.isNotEmpty
                        ? NetworkImage(profilePicture)
                        : null,
                    child: profilePicture.isEmpty ? Icon(Icons.person) : null,
                  ),
                  title: Text(displayName,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Status: $status'),
                  trailing: Icon(statusIcon, color: iconColor),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Requests Received'),
              Tab(text: 'Requests Sent'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildReceivedRequests(),
            _buildSentRequests(),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedRequests() {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Center(child: Text('No user logged in.'));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data available.'));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData == null || !userData.containsKey('matchRequests') || userData['matchRequests']['senderId'] == null) {
          return Center(child: Text('No requests found.'));
        }

        final matchRequests = userData['matchRequests'] as Map<String, dynamic>;
        final receivedRequests = matchRequests['senderId'] as List<dynamic>;

        if (receivedRequests.isEmpty) {
          return Center(child: Text('No requests found.'));
        }

        return ListView.builder(
          itemCount: receivedRequests.length,
          itemBuilder: (context, index) {
            final requestId = receivedRequests[index];
            return FutureBuilder<Map<String, dynamic>?>(
              future: _getRequestData(requestId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return ListTile(
                    title: Text('Error loading request data'),
                  );
                }
                return _buildReceivedRequestTile(snapshot.data!, requestId);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSentRequests() {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Center(child: Text('No user logged in.'));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('users').doc(currentUser.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data available.'));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData == null || !userData.containsKey('matchRequests') || userData['matchRequests']['receiverId'] == null) {
          return Center(child: Text('No requests found.'));
        }

        final matchRequests = userData['matchRequests'] as Map<String, dynamic>;
        final sentRequests = matchRequests['receiverId'] as List<dynamic>;

        if (sentRequests.isEmpty) {
          return Center(child: Text('No requests found.'));
        }

        return ListView.builder(
          itemCount: sentRequests.length,
          itemBuilder: (context, index) {
            final requestId = sentRequests[index];
            return FutureBuilder<Map<String, dynamic>?>(
              future: _getRequestData(requestId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return ListTile(
                    title: Text('Error loading request data'),
                  );
                }
                return _buildSentRequestTile(snapshot.data!);
              },
            );
          },
        );
      },
    );
  }
}

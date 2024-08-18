import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewOthersProfilePage extends StatelessWidget {
  final String userId;

  const ViewOthersProfilePage({Key? key, required this.userId}) : super(key: key);

  Future<DocumentSnapshot> _getUserProfile() {
    return FirebaseFirestore.instance.collection('activeUsers').doc(userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: const Color(0xFF1045A6),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final profilePicture = data['profilePicture'] ?? '';
          final name = data['name'] ?? '';
          final lastName = data['lastName'] ?? '';
          final email = data['email'] ?? '';
          final username = data['username'] ?? '';
          final biography = data['biography'] ?? '';
          final birthDate = data['birthDate'] ?? 'N/A';
          final memberOf = (data['memberOf'] as List<dynamic>?) ?? [];
          final hobbies = (data['hobbies'] as List<dynamic>?)?.join(', ') ?? 'N/A';
          final favoriteQuotes = (data['favoriteQuotes'] as List<dynamic>?)?.join(', ') ?? 'N/A';
          final badges = (data['badges'] as List<dynamic>?)?.map((badge) => badge['name']).join(', ') ?? 'N/A';
          final socialLinks = data['socialLinks'] as Map<String, dynamic>?;
          final civilStatus = data['civilStatus'] ?? '';
          final cardNumber = data['cardNumber']?.toString() ?? 'N/A';
          final userClass = data['class'] ?? '';
          final origin = data['origin'] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profilePicture.isNotEmpty
                        ? NetworkImage(profilePicture)
                        : const AssetImage('images/nablabakgrunn.jpg') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Text(
                    '$name $lastName',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: Text(
                    email,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(),
                _buildCategoryHeader('Personal Information'),
                _buildProfileField('Username', username),
                _buildProfileField('Biography', biography),
                _buildProfileField('Birth Date', birthDate),
                _buildProfileField('Civil Status', civilStatus),
                _buildProfileField('Card Number', cardNumber),
                _buildProfileField('Class', userClass),
                _buildProfileField('Origin', origin),
                const Divider(),
                _buildCategoryHeader('Engagement'),
                _buildProfileField('Member Of', memberOf.isNotEmpty ? memberOf.join(', ') : 'N/A'),
                _buildProfileField('Hobbies', hobbies),
                _buildProfileField('Favorite Quotes', favoriteQuotes),
                _buildProfileField('Badges', badges),
                const Divider(),
                _buildCategoryHeader('Social Links'),
                _buildSocialLinks(socialLinks),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1045A6)),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(Map<String, dynamic>? socialLinks) {
    if (socialLinks == null || socialLinks.isEmpty) {
      return const Text('No social links available');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (socialLinks.containsKey('instagram'))
          _buildSocialLinkIcon('Instagram', socialLinks['instagram'], 'assets/instagram.png'),
        if (socialLinks.containsKey('facebook'))
          _buildSocialLinkIcon('Facebook', socialLinks['facebook'], 'assets/facebook.png'),
        if (socialLinks.containsKey('linkedin'))
          _buildSocialLinkIcon('LinkedIn', socialLinks['linkedin'], 'assets/linkedin.png'),
        if (socialLinks.containsKey('snapchat'))
          _buildSocialLinkIcon('Snapchat', socialLinks['snapchat'], 'assets/snapchat.png'),
      ],
    );
  }

  Widget _buildSocialLinkIcon(String label, String url, String iconPath) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(iconPath),
            radius: 24.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}

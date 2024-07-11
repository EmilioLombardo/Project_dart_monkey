import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  // Controllers for editable fields
  final _usernameController = TextEditingController();
  final _biographyController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _classController = TextEditingController();
  final _originController = TextEditingController();
  final _hobbiesController = TextEditingController();
  final _favoriteQuotesController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _snapchatController = TextEditingController();

  Map<String, TextEditingController> _committeeControllers = {};

  Future<DocumentSnapshot> _getUserProfile() {
    return _firestore.collection('activeUsers').doc(widget.userId).get();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await _firestore.collection('activeUsers').doc(widget.userId).update({
        'username': _usernameController.text,
        'biography': _biographyController.text,
        'birthDate': _birthDateController.text,
        'civilStatus': _civilStatusController.text,
        'cardNumber': int.parse(_cardNumberController.text),
        'class': _classController.text,
        'origin': _originController.text,
        'hobbies': _hobbiesController.text.split(',').map((e) => e.trim()).toList(),
        'favoriteQuotes': _favoriteQuotesController.text.split(',').map((e) => e.trim()).toList(),
        'socialLinks': {
          'instagram': _instagramController.text,
          'facebook': _facebookController.text,
          'linkedin': _linkedinController.text,
          'snapchat': _snapchatController.text,
        },
      });

      // Update committee biographies
      for (var entry in _committeeControllers.entries) {
        String committeeName = entry.key;
        String biographyText = entry.value.text;

        // Find the committee document with the matching name
        QuerySnapshot committeeSnapshot = await _firestore
            .collection('komiteer')
            .where('name', isEqualTo: committeeName)
            .get();

        if (committeeSnapshot.docs.isNotEmpty) {
          DocumentSnapshot committeeDoc = committeeSnapshot.docs.first;

          // Update the biography in activeMembers and unactiveMembers
          Map<String, dynamic> committeeData = committeeDoc.data() as Map<String, dynamic>;
          bool updated = false;

          for (var memberType in ['activeMembers', 'unactiveMembers']) {
            if (committeeData.containsKey(memberType)) {
              Map<String, dynamic> members = Map<String, dynamic>.from(committeeData[memberType]);
              members.forEach((key, value) {
                if (value['username'] == _usernameController.text) {
                  members[key]['biography'] = biographyText;
                  committeeData[memberType] = members;
                  updated = true;
                }
              });
            }
          }

          if (updated) {
            await _firestore.collection('komiteer').doc(committeeDoc.id).update(committeeData);
          }
        }
      }

      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: const Color(0xFF1045A6),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveProfile,
            )
          else
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
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

          // Initialize controllers with data
          _usernameController.text = username;
          _biographyController.text = biography;
          _birthDateController.text = birthDate;
          _civilStatusController.text = civilStatus;
          _cardNumberController.text = cardNumber;
          _classController.text = userClass;
          _originController.text = origin;
          _hobbiesController.text = hobbies;
          _favoriteQuotesController.text = favoriteQuotes;
          _instagramController.text = socialLinks?['instagram'] ?? '';
          _facebookController.text = socialLinks?['facebook'] ?? '';
          _linkedinController.text = socialLinks?['linkedin'] ?? '';
          _snapchatController.text = socialLinks?['snapchat'] ?? '';

          // Initialize committee controllers
          for (String committee in memberOf) {
            _committeeControllers[committee] = TextEditingController();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: [
                      _buildEditableProfileField('Username', _usernameController),
                      _buildEditableProfileField('Biography', _biographyController),
                      _buildEditableProfileField('Birth Date', _birthDateController),
                      _buildEditableProfileField('Civil Status', _civilStatusController),
                      _buildEditableProfileField('Card Number', _cardNumberController, keyboardType: TextInputType.number),
                      _buildEditableProfileField('Class', _classController),
                      _buildEditableProfileField('Origin', _originController),
                    ],
                  ),
                  const Divider(),
                  _buildCategoryHeader('Engagement'),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: [
                      _buildProfileField('Member Of', memberOf.isNotEmpty ? memberOf.join(', ') : 'N/A'),
                      _buildEditableProfileField('Hobbies', _hobbiesController),
                      _buildEditableProfileField('Favorite Quotes', _favoriteQuotesController),
                      _buildProfileField('Badges', badges),
                    ],
                  ),
                  const Divider(),
                  _buildCategoryHeader('Social Links'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialLinkIcon('Instagram', _instagramController, 'assets/instagram.png'),
                      _buildSocialLinkIcon('Facebook', _facebookController, 'assets/facebook.png'),
                      _buildSocialLinkIcon('LinkedIn', _linkedinController, 'assets/linkedin.png'),
                      _buildSocialLinkIcon('Snapchat', _snapchatController, 'assets/snapchat.png'),
                    ],
                  ),
                  if (memberOf.isNotEmpty) ...[
                    const Divider(),
                    _buildCategoryHeader('Committee Biography'),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: _buildCommitteeBiographyFields(memberOf),
                    ),
                  ],
                ],
              ),
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

  Widget _buildEditableProfileField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          _isEditing
              ? TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  ),
                  keyboardType: keyboardType,
                  minLines: 1,
                  maxLines: null, // Allow the field to expand vertically
                  validator: (value) {
                    return null; // No validation for optional fields
                  },
                )
              : Text(
                  controller.text,
                  style: const TextStyle(fontSize: 16),
                ),
        ],
      ),
    );
  }

  List<Widget> _buildCommitteeBiographyFields(List<dynamic> committees) {
    List<Widget> fields = [];
    for (int i = 0; i < committees.length; i += 2) {
      fields.add(Row(
        children: [
          Expanded(child: _buildCommitteeBiographyField(committees[i])),
          if (i + 1 < committees.length) Expanded(child: _buildCommitteeBiographyField(committees[i + 1])),
        ],
      ));
    }
    return fields;
  }

  Widget _buildCommitteeBiographyField(String committee) {
    final controller = _committeeControllers[committee];
    return _buildEditableProfileField(committee, controller!);
  }

  Widget _buildSocialLinkIcon(String label, TextEditingController controller, String iconPath) {
    return Column(
      children: [
        GestureDetector(
          onTap: _isEditing
              ? null
              : () async {
                  final url = controller.text;
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
        _isEditing
            ? SizedBox(
                width: 80,
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter $label URL';
                    }
                    return null;
                  },
                ),
              )
            : Container(), 
      ],
    );
  }
}
